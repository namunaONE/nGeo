import json, math, os, sys, csv
from collections import Counter, OrderedDict
from functools import lru_cache

import matplotlib
matplotlib.use('Agg')
matplotlib.rcParams['pdf.fonttype'] = 42
matplotlib.rcParams['ps.fonttype'] = 42
import matplotlib.pyplot as plt
import matplotlib.patheffects as pe
from matplotlib.collections import PolyCollection
from matplotlib.patches import Rectangle, Polygon, FancyArrow
from matplotlib.textpath import TextPath
from matplotlib.font_manager import FontProperties
from matplotlib.backends.backend_pdf import PdfPages
from matplotlib.transforms import Bbox

# -----------------------------------------------------------------------------
# Projection: Albers equal-area, parameters suited to Nepal.
# -----------------------------------------------------------------------------
R = 6371.0
LON0, LAT0, SP1, SP2 = 84.1, 28.4, 27.0, 30.0
N_ALB = (math.sin(math.radians(SP1)) + math.sin(math.radians(SP2))) / 2.0
C_ALB = math.cos(math.radians(SP1)) ** 2 + 2 * N_ALB * math.sin(math.radians(SP1))
RHO0 = math.sqrt(C_ALB - 2 * N_ALB * math.sin(math.radians(LAT0))) / N_ALB


def albers(lon, lat):
    rho = math.sqrt(C_ALB - 2 * N_ALB * math.sin(math.radians(lat))) / N_ALB
    theta = N_ALB * math.radians(lon - LON0)
    return R * rho * math.sin(theta), R * (RHO0 - rho * math.cos(theta))


def albers_inv(x, y):
    xr, yr = x / R, y / R
    rho = math.hypot(xr, RHO0 - yr)
    theta = math.atan2(xr, RHO0 - yr)
    lat = math.degrees(math.asin((C_ALB - (rho * N_ALB) ** 2) / (2 * N_ALB)))
    lon = LON0 + math.degrees(theta / N_ALB)
    return lon, lat


# -----------------------------------------------------------------------------
# Geometry helpers
# -----------------------------------------------------------------------------
def rdp(points, eps):
    """Douglas-Peucker simplification for an open polyline."""
    if len(points) < 3:
        return points
    # iterative stack version
    keep = [False] * len(points)
    keep[0] = keep[-1] = True
    stack = [(0, len(points) - 1)]
    while stack:
        a, b = stack.pop()
        if b <= a + 1:
            continue
        x0, y0 = points[a]
        x1, y1 = points[b]
        dx, dy = x1 - x0, y1 - y0
        norm = math.hypot(dx, dy)
        best_i, best_d = -1, -1.0
        for i in range(a + 1, b):
            px, py = points[i]
            if norm < 1e-12:
                d = math.hypot(px - x0, py - y0)
            else:
                d = abs(dy * px - dx * py + x1 * y0 - y1 * x0) / norm
            if d > best_d:
                best_d, best_i = d, i
        if best_d > eps and best_i != -1:
            keep[best_i] = True
            stack.append((a, best_i))
            stack.append((best_i, b))
    return [p for p, k in zip(points, keep) if k]


def project_ring(coords, eps=0.045):
    pts = [albers(x, y) for x, y in coords]
    if len(pts) < 4:
        return pts
    if pts[0] != pts[-1]:
        pts.append(pts[0])
    out = rdp(pts, eps)
    if len(out) < 4:
        out = pts
    if out[0] != out[-1]:
        out.append(out[0])
    return out


def ring_area(ring):
    a = 0.0
    for i in range(len(ring) - 1):
        x0, y0 = ring[i]
        x1, y1 = ring[i + 1]
        a += x0 * y1 - x1 * y0
    return a / 2.0


def polygons_of(geom):
    if geom['type'] == 'Polygon':
        return [geom['coordinates']]
    if geom['type'] == 'MultiPolygon':
        return geom['coordinates']
    return []


# -----------------------------------------------------------------------------
# Data loading
# -----------------------------------------------------------------------------
HERE = os.path.dirname(os.path.abspath(__file__))
DATA = os.path.join(HERE, 'maps', 'nepal_local_levels_coded.geojson')
GEO_RAW = os.path.join(HERE, '_geo', 'suraj_municipality.geojson')

PROV_META = OrderedDict([
    ('1', dict(name='Koshi Province', short='Koshi', slug='koshi', roman='Pradesh 1')),
    ('2', dict(name='Madhesh Province', short='Madhesh', slug='madhesh', roman='Pradesh 2')),
    ('3', dict(name='Bagmati Province', short='Bagmati', slug='bagmati', roman='Pradesh 3')),
    ('4', dict(name='Gandaki Province', short='Gandaki', slug='gandaki', roman='Pradesh 4')),
    ('5', dict(name='Lumbini Province', short='Lumbini', slug='lumbini', roman='Pradesh 5')),
    ('6', dict(name='Karnali Province', short='Karnali', slug='karnali', roman='Pradesh 6')),
    ('7', dict(name='Sudurpashchim Province', short='Sudurpashchim', slug='sudurpashchim', roman='Pradesh 7')),
])

PALETTE = [
    '#F7E3B5', '#DDEBC8', '#CFE3F2', '#F3D6E1', '#E2D9F0', '#F6D8C4',
    '#D7EFEA', '#EDE2C4', '#E8F0C8', '#D9E2F5', '#F1D9D0', '#E6E0F8',
    '#DCEBDD', '#F5E6A8',
]
PROV_PALETTE = ['#F5E0B3', '#D7E8C4', '#C9DFF2', '#F4D2DF', '#DED4F2', '#F6D4BE', '#D2EDE7']
INK = '#1F2937'
MUTED = '#6B7280'
ACCENT = '#B91C1C'
GRID = '#E5E7EB'
PANEL = '#F8FAFC'
PROTECTED_COLOR = '#E9E5DA'

FP_REG = FontProperties(family='DejaVu Sans')
FP_BOLD = FontProperties(family='DejaVu Sans', weight='bold')


@lru_cache(maxsize=4096)
def text_width(s, fs, bold=False):
    if not s:
        return 0.0
    tp = TextPath((0, 0), s, size=fs, prop=FP_BOLD if bold else FP_REG)
    return tp.get_extents().width


def load_units():
    gj = json.load(open(DATA, encoding='utf-8'))
    units = []
    for f in gj['features']:
        p = f['properties']
        rings = []
        areas = []
        for poly in polygons_of(f['geometry']):
            if not poly:
                continue
            ring = project_ring(poly[0])
            if len(ring) >= 4:
                rings.append(ring)
                areas.append(abs(ring_area(ring)))
        if not rings:
            continue
        anchor = albers(p['label_lon'], p['label_lat'])
        units.append(dict(
            code=p['code'], prov=str(p['province_code']), dist=p['district_name'],
            dist_code=str(p['district_code']), name=p['local_unit_short'],
            full=p['local_unit'], np=p['local_unit_np'], utype=p['unit_type'],
            rings=rings, area=sum(areas), anchor=anchor, parts=len(rings),
        ))
    return units


def load_protected():
    """Protected-area polygons from the raw boundaries, for context only."""
    gj = json.load(open(GEO_RAW, encoding='utf-8'))
    out = []
    for f in gj['features']:
        p = f['properties']
        if p.get('municipality_code'):
            continue
        rings = []
        for poly in polygons_of(f['geometry']):
            if not poly:
                continue
            ring = project_ring(poly[0], eps=0.06)
            if len(ring) >= 4:
                rings.append(ring)
        if rings:
            out.append(dict(name=p.get('GaPa_NaPa', 'Protected area'), rings=rings))
    return out


def load_shapes(path):
    gj = json.load(open(path, encoding='utf-8'))
    out = []
    for f in gj['features']:
        rings = []
        for poly in polygons_of(f['geometry']):
            if not poly:
                continue
            ring = project_ring(poly[0], eps=0.06)
            if len(ring) >= 4:
                rings.append(ring)
        out.append(dict(props=f['properties'], rings=rings))
    return out


UNITS = load_units()
PROTECTED_AREAS = load_protected()
DISTRICTS = {k: load_shapes(os.path.join(HERE, '_geo', f'district_{v["slug"]}.geojson')) for k, v in PROV_META.items()}
PROVINCES = load_shapes(os.path.join(HERE, '_geo', 'province_nepal.geojson'))


def province_area(pcode):
    """Total mapped province area in km² (includes protected-area gaps)."""
    p = next((p for p in PROVINCES if str(p['props'].get('PROVINCE')) == str(pcode)), None)
    if not p:
        return sum(u['area'] for u in UNITS if u['prov'] == str(pcode))
    return sum(abs(ring_area(r)) for r in p['rings'])

# -----------------------------------------------------------------------------
# Drawing primitives
# -----------------------------------------------------------------------------
def bbox_of_rings(rings):
    xs = [x for r in rings for x, _ in r]
    ys = [y for r in rings for _, y in r]
    return min(xs), min(ys), max(xs), max(ys)


def draw_polygons(ax, rings_list, facecolor, edgecolor, lw, zorder, alpha=1.0, hatch=None):
    if not rings_list:
        return
    n = len(rings_list)
    fc = [facecolor] * n if isinstance(facecolor, str) else facecolor
    ec = [edgecolor] * n if isinstance(edgecolor, str) else edgecolor
    pc = PolyCollection(
        rings_list, facecolors=fc, edgecolors=ec,
        linewidths=lw, zorder=zorder, alpha=alpha, hatch=hatch,
        joinstyle='round',
    )
    ax.add_collection(pc)


def add_panel(fig, x, y, w, h):
    rect = Rectangle((x, y), w, h, transform=fig.transFigure,
                     facecolor=PANEL, edgecolor=GRID, linewidth=0.7, zorder=-1)
    fig.patches.append(rect)


def add_header(fig, title, subtitle, series='NEPAL LOCAL LEVEL ATLAS'):
    fig.text(0.035, 0.975, series, fontsize=7.2, color=ACCENT,
             fontproperties=FP_BOLD, ha='left', va='top')
    fig.text(0.035, 0.947, title, fontsize=25, color=INK,
             fontproperties=FP_BOLD, ha='left', va='top')
    fig.text(0.035, 0.909, subtitle, fontsize=9.2, color=MUTED,
             fontproperties=FP_REG, ha='left', va='top')
    line = plt.Line2D([0.035, 0.965], [0.895, 0.895], transform=fig.transFigure,
                      color=ACCENT, linewidth=1.15, solid_capstyle='butt')
    fig.add_artist(line)


def add_footer(fig, left, right):
    fig.text(0.035, 0.024, left, fontsize=6.2, color=MUTED, ha='left', va='bottom')
    fig.text(0.965, 0.024, right, fontsize=6.2, color=MUTED, ha='right', va='bottom')


def add_north_arrow(ax):
    ax.text(0.955, 0.972, 'N', transform=ax.transAxes, ha='center', va='top',
            fontsize=8.5, fontproperties=FP_BOLD, color=INK, zorder=20)
    arrow = FancyArrow(0.955, 0.875, 0, 0.075, width=0.0032,
                       head_width=0.019, head_length=0.028,
                       length_includes_head=True, color=INK,
                       transform=ax.transAxes, zorder=20)
    ax.add_patch(arrow)
    # white right half for a compass-like look
    ax.add_patch(Polygon([[0.955, 0.875], [0.955, 0.950], [0.9645, 0.9225]],
                         closed=True, transform=ax.transAxes,
                         facecolor='white', edgecolor='none', zorder=21))


def add_scale_bar(ax, xmin, xmax):
    width_km = xmax - xmin
    target = width_km * 0.17
    choices = [10, 20, 50, 100, 150, 200]
    length = min(choices, key=lambda v: abs(v - target))
    frac = length / width_km
    x0, y0 = 0.042, 0.048
    h = 0.007
    # halo
    ax.add_patch(Rectangle((x0 - 0.012, y0 - 0.036), frac + 0.055, 0.075,
                           transform=ax.transAxes, facecolor='white',
                           edgecolor='none', alpha=0.82, zorder=15))
    seg = frac / 2
    ax.add_patch(Rectangle((x0, y0), seg, h, transform=ax.transAxes,
                           facecolor=INK, edgecolor=INK, lw=0.4, zorder=16))
    ax.add_patch(Rectangle((x0 + seg, y0), seg, h, transform=ax.transAxes,
                           facecolor='white', edgecolor=INK, lw=0.4, zorder=16))
    for xx, lab in [(x0, '0'), (x0 + seg, f'{length/2:g}'), (x0 + frac, f'{length} km')]:
        ax.text(xx, y0 - 0.011, lab, transform=ax.transAxes, ha='center', va='top',
                fontsize=6.0, color=INK, zorder=17)


def point_in_ring(x, y, ring):
    inside = False
    j = len(ring) - 1
    for i in range(len(ring)):
        xi, yi = ring[i]
        xj, yj = ring[j]
        if ((yi > y) != (yj > y)) and (x < (xj - xi) * (y - yi) / (yj - yi) + xi):
            inside = not inside
        j = i
    return inside


def interior_point(ring, cx, cy):
    if point_in_ring(cx, cy, ring):
        return cx, cy
    xs = []
    for i in range(len(ring) - 1):
        x0, y0 = ring[i]
        x1, y1 = ring[i + 1]
        if (y0 > cy) != (y1 > cy):
            xs.append(x0 + (cy - y0) * (x1 - x0) / (y1 - y0))
    xs.sort()
    best = None
    for i in range(0, len(xs) - 1, 2):
        w = xs[i + 1] - xs[i]
        if best is None or w > best[0]:
            best = (w, (xs[i] + xs[i + 1]) / 2)
    if best:
        return best[1], cy
    return sum(p[0] for p in ring) / len(ring), sum(p[1] for p in ring) / len(ring)


def label_anchor(unit):
    # use the largest ring and a point guaranteed inside it
    ring = max(unit['rings'], key=lambda r: abs(ring_area(r)))
    a = abs(ring_area(ring))
    cx = cy = 0.0
    if a > 1e-9:
        for i in range(len(ring) - 1):
            x0, y0 = ring[i]
            x1, y1 = ring[i + 1]
            cr = x0 * y1 - x1 * y0
            cx += (x0 + x1) * cr
            cy += (y0 + y1) * cr
        cx /= 6 * (a if ring_area(ring) > 0 else -a)
        cy /= 6 * (a if ring_area(ring) > 0 else -a)
    else:
        cx, cy = unit['anchor']
    return interior_point(ring, cx, cy)


# -----------------------------------------------------------------------------
# Label layout
# -----------------------------------------------------------------------------
def wrap_name(name, fs, maxw):
    words = name.split()
    if not words:
        return [name]
    lines, cur = [], ''
    for w in words:
        trial = (cur + ' ' + w).strip()
        if cur and text_width(trial, fs) > maxw:
            lines.append(cur)
            cur = w
        else:
            cur = trial
    if cur:
        lines.append(cur)
    if len(lines) > 2:
        # merge the smallest adjacent pair until two lines remain
        while len(lines) > 2:
            best_i, best_w = 0, None
            for i in range(len(lines) - 1):
                w = text_width(lines[i] + ' ' + lines[i + 1], fs)
                if best_w is None or w < best_w:
                    best_w, best_i = w, i
            lines[best_i:best_i + 2] = [lines[best_i] + ' ' + lines[best_i + 1]]
    return lines


def label_metrics(unit, fs, maxw):
    lines = wrap_name(unit['name'], fs, maxw)
    wcode = text_width(unit['code'], fs, bold=True)
    wname = max(text_width(s, fs) for s in lines)
    w = max(wcode, wname)
    h = fs * 1.05 + len(lines) * fs * 1.12
    return lines, w, h


def place_labels(ax, units, fig, base_fs, maxw, color_code='#7F1D1D', color_name='#111827'):
    fig.canvas.draw()
    ren = fig.canvas.get_renderer()
    axbb = ax.get_window_extent(ren)
    inv = ax.transData.inverted()

    def to_pts(x, y):
        px, py = ax.transData.transform((x, y))
        return px * 72.0 / fig.dpi, py * 72.0 / fig.dpi

    ax_x0 = axbb.x0 * 72.0 / fig.dpi
    ax_y0 = axbb.y0 * 72.0 / fig.dpi
    ax_x1 = axbb.x1 * 72.0 / fig.dpi
    ax_y1 = axbb.y1 * 72.0 / fig.dpi

    placed = []
    overlaps = 0
    offset_sets = [
        (0, 0),
        (0, 7), (0, -7), (9, 0), (-9, 0),
        (7, 7), (-7, 7), (7, -7), (-7, -7),
        (0, 14), (0, -14), (16, 0), (-16, 0),
        (13, 12), (-13, 12), (13, -12), (-13, -12),
        (0, 22), (0, -22), (24, 0), (-24, 0),
        (19, 19), (-19, 19), (19, -19), (-19, -19),
        (0, 31), (0, -31), (34, 0), (-34, 0),
        (0, 39), (0, -39), (43, 0), (-43, 0),
        (32, 31), (-32, 31), (32, -31), (-32, -31),
        (0, 49), (0, -49), (53, 0), (-53, 0),
        (43, 41), (-43, 41), (43, -41), (-43, -41),
    ]

    # Small polygons first: they have the least room near their centroid.
    ordered = sorted(units, key=lambda u: u['area'])
    for u in ordered:
        anchor = label_anchor(u)
        ax_pt, ay_pt = to_pts(*anchor)
        placed_here = False
        for fs in [base_fs, base_fs - 0.25, base_fs - 0.5, 2.55]:
            lines, w, h = label_metrics(u, fs, maxw)
            best = None
            for dx, dy in offset_sets:
                x0 = ax_pt + dx - w / 2 - 0.9
                x1 = ax_pt + dx + w / 2 + 0.9
                y0 = ay_pt + dy - h / 2 - 0.8
                y1 = ay_pt + dy + h / 2 + 0.8
                if x0 < ax_x0 + 3.8 or x1 > ax_x1 - 3.8 or y0 < ax_y0 + 3.8 or y1 > ax_y1 - 3.8:
                    continue
                hit = False
                for px0, py0, px1, py1 in placed:
                    if x0 < px1 and x1 > px0 and y0 < py1 and y1 > py0:
                        hit = True
                        break
                if not hit:
                    best = (dx, dy, x0, y0, x1, y1, lines, fs, w, h)
                    break
            if best:
                placed_here = True
                break
        if not placed_here:
            # last resort: centroid, base font
            lines, w, h = label_metrics(u, base_fs, maxw)
            dx = dy = 0
            x0, y0, x1, y1 = ax_pt - w/2, ay_pt - h/2, ax_pt + w/2, ay_pt + h/2
            best = (dx, dy, x0, y0, x1, y1, lines, base_fs, w, h)
            overlaps += 1

        dx, dy, x0, y0, x1, y1, lines, fs, w, h = best
        placed.append((x0, y0, x1, y1))

        # leader line for displaced labels
        if abs(dx) > 5 or abs(dy) > 5:
            ex = min(max(ax_pt, x0), x1)
            ey = min(max(ay_pt, y0), y1)
            p0 = inv.transform((ax_pt * fig.dpi / 72.0, ay_pt * fig.dpi / 72.0))
            p1 = inv.transform((ex * fig.dpi / 72.0, ey * fig.dpi / 72.0))
            ax.plot([p0[0], p1[0]], [p0[1], p1[1]], color='#6B7280', lw=0.28,
                    zorder=5, solid_capstyle='round', alpha=0.75)

        ch = fs * 1.05
        nh = len(lines) * fs * 1.12
        total = ch + nh
        code_y = dy + total / 2 - ch / 2
        name_y = dy + total / 2 - ch - nh / 2

        box = dict(facecolor='white', edgecolor='none', alpha=0.38, pad=0.02)
        ax.annotate(u['code'], xy=anchor, xytext=(dx, code_y), textcoords='offset points',
                    ha='center', va='center', fontsize=fs, color=color_code,
                    fontproperties=FP_BOLD, zorder=7, bbox=box)
        ax.annotate('\n'.join(lines), xy=anchor, xytext=(dx, name_y), textcoords='offset points',
                    ha='center', va='center', fontsize=fs, color=color_name,
                    fontproperties=FP_REG, linespacing=1.02, zorder=7, bbox=box)
    return overlaps


# -----------------------------------------------------------------------------
# Page builders
# -----------------------------------------------------------------------------
PROV_FS = {'1': 5.0, '2': 3.9, '3': 4.15, '4': 5.0, '5': 4.5, '6': 5.4, '7': 5.4}
PROV_MAXW = {'1': 56, '2': 39, '3': 44, '4': 54, '5': 48, '6': 58, '7': 58}


def render_province(pcode, page_no, total_pages):
    meta = PROV_META[pcode]
    units = [u for u in UNITS if u['prov'] == pcode]
    dists = sorted({u['dist'] for u in units})
    dcode = {d: min(u['dist_code'] for u in units if u['dist'] == d) for d in dists}
    dists.sort(key=lambda d: dcode[d])
    colors = {d: PALETTE[i % len(PALETTE)] for i, d in enumerate(dists)}

    fig = plt.figure(figsize=(16.54, 11.69), facecolor='white')
    ax = fig.add_axes([0.035, 0.072, 0.665, 0.805])
    ax.set_facecolor('#FBFCFD')
    ax.set_aspect('equal', adjustable='box')

    # frame / extents from the province outline
    shape = [p for p in PROVINCES if str(p['props'].get('PROVINCE')) == pcode]
    base_rings = [r for p in shape for r in p['rings']]
    if not base_rings:
        base_rings = [r for u in units for r in u['rings']]
    xmin, ymin, xmax, ymax = bbox_of_rings(base_rings)
    pad = max(xmax - xmin, ymax - ymin) * 0.035
    ax.set_xlim(xmin - pad, xmax + pad)
    ax.set_ylim(ymin - pad, ymax + pad)

    # protected areas under the units
    p_rings = [r for p in PROTECTED_AREAS for r in p['rings']]
    draw_polygons(ax, p_rings, PROTECTED_COLOR, '#C9C2B2', 0.25, 1, alpha=1.0)

    # local units
    for u in units:
        draw_polygons(ax, u['rings'], colors[u['dist']], 'white', 0.32, 2)

    # district outlines
    d_rings = [r for d in DISTRICTS[pcode] for r in d['rings']]
    draw_polygons(ax, d_rings, 'none', '#4B5563', 0.85, 3)

    # province outline
    draw_polygons(ax, base_rings, 'none', '#111827', 1.5, 4)

    # map frame
    ax.add_patch(Rectangle((0, 0), 1, 1, transform=ax.transAxes, facecolor='none',
                           edgecolor='#D1D5DB', linewidth=0.6, zorder=25))
    ax.set_xticks([]); ax.set_yticks([])
    for sp in ax.spines.values():
        sp.set_visible(False)

    add_north_arrow(ax)
    add_scale_bar(ax, xmin - pad, xmax + pad)

    # labels
    ov = place_labels(ax, units, fig, PROV_FS[pcode], PROV_MAXW[pcode])
    if ov:
        print(f'  province {pcode}: {ov} labels could not be placed without overlap', file=sys.stderr)

    # header
    n_rural = sum(1 for u in units if u['utype'] == 'Rural Municipality')
    n_urban = sum(1 for u in units if u['utype'] == 'Urban Municipality')
    n_sub = sum(1 for u in units if u['utype'] == 'Sub-Metropolitan City')
    n_metro = sum(1 for u in units if u['utype'] == 'Metropolitan City')
    area = province_area(pcode)
    add_header(
        fig,
        f'{meta["short"].upper()} PROVINCE',
        f'Local levels of Nepal  ·  {len(units)} units in {len(dists)} districts  ·  {area:,.0f} km²',
    )

    # sidebar
    add_panel(fig, 0.712, 0.058, 0.253, 0.815)
    px, pw = 0.728, 0.222
    fig.text(px, 0.840, 'DISTRICTS', fontsize=7.6, color=MUTED,
             fontproperties=FP_BOLD, ha='left', va='top')
    # thin rule
    fig.add_artist(plt.Line2D([px, px + pw], [0.828, 0.828], transform=fig.transFigure,
                              color=GRID, linewidth=0.8))
    row_y = 0.806
    step = 0.0335 if len(dists) > 10 else 0.039
    for d in dists:
        n = sum(1 for u in units if u['dist'] == d)
        fig.add_artist(Rectangle((px, row_y - 0.0108), 0.0165, 0.0115,
                                 transform=fig.transFigure, facecolor=colors[d],
                                 edgecolor='#9CA3AF', linewidth=0.35))
        fig.text(px + 0.022, row_y, d, fontsize=7.1, color=INK,
                 fontproperties=FP_REG, ha='left', va='center')
        fig.text(px + pw, row_y, str(n), fontsize=7.1, color=MUTED,
                 fontproperties=FP_REG, ha='right', va='center')
        row_y -= step

    # summary block
    sy = row_y - 0.035
    fig.add_artist(plt.Line2D([px, px + pw], [sy + 0.027, sy + 0.027], transform=fig.transFigure,
                              color=GRID, linewidth=0.8))
    fig.text(px, sy, str(len(units)), fontsize=24, color=ACCENT,
             fontproperties=FP_BOLD, ha='left', va='top')
    fig.text(px + 0.060, sy - 0.002, 'LOCAL\nUNITS', fontsize=7.2, color=MUTED,
             fontproperties=FP_BOLD, ha='left', va='top', linespacing=1.05)

    line_y = sy - 0.070
    fig.text(px, line_y,
             f'{n_rural} rural  ·  {n_urban} urban',
             fontsize=6.8, color=INK, ha='left', va='top')
    fig.text(px, line_y - 0.020,
             f'{n_sub} sub-metropolitan  ·  {n_metro} metropolitan',
             fontsize=6.8, color=INK, ha='left', va='top')

    # boundary key
    ky = 0.150
    fig.text(px, ky, 'BOUNDARIES', fontsize=6.4, color=MUTED,
             fontproperties=FP_BOLD, ha='left', va='top')
    keys = [
        ('Province', '#111827', 1.5),
        ('District', '#4B5563', 0.9),
        ('Local unit', '#FFFFFF', 1.8),
    ]
    yy = ky - 0.020
    for lab, col, lw in keys:
        fig.add_artist(plt.Line2D([px, px + 0.023], [yy, yy], transform=fig.transFigure,
                                  color=col if col != '#FFFFFF' else '#9CA3AF',
                                  linewidth=lw, solid_capstyle='butt'))
        fig.text(px + 0.030, yy, lab, fontsize=6.2, color=INK, ha='left', va='center')
        yy -= 0.017
    # protected swatch
    fig.add_artist(Rectangle((px, yy - 0.005), 0.022, 0.009, transform=fig.transFigure,
                             facecolor=PROTECTED_COLOR, edgecolor='#C9C2B2', linewidth=0.35))
    fig.text(px + 0.030, yy, 'Protected area', fontsize=6.2, color=INK, ha='left', va='center')

    add_footer(
        fig,
        'Boundaries: Open Knowledge Nepal, localboundaries (CC BY 4.0)  ·  Codes and names: 1695378470_83.xls',
        f'Province {pcode} of 7  ·  page {page_no} of {total_pages}',
    )
    return fig


def _norm_dname(s):
    s = s.upper()
    s = {'DHANUSHA': 'DHANUSA', 'KABHREPALANCHOK': 'KAVREPALANCHOK'}.get(s, s)
    return ''.join(ch for ch in s if ch.isalpha())


def render_province_panels(pcode, page_no, total_pages):
    """Province 2 is a long, narrow strip: use one panel per district."""
    meta = PROV_META[pcode]
    units = [u for u in UNITS if u['prov'] == pcode]
    dists_all = sorted({u['dist'] for u in units},
                       key=lambda d: min(u['dist_code'] for u in units if u['dist'] == d))
    # West -> east for the panel sequence; colours stay keyed to the district.
    dists = list(reversed(dists_all))
    colors = {d: PALETTE[i % len(PALETTE)] for i, d in enumerate(dists_all)}
    dnum = {d: i + 1 for i, d in enumerate(dists)}

    shape_by_name = {}
    for sh in DISTRICTS[pcode]:
        shape_by_name[_norm_dname(sh['props'].get('DISTRICT', ''))] = sh

    fig = plt.figure(figsize=(16.54, 11.69), facecolor='white')
    add_header(
        fig,
        f'{meta["short"].upper()} PROVINCE',
        f'District panels, west → east  ·  {len(units)} units in {len(dists)} districts  ·  '
        f'{province_area(pcode):,.0f} km²',
    )

    AX0, AY0 = 0.035, 0.073
    AW, AH = 0.655, 0.795
    COLS, ROWS = 4, 2
    GX, GY = 0.012, 0.017
    PW = (AW - (COLS - 1) * GX) / COLS
    PH = (AH - (ROWS - 1) * GY) / ROWS

    total_overlap = 0
    for idx, d in enumerate(dists):
        col, row = idx % COLS, idx // COLS
        x0 = AX0 + col * (PW + GX)
        y0 = AY0 + (ROWS - 1 - row) * (PH + GY)
        dunits = [u for u in units if u['dist'] == d]
        sh = shape_by_name.get(_norm_dname(d))
        if sh is None:
            print('missing district shape', d, file=sys.stderr)
            continue

        # panel frame and title
        fig.add_artist(Rectangle((x0, y0), PW, PH, transform=fig.transFigure,
                                 facecolor='white', edgecolor='#D1D5DB', linewidth=0.6, zorder=0))
        fig.add_artist(Rectangle((x0 + 0.0048, y0 + PH - 0.021), 0.0105, 0.0095,
                                 transform=fig.transFigure, facecolor=colors[d],
                                 edgecolor='#9CA3AF', linewidth=0.3, zorder=3))
        fig.text(x0 + 0.019, y0 + PH - 0.0125, f'{dnum[d]:02d}  {d.upper()}',
                 fontsize=7.0, color=INK, fontproperties=FP_BOLD, ha='left', va='center')
        fig.text(x0 + PW - 0.006, y0 + PH - 0.0125, f'{len(dunits)} units',
                 fontsize=6.2, color=MUTED, ha='right', va='center')
        fig.add_artist(plt.Line2D([x0 + 0.004, x0 + PW - 0.004],
                                  [y0 + PH - 0.025, y0 + PH - 0.025],
                                  transform=fig.transFigure, color=GRID, linewidth=0.7))

        ax = fig.add_axes([x0 + 0.004, y0 + 0.005, PW - 0.008, PH - 0.034])
        ax.set_facecolor('#FBFCFD')
        ax.set_aspect('equal', adjustable='box')
        xmin, ymin, xmax, ymax = bbox_of_rings(sh['rings'])
        pad = max(xmax - xmin, ymax - ymin) * 0.035
        ax.set_xlim(xmin - pad, xmax + pad)
        ax.set_ylim(ymin - pad, ymax + pad)
        ax.set_xticks([]); ax.set_yticks([])
        for sp in ax.spines.values():
            sp.set_visible(False)

        # protected areas, units, district outline
        prects = [r for p in PROTECTED_AREAS for r in p['rings']]
        draw_polygons(ax, prects, PROTECTED_COLOR, '#C9C2B2', 0.2, 1)
        for u in dunits:
            draw_polygons(ax, u['rings'], colors[d], 'white', 0.4, 2)
        draw_polygons(ax, sh['rings'], 'none', '#111827', 1.1, 3)
        ax.add_patch(Rectangle((0, 0), 1, 1, transform=ax.transAxes, facecolor='none',
                               edgecolor='#E5E7EB', linewidth=0.5, zorder=20))

        ov = place_labels(ax, dunits, fig, 5.35, 62, color_code='#7F1D1D', color_name='#111827')
        total_overlap += ov

    # sidebar
    add_panel(fig, 0.705, 0.058, 0.260, 0.815)
    px, pw = 0.722, 0.226

    # locator
    fig.text(px, 0.842, 'DISTRICT LOCATOR', fontsize=7.2, color=MUTED,
             fontproperties=FP_BOLD, ha='left', va='top')
    lax = fig.add_axes([px, 0.675, pw, 0.145])
    lax.set_facecolor(PANEL)
    lax.set_aspect('equal', adjustable='box')
    prov = next((p for p in PROVINCES if str(p['props'].get('PROVINCE')) == pcode), None)
    if prov:
        xmin, ymin, xmax, ymax = bbox_of_rings(prov['rings'])
        pad = max(xmax - xmin, ymax - ymin) * 0.04
        lax.set_xlim(xmin - pad, xmax + pad)
        lax.set_ylim(ymin - pad, ymax + pad)
    for d in dists:
        sh = shape_by_name.get(_norm_dname(d))
        if not sh:
            continue
        draw_polygons(lax, sh['rings'], colors[d], 'white', 0.35, 2)
        ring = max(sh['rings'], key=lambda r: abs(ring_area(r)))
        a = abs(ring_area(ring)); cx = cy = 0.0
        if a > 1e-9:
            for j in range(len(ring) - 1):
                xx0, yy0 = ring[j]; xx1, yy1 = ring[j + 1]
                cr = xx0 * yy1 - xx1 * yy0
                cx += (xx0 + xx1) * cr; cy += (yy0 + yy1) * cr
            sgn = 1 if ring_area(ring) > 0 else -1
            cx /= 6 * a * sgn; cy /= 6 * a * sgn
        qx, qy = interior_point(ring, cx, cy)
        lax.text(qx, qy, str(dnum[d]), fontsize=5.8, color=INK, ha='center', va='center',
                 fontproperties=FP_BOLD, zorder=5,
                 path_effects=[pe.withStroke(linewidth=1.6, foreground='white', alpha=0.95)])
    draw_polygons(lax, prov['rings'] if prov else [], 'none', '#111827', 1.0, 4)
    lax.set_xticks([]); lax.set_yticks([])
    for sp in lax.spines.values():
        sp.set_visible(False)

    # district list
    row_y = 0.630
    fig.add_artist(plt.Line2D([px, px + pw], [0.648, 0.648], transform=fig.transFigure,
                              color=GRID, linewidth=0.8))
    for d in dists:
        n = sum(1 for u in units if u['dist'] == d)
        fig.add_artist(Rectangle((px, row_y - 0.0105), 0.0155, 0.011,
                                 transform=fig.transFigure, facecolor=colors[d],
                                 edgecolor='#9CA3AF', linewidth=0.3))
        fig.text(px + 0.021, row_y, f'{dnum[d]:02d}', fontsize=6.3, color=MUTED,
                 ha='left', va='center')
        fig.text(px + 0.040, row_y, d, fontsize=6.9, color=INK, ha='left', va='center')
        fig.text(px + pw, row_y, str(n), fontsize=6.9, color=MUTED, ha='right', va='center')
        row_y -= 0.0325

    # summary
    n_rural = sum(1 for u in units if u['utype'] == 'Rural Municipality')
    n_urban = sum(1 for u in units if u['utype'] == 'Urban Municipality')
    n_sub = sum(1 for u in units if u['utype'] == 'Sub-Metropolitan City')
    n_metro = sum(1 for u in units if u['utype'] == 'Metropolitan City')
    sy = 0.322
    fig.add_artist(plt.Line2D([px, px + pw], [sy + 0.032, sy + 0.032], transform=fig.transFigure,
                              color=GRID, linewidth=0.8))
    fig.text(px, sy, str(len(units)), fontsize=24, color=ACCENT, fontproperties=FP_BOLD, ha='left', va='top')
    fig.text(px + 0.060, sy - 0.002, 'LOCAL\nUNITS', fontsize=7.0, color=MUTED,
             fontproperties=FP_BOLD, ha='left', va='top', linespacing=1.05)
    fig.text(px, sy - 0.062, f'{n_rural} rural  ·  {n_urban} urban', fontsize=6.7, color=INK, ha='left', va='top')
    fig.text(px, sy - 0.081, f'{n_sub} sub-metropolitan  ·  {n_metro} metropolitan', fontsize=6.7, color=INK, ha='left', va='top')

    # type legend
    ty = 0.205
    fig.text(px, ty, 'UNIT TYPE', fontsize=6.2, color=MUTED, fontproperties=FP_BOLD, ha='left', va='top')
    types = [
        ('Rural municipality', '#DDEBC8', n_rural),
        ('Urban municipality', '#F6D8C4', n_urban),
        ('Sub-metropolitan', '#E2D9F0', n_sub),
        ('Metropolitan', '#F3D6E1', n_metro),
    ]
    yy = ty - 0.019
    for lab, col, n in types:
        fig.add_artist(Rectangle((px, yy - 0.005), 0.017, 0.0095, transform=fig.transFigure,
                                 facecolor=col, edgecolor='#9CA3AF', linewidth=0.3))
        fig.text(px + 0.023, yy, lab, fontsize=6.1, color=INK, ha='left', va='center')
        fig.text(px + pw, yy, str(n), fontsize=6.1, color=MUTED, ha='right', va='center')
        yy -= 0.0165

    fig.text(px, 0.085,
             'Panels run west to east, top row then bottom row.\n'
             'Numbers match the district locator.',
             fontsize=5.9, color=MUTED, ha='left', va='top', linespacing=1.35)

    add_footer(
        fig,
        'Boundaries: Open Knowledge Nepal, localboundaries (CC BY 4.0)  ·  Codes and names: 1695378470_83.xls',
        f'Province 2 of 7  ·  page {page_no} of {total_pages}',
    )
    if total_overlap:
        print(f'  province {pcode} panels: {total_overlap} labels could not be placed without overlap', file=sys.stderr)
    return fig


def render_overview(page_no, total_pages):
    fig = plt.figure(figsize=(16.54, 11.69), facecolor='white')
    ax = fig.add_axes([0.035, 0.075, 0.655, 0.795])
    ax.set_facecolor('#FBFCFD')
    ax.set_aspect('equal', adjustable='box')

    all_rings = [r for p in PROVINCES for r in p['rings']]
    xmin, ymin, xmax, ymax = bbox_of_rings(all_rings)
    pad = max(xmax - xmin, ymax - ymin) * 0.035
    ax.set_xlim(xmin - pad, xmax + pad)
    ax.set_ylim(ymin - pad, ymax + pad)

    # protected areas
    draw_polygons(ax, [r for p in PROTECTED_AREAS for r in p['rings']], PROTECTED_COLOR, '#C9C2B2', 0.2, 1)

    # province fills
    for i, (pcode, meta) in enumerate(PROV_META.items()):
        p = next((p for p in PROVINCES if str(p['props'].get('PROVINCE')) == pcode), None)
        if p:
            draw_polygons(ax, p['rings'], PROV_PALETTE[i], 'white', 0.6, 2)

    # district boundaries
    d_rings = [r for pcode in PROV_META for d in DISTRICTS[pcode] for r in d['rings']]
    draw_polygons(ax, d_rings, 'none', '#6B7280', 0.45, 3)

    # province outlines
    draw_polygons(ax, all_rings, 'none', '#111827', 1.1, 4)

    ax.add_patch(Rectangle((0, 0), 1, 1, transform=ax.transAxes, facecolor='none',
                           edgecolor='#D1D5DB', linewidth=0.6, zorder=25))
    ax.set_xticks([]); ax.set_yticks([])
    for sp in ax.spines.values():
        sp.set_visible(False)

    add_north_arrow(ax)
    add_scale_bar(ax, xmin - pad, xmax + pad)

    # Numbered province markers: cleaner than long names on a small national map.
    marker_ll = {
        '1': (87.10, 27.18),
        '2': (85.30, 26.86),
        '3': (85.20, 27.72),
        '4': (84.00, 28.38),
        '5': (82.90, 27.80),
        '6': (82.20, 29.02),
        '7': (80.85, 29.00),
    }
    for i, (pcode, meta) in enumerate(PROV_META.items(), start=1):
        p = next((p for p in PROVINCES if str(p['props'].get('PROVINCE')) == pcode), None)
        if not p:
            continue
        lon, lat = marker_ll[pcode]
        px, py = albers(lon, lat)
        # keep the marker inside the province if the hand-set point is not
        if not any(point_in_ring(px, py, r) for r in p['rings']):
            ring = max(p['rings'], key=lambda r: abs(ring_area(r)))
            a = abs(ring_area(ring)); cx = cy = 0.0
            if a > 1e-9:
                for j in range(len(ring) - 1):
                    x0, y0 = ring[j]; x1, y1 = ring[j + 1]
                    cr = x0 * y1 - x1 * y0
                    cx += (x0 + x1) * cr; cy += (y0 + y1) * cr
                sgn = 1 if ring_area(ring) > 0 else -1
                cx /= 6 * a * sgn; cy /= 6 * a * sgn
            px, py = interior_point(ring, cx, cy)
        ax.add_patch(plt.Circle((px, py), 9.5, facecolor='white', edgecolor=INK,
                                linewidth=1.0, zorder=12))
        ax.text(px, py - 0.9, str(i), fontsize=7.2, color=INK, ha='center', va='center',
                fontproperties=FP_BOLD, zorder=13)

    add_header(
        fig,
        'NEPAL  ·  LOCAL LEVELS',
        '753 local units (palikas) across 7 provinces and 77 districts',
    )

    # sidebar
    add_panel(fig, 0.705, 0.058, 0.260, 0.815)
    px, pw = 0.722, 0.228
    fig.text(px, 0.840, 'PROVINCES', fontsize=7.6, color=MUTED,
             fontproperties=FP_BOLD, ha='left', va='top')
    fig.add_artist(plt.Line2D([px, px + pw], [0.828, 0.828], transform=fig.transFigure,
                              color=GRID, linewidth=0.8))
    row_y = 0.795
    for i, (pcode, meta) in enumerate(PROV_META.items()):
        n = sum(1 for u in UNITS if u['prov'] == pcode)
        nd = len({u['dist'] for u in UNITS if u['prov'] == pcode})
        fig.add_artist(Rectangle((px, row_y - 0.012), 0.017, 0.013,
                                 transform=fig.transFigure, facecolor=PROV_PALETTE[i],
                                 edgecolor='#9CA3AF', linewidth=0.35))
        fig.text(px + 0.022, row_y, str(i + 1), fontsize=6.9, color=MUTED,
                 ha='left', va='center')
        fig.text(px + 0.040, row_y, meta['short'], fontsize=7.6, color=INK,
                 fontproperties=FP_REG, ha='left', va='center')
        fig.text(px + pw, row_y, f'{n}  ({nd} dist.)', fontsize=6.8, color=MUTED,
                 fontproperties=FP_REG, ha='right', va='center')
        row_y -= 0.044

    sy = 0.470
    fig.add_artist(plt.Line2D([px, px + pw], [sy + 0.025, sy + 0.025], transform=fig.transFigure,
                              color=GRID, linewidth=0.8))
    fig.text(px, sy, '753', fontsize=27, color=ACCENT,
             fontproperties=FP_BOLD, ha='left', va='top')
    fig.text(px + 0.070, sy - 0.004, 'LOCAL UNITS', fontsize=7.2, color=MUTED,
             fontproperties=FP_BOLD, ha='left', va='top')
    fig.text(px, sy - 0.040, '77 districts  ·  7 provinces', fontsize=8.2, color=INK, ha='left', va='top')
    fig.text(px, sy - 0.060, '460 rural  ·  276 urban', fontsize=7.4, color=INK, ha='left', va='top')
    fig.text(px, sy - 0.078, '11 sub-metropolitan  ·  6 metropolitan', fontsize=7.4, color=INK, ha='left', va='top')

    # key
    ky = 0.255
    fig.text(px, ky, 'BOUNDARIES', fontsize=6.4, color=MUTED, fontproperties=FP_BOLD, ha='left', va='top')
    fig.add_artist(plt.Line2D([px, px + 0.023], [ky - 0.020, ky - 0.020], transform=fig.transFigure,
                              color='#111827', linewidth=1.3))
    fig.text(px + 0.030, ky - 0.020, 'Province', fontsize=6.2, color=INK, ha='left', va='center')
    fig.add_artist(plt.Line2D([px, px + 0.023], [ky - 0.037, ky - 0.037], transform=fig.transFigure,
                              color='#6B7280', linewidth=0.7))
    fig.text(px + 0.030, ky - 0.037, 'District', fontsize=6.2, color=INK, ha='left', va='center')
    fig.add_artist(Rectangle((px, ky - 0.058), 0.022, 0.010, transform=fig.transFigure,
                             facecolor=PROTECTED_COLOR, edgecolor='#C9C2B2', linewidth=0.35))
    fig.text(px + 0.030, ky - 0.053, 'Protected area', fontsize=6.2, color=INK, ha='left', va='center')

    add_footer(
        fig,
        'Boundaries: Open Knowledge Nepal, localboundaries (CC BY 4.0)  ·  Codes and names: 1695378470_83.xls',
        f'National overview  ·  page {page_no} of {total_pages}',
    )
    return fig


def render_cover():
    fig = plt.figure(figsize=(16.54, 11.69), facecolor='#0F172A')
    # accent bar
    fig.add_artist(Rectangle((0.0, 0.0), 0.015, 1.0, transform=fig.transFigure,
                             facecolor=ACCENT, edgecolor='none'))
    fig.text(0.07, 0.86, 'CARTOGRAPHIC ATLAS', fontsize=10, color='#FCA5A5',
             fontproperties=FP_BOLD, ha='left', va='top')
    fig.text(0.065, 0.79, 'LOCAL LEVELS', fontsize=44, color='white',
             fontproperties=FP_BOLD, ha='left', va='top')
    fig.text(0.065, 0.705, 'OF NEPAL', fontsize=44, color='white',
             fontproperties=FP_BOLD, ha='left', va='top')
    fig.text(0.07, 0.615, '753 palikas  ·  77 districts  ·  7 provinces', fontsize=15,
             color='#CBD5E1', fontproperties=FP_REG, ha='left', va='top')
    fig.text(0.07, 0.555, 'Official local-unit codes, names and boundaries', fontsize=11,
             color='#94A3B8', fontproperties=FP_REG, ha='left', va='top')

    # small national map on the right
    ax = fig.add_axes([0.50, 0.18, 0.45, 0.62])
    ax.set_facecolor('#0F172A')
    ax.set_aspect('equal', adjustable='box')
    all_rings = [r for p in PROVINCES for r in p['rings']]
    xmin, ymin, xmax, ymax = bbox_of_rings(all_rings)
    pad = max(xmax - xmin, ymax - ymin) * 0.02
    ax.set_xlim(xmin - pad, xmax + pad)
    ax.set_ylim(ymin - pad, ymax + pad)
    for i, (pcode, meta) in enumerate(PROV_META.items()):
        p = next((p for p in PROVINCES if str(p['props'].get('PROVINCE')) == pcode), None)
        if p:
            draw_polygons(ax, p['rings'], PROV_PALETTE[i], '#0F172A', 1.0, 2, alpha=0.95)
    draw_polygons(ax, all_rings, 'none', '#0F172A', 1.4, 3)
    ax.set_xticks([]); ax.set_yticks([])
    for sp in ax.spines.values():
        sp.set_visible(False)

    fig.text(0.07, 0.33, 'Data', fontsize=8, color='#FCA5A5', fontproperties=FP_BOLD, ha='left', va='top')
    fig.text(0.07, 0.30,
             'Official codes and names: 1695378470_83.xls\n'
             'Boundaries: Open Knowledge Nepal, localboundaries (CC BY 4.0)\n'
             'Projection: Albers equal-area  ·  October 2026',
             fontsize=8.2, color='#CBD5E1', ha='left', va='top', linespacing=1.55)
    return fig


def render_notes(page_no, total_pages):
    fig = plt.figure(figsize=(16.54, 11.69), facecolor='white')
    add_header(fig, 'ABOUT THIS ATLAS',
               'How the maps were built, what they show, and how to read the codes')
    col1, col2 = 0.05, 0.52
    y = 0.83
    fig.text(col1, y, 'Coverage', fontsize=12, color=ACCENT, fontproperties=FP_BOLD, ha='left', va='top')
    body = (
        'All 753 local units (palikas) of Nepal are shown, grouped into 77 districts and\n'
        '7 provinces. The unit count and codes come from the supplied workbook\n'
        '1695378470_83.xls; the names are the official English and Nepali names in that file.\n\n'
        'Unit types: 460 rural municipalities (gaunpalika), 276 urban municipalities\n'
        '(nagarpalika), 11 sub-metropolitan cities and 6 metropolitan cities.\n\n'
        'Two units are physically split into two parts: Binayi Tribeni (40808) in\n'
        'Nawalparasi East and Bansgadhi (51201) in Bardiya. Their parts are merged here\n'
        'and each unit is labelled once.\n\n'
        'Area figures are mapped province areas, including protected-area gaps; they\n'
        'may differ slightly from official statistical areas.'
    )
    fig.text(col1, y - 0.032, body, fontsize=8.5, color=INK, ha='left', va='top', linespacing=1.55)

    fig.text(col1, 0.52, 'Reading the code', fontsize=12, color=ACCENT, fontproperties=FP_BOLD, ha='left', va='top')
    body2 = (
        'The five-digit code is hierarchical:\n\n'
        '     1 01 01\n'
        '     │  │  └── local unit within the district\n'
        '     │  └───── district within the province\n'
        '     └──────── province\n\n'
        'For example, 10101 is the first local unit of Taplejung district in Koshi\n'
        'Province. The first digit runs from 1 (Koshi) to 7 (Sudurpashchim).\n\n'
        'The 23 labels missing from the supplied map PDF and the two duplicated\n'
        'labels have been corrected in this atlas: every one of the 753 codes is\n'
        'shown exactly once.'
    )
    fig.text(col1, 0.488, body2, fontsize=8.5, color=INK, ha='left', va='top', linespacing=1.55)

    fig.text(col2, y, 'Map design', fontsize=12, color=ACCENT, fontproperties=FP_BOLD, ha='left', va='top')
    body3 = (
        'Each province page uses a pastel colour for each district, white lines for\n'
        'local-unit boundaries, dark grey lines for districts and a black outline for\n'
        'the province. Protected areas are shown in beige where they create gaps in\n'
        'the local-unit coverage.\n\n'
        'Labels give the official five-digit code (dark red) and the local-unit name.\n'
        'Where a label had to move to avoid a collision, a thin leader line connects it\n'
        'to its unit. Boundaries are generalised slightly for legibility.\n\n'
        'The national overview shows all 77 districts and the seven provinces, with\n'
        'numbered province markers. Because Madhesh is a long, narrow strip, it is\n'
        'shown as eight district panels rather than one crowded provincial map.\n'
        'Every province page still shows every one of its local units.'
    )
    fig.text(col2, y - 0.032, body3, fontsize=8.5, color=INK, ha='left', va='top', linespacing=1.55)

    # province table
    fig.text(col2, 0.52, 'Province summary', fontsize=12, color=ACCENT, fontproperties=FP_BOLD, ha='left', va='top')
    headers = ['Province', 'Districts', 'Local units', 'Area (km², mapped)']
    xs = [col2, col2 + 0.135, col2 + 0.225, col2 + 0.315]
    yy = 0.485
    for x, h in zip(xs, headers):
        fig.text(x, yy, h, fontsize=7.2, color=MUTED, fontproperties=FP_BOLD, ha='left', va='top')
    yy -= 0.018
    for pcode, meta in PROV_META.items():
        us = [u for u in UNITS if u['prov'] == pcode]
        vals = [meta['short'], str(len({u['dist'] for u in us})), str(len(us)),
                f'{province_area(pcode):,.0f}']
        for x, v in zip(xs, vals):
            fig.text(x, yy, v, fontsize=7.6, color=INK, ha='left', va='top')
        yy -= 0.020
    fig.add_artist(plt.Line2D([col2, col2 + 0.40], [yy + 0.008, yy + 0.008], transform=fig.transFigure,
                              color=GRID, linewidth=0.7))
    fig.text(col2, yy - 0.012, 'Total', fontsize=7.6, color=INK, fontproperties=FP_BOLD, ha='left', va='top')
    fig.text(col2 + 0.135, yy - 0.012, '77', fontsize=7.6, color=INK, fontproperties=FP_BOLD, ha='left', va='top')
    fig.text(col2 + 0.225, yy - 0.012, '753', fontsize=7.6, color=INK, fontproperties=FP_BOLD, ha='left', va='top')
    fig.text(col2 + 0.315, yy - 0.012, f'{sum(province_area(p) for p in PROV_META):,.0f}', fontsize=7.6, color=INK, fontproperties=FP_BOLD, ha='left', va='top')

    add_footer(
        fig,
        'Sources: 1695378470_83.xls  ·  1695378470_68.pdf  ·  1695378470_30.pdf  ·  localboundaries.oknp.org',
        f'About  ·  page {page_no} of {total_pages}',
    )
    return fig


def main():
    os.makedirs(os.path.join(HERE, 'maps', 'png'), exist_ok=True)
    total = 10
    pdf_path = os.path.join(HERE, 'maps', 'Nepal_Local_Level_Atlas.pdf')
    with PdfPages(pdf_path) as pdf:
        def emit(name, fig):
            pdf.savefig(fig, facecolor=fig.get_facecolor())
            fig.savefig(os.path.join(HERE, 'maps', 'png', f'{name}.png'), dpi=170,
                        facecolor=fig.get_facecolor())
            plt.close(fig)
            print('saved', name, flush=True)

        emit('cover', render_cover())
        emit('overview', render_overview(2, total))
        for i, pcode in enumerate(PROV_META, start=3):
            print('rendering province', pcode, flush=True)
            if pcode == '2':
                fig = render_province_panels(pcode, i, total)
            else:
                fig = render_province(pcode, i, total)
            emit(f'province_{pcode}', fig)
        emit('about', render_notes(total, total))
    print('PDF', pdf_path, os.path.getsize(pdf_path))


if __name__ == '__main__':
    main()


