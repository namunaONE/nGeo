"""Small procedural-ink toolkit for the illustrations of 'The Ninth Bell'.

Everything is drawn on a warm paper ground with charcoal ink, fog fields,
and a handful of amber lights.  Images are rendered at 2x and downsampled.
"""
from __future__ import annotations

import math
import os
import numpy as np
from PIL import Image, ImageDraw, ImageFilter, ImageFont

FONT_DIR = r"C:\Windows\Fonts"

INK = (24, 21, 18)
INK_SOFT = (44, 39, 33)
PAPER = (222, 214, 197)
PAPER_LIGHT = (233, 225, 208)
FOG = (214, 206, 190)
FOG_LIGHT = (231, 224, 209)
AMBER = (214, 148, 62)
AMBER_LIGHT = (255, 201, 120)
BONE = (235, 226, 208)
RUST = (128, 62, 40)
MOSS = (74, 80, 62)


def font(name: str, size: int) -> ImageFont.FreeTypeFont:
    return ImageFont.truetype(os.path.join(FONT_DIR, name), max(1, int(size)))


def smoothstep(a, b, x):
    t = np.clip((x - a) / (b - a + 1e-9), 0.0, 1.0)
    return t * t * (3.0 - 2.0 * t)


def lerp(a, b, t):
    a = np.asarray(a, dtype=np.float32)
    b = np.asarray(b, dtype=np.float32)
    return a * (1.0 - t) + b * t


def noise_grid(w, h, gw, gh, seed):
    rng = np.random.default_rng(seed)
    g = rng.random((max(2, gh), max(2, gw)), dtype=np.float32)
    im = Image.fromarray((g * 255).astype(np.uint8), "L")
    im = im.resize((w, h), Image.BICUBIC)
    return np.asarray(im, dtype=np.float32) / 255.0


def fbm(w, h, base=6, octaves=5, seed=0, gain=0.52):
    total = np.zeros((h, w), dtype=np.float32)
    norm = 0.0
    amp = 1.0
    gw = max(2, int(base))
    gh = max(2, int(base * h / w))
    for i in range(octaves):
        total += amp * noise_grid(w, h, gw, gh, seed + i * 977)
        norm += amp
        amp *= gain
        gw = int(gw * 2.05) + 1
        gh = int(gh * 2.05) + 1
    return total / norm


def noise_streaks(w, h, gw, gh, seed):
    """Noise stretched horizontally, for fog banks and cloud bands."""
    rng = np.random.default_rng(seed)
    g = rng.random((max(2, gh), max(2, gw)), dtype=np.float32)
    im = Image.fromarray((g * 255).astype(np.uint8), "L")
    im = im.resize((w, h), Image.BICUBIC)
    return np.asarray(im, dtype=np.float32) / 255.0


def paper_base(w, h, seed=0, top=(216, 207, 189), bottom=(231, 223, 206)):
    yy = np.linspace(0.0, 1.0, h, dtype=np.float32)[:, None, None]
    arr = np.asarray(top, np.float32)[None, None, :] * (1.0 - yy) + \
        np.asarray(bottom, np.float32)[None, None, :] * yy
    arr = np.repeat(arr, w, axis=1)

    mott = fbm(w, h, base=5, octaves=6, seed=seed + 3)
    arr *= (0.955 + 0.085 * mott[..., None])

    # fine paper grain
    rng = np.random.default_rng(seed + 11)
    grain = rng.normal(0.0, 4.0, (h, w, 1)).astype(np.float32)
    arr += grain

    # warm/cool drift
    drift = fbm(w, h, base=3, octaves=3, seed=seed + 29)
    arr[..., 0] += (drift - 0.5) * 10
    arr[..., 1] += (drift - 0.5) * 6
    arr[..., 2] -= (drift - 0.5) * 6
    return np.clip(arr, 0, 255)


def dark_base(w, h, seed=0, top=(17, 16, 15), mid=(34, 30, 25), bottom=(19, 17, 15)):
    yy = np.linspace(0.0, 1.0, h, dtype=np.float32)[:, None, None]
    mid_y = 0.66
    t1 = smoothstep(0.0, mid_y, yy)
    t2 = smoothstep(mid_y, 1.0, yy)
    low = np.asarray(top, np.float32)[None, None, :] * (1 - t1) + \
        np.asarray(mid, np.float32)[None, None, :] * t1
    high = np.asarray(mid, np.float32)[None, None, :] * (1 - t2) + \
        np.asarray(bottom, np.float32)[None, None, :] * t2
    arr = np.where(yy < mid_y, low, high)
    arr = np.repeat(arr, w, axis=1)
    mott = fbm(w, h, base=4, octaves=6, seed=seed + 5)
    arr *= (0.82 + 0.36 * mott[..., None])
    rng = np.random.default_rng(seed + 17)
    arr += rng.normal(0.0, 3.0, (h, w, 1)).astype(np.float32)
    return np.clip(arr, 0, 255)


class Art:
    def __init__(self, width, height, scale=2, seed=1, base=None):
        self.w = int(width * scale)
        self.h = int(height * scale)
        self.s = scale
        self.rng = np.random.default_rng(seed)
        if base is None:
            base = paper_base(self.w, self.h, seed=seed)
        else:
            base = np.clip(np.asarray(base, np.float32), 0, 255)
        self.img = Image.fromarray(base.astype(np.uint8), "RGB").convert("RGBA")
        self.d = ImageDraw.Draw(self.img, "RGBA")

    # ---------- compositing ----------
    def arr(self):
        return np.asarray(self.img.convert("RGB"), dtype=np.float32) / 255.0

    def set_arr(self, arr):
        arr = np.clip(arr * 255.0, 0, 255).astype(np.uint8)
        self.img = Image.fromarray(arr, "RGB").convert("RGBA")
        self.d = ImageDraw.Draw(self.img, "RGBA")

    def fog(self, y0, y1, color=FOG, strength=0.55, seed=0, streak=0.55,
            softness=0.18, bands=0):
        w, h = self.w, self.h
        arr = self.arr()
        yy = np.arange(h, dtype=np.float32)[:, None] / h
        top = smoothstep(y0 - softness, y0 + softness, yy)
        bot = 1.0 - smoothstep(y1 - softness, y1 + softness, yy)
        mask = top * bot
        base_n = fbm(w, h, base=22, octaves=5, seed=seed + 51)
        st = noise_streaks(w, h, max(2, w // 240), max(2, h // 42), seed + 77)
        n = base_n * (1 - streak) + st * streak
        alpha = strength * mask * (0.28 + 0.9 * n)
        if bands:
            band = 0.5 + 0.5 * np.sin(yy * math.pi * 2 * bands + 1.7)
            alpha *= (0.65 + 0.55 * band)
        alpha = np.clip(alpha, 0, 0.96)[..., None]
        col = np.asarray(color, np.float32) / 255.0
        out = arr * (1.0 - alpha) + col[None, None, :] * alpha
        self.set_arr(out)

    def glow(self, cx, cy, r, color=AMBER_LIGHT, strength=0.9, aspect=1.0, power=2.2):
        w, h = self.w, self.h
        x0 = max(0, int(cx - r * 1.2))
        x1 = min(w, int(cx + r * 1.2))
        y0 = max(0, int(cy - r * 1.2 / max(aspect, 0.05)))
        y1 = min(h, int(cy + r * 1.2 / max(aspect, 0.05)))
        if x1 <= x0 or y1 <= y0:
            return
        arr = self.arr()
        yy, xx = np.mgrid[y0:y1, x0:x1].astype(np.float32)
        d = np.sqrt(((xx - cx) / r) ** 2 + ((yy - cy) / (r / max(aspect, 0.05))) ** 2)
        m = np.clip(1.0 - d, 0.0, 1.0) ** power
        col = np.asarray(color, np.float32) / 255.0
        sub = arr[y0:y1, x0:x1]
        sub = 1.0 - (1.0 - sub) * (1.0 - np.clip(m[..., None] * strength, 0, 0.98) * col[None, None, :])
        arr[y0:y1, x0:x1] = sub
        self.set_arr(arr)

    def vignette(self, amount=0.38, power=2.0):
        w, h = self.w, self.h
        yy, xx = np.mgrid[0:h, 0:w].astype(np.float32)
        cx, cy = w * 0.5, h * 0.47
        d = np.sqrt(((xx - cx) / (w * 0.62)) ** 2 + ((yy - cy) / (h * 0.60)) ** 2)
        v = 1.0 - amount * np.clip((d - 0.45) / 0.75, 0, 1) ** power
        self.set_arr(self.arr() * v[..., None])

    def finish(self, grain=0.012, warm=True, contrast=1.04, fade=None):
        arr = self.arr()
        h, w = arr.shape[:2]
        rng = np.random.default_rng(1234)
        n = rng.normal(0.0, grain, (h, w, 1)).astype(np.float32)
        arr += n
        # ink mottling
        tex = fbm(w, h, base=8, octaves=4, seed=88)
        arr *= (0.97 + 0.06 * tex[..., None])
        if warm:
            arr[..., 0] *= 1.012
            arr[..., 2] *= 0.985
        arr = (arr - 0.5) * contrast + 0.5
        if fade is not None:
            y0, y1, col, amt = fade
            yy = np.arange(h, dtype=np.float32)[:, None] / h
            mask = smoothstep(y0, y1, yy)[..., None] * amt
            c = np.asarray(col, np.float32) / 255.0
            arr = arr * (1 - mask) + c[None, None, :] * mask
        self.set_arr(arr)

    # ---------- drawing primitives ----------
    def poly(self, pts, fill=INK, alpha=255, outline=None, width=0):
        f = tuple(fill) + (alpha,) if len(fill) == 3 else fill
        o = None
        if outline is not None:
            o = tuple(outline) + (alpha,) if len(outline) == 3 else outline
        self.d.polygon([(float(x), float(y)) for x, y in pts], fill=f, outline=o, width=width)

    def line(self, pts, fill=INK, alpha=255, width=2, joint="curve"):
        col = tuple(fill) + (alpha,) if len(fill) == 3 else fill
        self.d.line([(float(x), float(y)) for x, y in pts], fill=col, width=int(width), joint=joint)

    def rect(self, x0, y0, x1, y1, fill=INK, alpha=255, outline=None, width=0):
        f = tuple(fill) + (alpha,) if len(fill) == 3 else fill
        o = None
        if outline is not None:
            o = tuple(outline) + (alpha,) if len(outline) == 3 else outline
        self.d.rectangle([x0, y0, x1, y1], fill=f, outline=o, width=width)

    def ellipse(self, x0, y0, x1, y1, fill=INK, alpha=255, outline=None, width=0):
        f = tuple(fill) + (alpha,) if len(fill) == 3 else fill
        o = None
        if outline is not None:
            o = tuple(outline) + (alpha,) if len(outline) == 3 else outline
        self.d.ellipse([x0, y0, x1, y1], fill=f, outline=o, width=width)

    def hatch(self, pts, angle=45, spacing=8, color=INK, alpha=70, width=1, jitter=1.5):
        w, h = self.w, self.h
        mask = Image.new("L", (w, h), 0)
        ImageDraw.Draw(mask).polygon([(float(x), float(y)) for x, y in pts], fill=255)
        layer = Image.new("RGBA", (w, h), (0, 0, 0, 0))
        ld = ImageDraw.Draw(layer)
        xs = [p[0] for p in pts]
        ys = [p[1] for p in pts]
        cx = (min(xs) + max(xs)) / 2
        cy = (min(ys) + max(ys)) / 2
        diag = math.hypot(max(xs) - min(xs), max(ys) - min(ys)) + 20
        a = math.radians(angle)
        dx, dy = math.cos(a), math.sin(a)
        px, py = -dy, dx
        n = int(diag / spacing) + 2
        for i in range(-n, n + 1):
            ox = cx + px * i * spacing
            oy = cy + py * i * spacing
            jx = self.rng.normal(0, jitter)
            jy = self.rng.normal(0, jitter)
            ld.line([(ox - dx * diag + jx, oy - dy * diag + jy),
                     (ox + dx * diag + jx, oy + dy * diag + jy)],
                    fill=tuple(color) + (alpha,), width=int(width))
        masked = Image.composite(layer, Image.new("RGBA", (w, h), (0, 0, 0, 0)), mask)
        self.img.alpha_composite(masked)
        self.d = ImageDraw.Draw(self.img, "RGBA")

    # ---------- scenery ----------
    def ridge_line(self, base_y, amp, seed, octaves=6, roughness=0.52, tilt=0.0, massifs=3):
        w = self.w
        x = np.arange(w, dtype=np.float32)
        rng = np.random.default_rng(seed)
        height = np.zeros(w, dtype=np.float32)
        # broad massifs give the range its silhouette
        for i in range(massifs):
            cx = rng.uniform(-0.12, 1.12) * w
            sx = rng.uniform(0.07, 0.20) * w
            hgt = rng.uniform(0.25, 1.0) * amp * 2.0
            height += hgt * np.exp(-((x - cx) / sx) ** 2)
        # fractal detail, smoothed so it reads as rock rather than sawteeth
        a = amp * 0.55
        for o in range(octaves):
            count = max(5, int(w / (2 ** (octaves - o)) / 2) + 4)
            vals = rng.normal(0.0, 1.0, count).astype(np.float32)
            xp = np.linspace(-0.2 * w, 1.2 * w, count)
            n = np.interp(x, xp, vals).astype(np.float32)
            k = max(3, int(w / count * 0.85))
            k = k + 1 if k % 2 == 0 else k
            ker = np.hanning(k).astype(np.float32)
            ker /= ker.sum()
            n = np.convolve(n, ker, mode="same").astype(np.float32)
            n /= (np.std(n) + 1e-6)
            height += a * n
            a *= roughness
        height = np.clip(height, 0, None)
        return base_y - height + tilt * (x - w / 2)

    def ridge(self, base_y, amp, seed, color=INK, alpha=255, fade=0.0,
              rim=None, rim_alpha=40, octaves=6, massifs=3,
              color_top=None, color_bottom=None, softness=1.4):
        ys = self.ridge_line(base_y, amp, seed, octaves=octaves, massifs=massifs)
        w, h = self.w, self.h
        pts = [(0, h + 10)] + [(float(x), float(ys[x])) for x in range(0, w, 2)] + [(w, h + 10)]
        mask = Image.new("L", (w, h), 0)
        ImageDraw.Draw(mask).polygon(pts, fill=255)
        if softness > 0:
            mask = mask.filter(ImageFilter.GaussianBlur(softness * self.s))

        col_top = np.asarray(color_top if color_top is not None else color, np.float32)
        col_bot = np.asarray(color_bottom if color_bottom is not None else color, np.float32)
        if fade:
            col_top = lerp(col_top, np.asarray(FOG, np.float32), fade)
            col_bot = lerp(col_bot, np.asarray(FOG, np.float32), fade * 0.7)
        crest = float(np.min(ys))
        yy = np.arange(h, dtype=np.float32)[:, None]
        t = np.clip((yy - crest) / (h - crest + 1e-6), 0, 1) ** 0.75
        grad = col_top[None, None, :] * (1 - t[..., None]) + col_bot[None, None, :] * t[..., None]
        grad = np.repeat(grad, w, axis=1)
        tex = fbm(w, h, base=18, octaves=5, seed=seed + 300)
        grad *= (0.84 + 0.28 * tex[..., None])
        grad = np.clip(grad, 0, 255)
        layer = Image.fromarray(grad.astype(np.uint8), "RGB").convert("RGBA")
        if alpha < 255:
            mask = mask.point(lambda v: int(v * alpha / 255))
        layer.putalpha(mask)
        self.img.alpha_composite(layer)
        self.d = ImageDraw.Draw(self.img, "RGBA")
        if rim is not None:
            rp = [(float(x), float(ys[x])) for x in range(0, w, 2)]
            self.line(rp, fill=rim, alpha=rim_alpha, width=max(1, self.s))
        return ys

    def treeline(self, ys, color=INK, alpha=230, density=0.10, hmin=14, hmax=46, seed=0):
        rng = np.random.default_rng(seed)
        w = self.w
        n = int(w * density / max(self.s, 1))
        for _ in range(n):
            x = rng.uniform(0, w)
            i = int(np.clip(x, 0, w - 1))
            base = ys[i] + rng.uniform(1, 6) * self.s
            hh = rng.uniform(hmin, hmax) * self.s
            self.pine(x, base, hh, color, alpha=alpha, slim=rng.uniform(0.7, 1.1))

    def pine(self, x, base, height, color=INK, alpha=240, slim=1.0, trunk=True, tiers=13):
        s = self.s
        if height < 5 * s:
            return
        # trunk
        if trunk:
            self.line([(x, base + height * 0.02), (x, base - height * 0.86)],
                      fill=color, alpha=alpha, width=max(1, int(height * 0.035) + 1))
        # solid core so the tree reads at a distance
        core_w = height * 0.145 * slim
        self.poly([(x - core_w, base), (x - core_w * 0.55, base - height * 0.45),
                   (x - core_w * 0.18, base - height * 0.80), (x, base - height),
                   (x + core_w * 0.18, base - height * 0.80),
                   (x + core_w * 0.55, base - height * 0.45),
                   (x + core_w, base)], fill=color, alpha=alpha)
        # drooping branch tiers
        for i in range(tiers):
            t = i / max(1, tiers - 1)
            y = base - height * (0.10 + 0.88 * t)
            env = height * 0.255 * slim * (1.0 - t) ** 0.9
            env *= self.rng.uniform(0.82, 1.12)
            droop = height * (0.055 + 0.03 * (1 - t)) * self.rng.uniform(0.8, 1.2)
            for side in (-1, 1):
                tipx = x + side * env
                tipy = y + droop
                pts = [(x + side * env * 0.03, y - height * 0.018),
                       (x + side * env * 0.55, y + droop * 0.55),
                       (tipx, tipy),
                       (x + side * env * 0.72, y + droop * 0.9),
                       (x + side * env * 0.30, y + droop * 0.45)]
                self.poly(pts, fill=color, alpha=alpha)
        # crown
        self.poly([(x, base - height * 1.02), (x - height * 0.018, base - height * 0.92),
                   (x, base - height * 0.88), (x + height * 0.018, base - height * 0.92)],
                  fill=color, alpha=alpha)

    def bare_tree(self, x, base, height, color=INK, alpha=235, depth=8, seed=0, lean=0.0):
        rng = np.random.default_rng(seed)

        def branch(bx, by, angle, length, width, d):
            if d <= 0 or length < 2.0 * self.s:
                return
            ex = bx + math.cos(angle) * length
            ey = by + math.sin(angle) * length
            mx = (bx + ex) / 2 + rng.normal(0, length * 0.05)
            my = (by + ey) / 2 + rng.normal(0, length * 0.05)
            self.line([(bx, by), (mx, my), (ex, ey)], fill=color, alpha=alpha,
                      width=max(1, int(width)))
            n = 2 if d > 4 else rng.integers(2, 4)
            for k in range(int(n)):
                spread = rng.uniform(0.24, 0.62) * (1 if k % 2 == 0 else -1)
                branch(ex, ey, angle + spread + rng.normal(0, 0.06),
                       length * rng.uniform(0.58, 0.79), width * 0.62, d - 1)

        branch(x, base, -math.pi / 2 + lean, height * 0.34, 9.0 * self.s, depth)
        self.line([(x - height * 0.03, base), (x + height * 0.03, base)],
                  fill=color, alpha=alpha, width=max(2, int(3 * self.s)))

    def house(self, x, base, w, h, color=INK, alpha=255, lit=True, side=1,
              roof=0.42, window=True, detail=True, chimney=True):
        s = self.s
        x0, x1 = x - w / 2, x + w / 2
        top = base - h
        # wall
        wall = [(x0, base), (x0, top), (x1, top), (x1, base)]
        self.poly(wall, fill=color, alpha=alpha)
        # roof
        peak = (x, top - h * roof)
        over = w * 0.12
        self.poly([(x0 - over, top + h * 0.02), (x0 + w * 0.06, top - h * 0.04),
                   peak, (x1 - w * 0.06, top - h * 0.04), (x1 + over, top + h * 0.02)],
                  fill=color, alpha=alpha)
        if detail:
            self.hatch(wall, angle=78, spacing=7 * s, color=INK, alpha=55,
                       width=max(1, int(s)), jitter=1.0 * s)
            # roof courses
            for i in range(3):
                t = (i + 1) / 4
                yy = top - h * roof * t
                self.line([(x0 - over * (1 - t * 0.5) + 4 * s, yy), (x1 + over * (1 - t * 0.5) - 4 * s, yy)],
                          fill=color, alpha=90, width=max(1, int(s)))
        if chimney:
            cx = x1 - w * 0.22
            self.rect(cx, top - h * roof * 0.75, cx + w * 0.09, top - h * roof * 0.15,
                      fill=color, alpha=alpha)
        if window:
            ww = w * 0.13
            wh = h * 0.15
            wx = x0 + w * 0.18 + (0.25 * w if side < 0 else 0)
            wy = top + h * 0.28
            if lit:
                self.rect(wx, wy, wx + ww, wy + wh, fill=AMBER_LIGHT, alpha=250)
                self.line([(wx + ww / 2, wy), (wx + ww / 2, wy + wh)], fill=INK, alpha=210,
                          width=max(1, int(s)))
                self.line([(wx, wy + wh / 2), (wx + ww, wy + wh / 2)], fill=INK, alpha=210,
                          width=max(1, int(s)))
            else:
                self.rect(wx, wy, wx + ww, wy + wh, fill=(10, 9, 8), alpha=230)
        # door
        if detail:
            dw = w * 0.12
            self.rect(x1 - w * 0.28, base - h * 0.32, x1 - w * 0.28 + dw, base,
                      fill=(8, 8, 7), alpha=210)

    def tower(self, x, base, h, w, color=INK, alpha=255, detail=True, bell=True,
              roof=True, lit=0.0):
        s = self.s
        top_w = w * 0.74
        top = base - h
        body = [(x - w / 2, base), (x - top_w / 2, top), (x + top_w / 2, top), (x + w / 2, base)]
        self.poly(body, fill=color, alpha=alpha)
        # stone courses
        if detail:
            for i in range(1, 21):
                t = i / 21
                y = base - h * t
                half = (w / 2) * (1 - t) + (top_w / 2) * t
                self.line([(x - half + 2 * s, y), (x + half - 2 * s, y)],
                          fill=INK, alpha=34, width=max(1, int(0.8 * s)))
            for i in range(8):
                t = (i + 0.5) / 8
                y = base - h * t
                half = (w / 2) * (1 - t) + (top_w / 2) * t
                for f in (-0.62, -0.2, 0.24, 0.62):
                    jx = (i % 2) * 0.05
                    self.line([(x + half * (f + jx), y), (x + half * (f + jx), y - h * 0.035)],
                              fill=INK, alpha=30, width=max(1, int(0.8 * s)))
            # shaded side
            self.hatch([(x, base), (x, top), (x + top_w / 2, top), (x + w / 2, base)],
                       angle=72, spacing=9 * s, color=INK, alpha=26, width=max(1, int(s)),
                       jitter=1.2 * s)
            # corbel course under the belfry
            cy = top + h * 0.012
            self.poly([(x - top_w * 0.66, cy), (x + top_w * 0.66, cy),
                       (x + top_w * 0.60, cy + h * 0.018), (x - top_w * 0.60, cy + h * 0.018)],
                      fill=color, alpha=alpha)
            # slit window
            self.rect(x - top_w * 0.035, top + h * 0.42, x + top_w * 0.035, top + h * 0.50,
                      fill=(9, 8, 7), alpha=240)
            # low door
            dw = w * 0.14
            dh = h * 0.10
            self.poly([(x - dw, base), (x - dw, base - dh * 0.6),
                       (x - dw * 0.15, base - dh), (x + dw * 0.15, base - dh),
                       (x + dw, base - dh * 0.6), (x + dw, base)],
                      fill=(7, 7, 6), alpha=245)
        # belfry arch
        if bell:
            aw = top_w * 0.60
            ah = h * 0.125
            ay = top + h * 0.055
            arch_col = (46, 33, 22) if lit else (9, 8, 7)
            self.rect(x - aw / 2, ay + aw / 2, x + aw / 2, ay + ah,
                      fill=arch_col, alpha=245)
            self.ellipse(x - aw / 2, ay, x + aw / 2, ay + aw, fill=arch_col, alpha=245)
            # bell
            bw = aw * 0.50
            by = ay + ah * 0.26
            self.poly([(x - bw * 0.2, by), (x - bw * 0.5, by + ah * 0.30),
                       (x - bw * 0.62, by + ah * 0.46), (x + bw * 0.62, by + ah * 0.46),
                       (x + bw * 0.5, by + ah * 0.30), (x + bw * 0.2, by)],
                      fill=(4, 4, 4), alpha=255)
            self.rect(x - bw * 0.62, by + ah * 0.44, x + bw * 0.62, by + ah * 0.50,
                      fill=(4, 4, 4), alpha=255)
            if lit:
                self.ellipse(x - bw * 0.35, by + ah * 0.12, x + bw * 0.35, by + ah * 0.4,
                             fill=AMBER, alpha=int(120 * lit))
        if roof:
            ry = top
            rw = top_w * 1.12
            self.poly([(x - rw, ry + h * 0.020), (x - rw * 0.10, ry - h * 0.055),
                       (x, ry - h * 0.075), (x + rw * 0.10, ry - h * 0.055),
                       (x + rw, ry + h * 0.020)], fill=color, alpha=alpha)
            self.line([(x, ry - h * 0.075), (x, ry - h * 0.115)], fill=color, alpha=alpha,
                      width=max(2, int(2.2 * s)))
            # finial
            self.ellipse(x - 3 * s, ry - h * 0.125, x + 3 * s, ry - h * 0.105,
                         fill=color, alpha=alpha)
            # eaves line
            self.line([(x - rw, ry + h * 0.020), (x + rw, ry + h * 0.020)],
                      fill=color, alpha=alpha, width=max(1, int(1.5 * s)))
        # corbel below the belfry
        if detail:
            cy = top + h * 0.205
            self.poly([(x - top_w * 0.58, cy), (x + top_w * 0.58, cy),
                       (x + top_w * 0.52, cy + h * 0.018), (x - top_w * 0.52, cy + h * 0.018)],
                      fill=color, alpha=alpha)

    def rocks(self, cx, base, width, height, color=INK, alpha=255, seed=0):
        rng = np.random.default_rng(seed)
        s = self.s
        n = 11
        pts = [(cx - width / 2, base + height * 0.15)]
        for i in range(n + 1):
            t = i / n
            x = cx - width / 2 + width * t
            y = base - height * (0.35 + 0.65 * math.sin(math.pi * t) ** 0.5) * rng.uniform(0.65, 1.05)
            pts.append((x, y))
            if i < n:
                pts.append((x + width / n * rng.uniform(0.2, 0.6),
                            base - height * rng.uniform(0.15, 0.55)))
        pts.append((cx + width / 2, base + height * 0.15))
        self.poly(pts, fill=color, alpha=alpha)
        # strata
        for i in range(3):
            y = base - height * (0.15 + 0.2 * i)
            self.line([(cx - width * 0.45, y), (cx - width * 0.1, y - height * 0.05),
                       (cx + width * 0.25, y), (cx + width * 0.45, y - height * 0.04)],
                      fill=INK if color != INK else (60, 54, 46), alpha=40,
                      width=max(1, int(s)))

    def wall(self, x0, x1, base, height, color=INK, alpha=255, detail=True):
        s = self.s
        self.rect(x0, base - height, x1, base, fill=color, alpha=alpha)
        if detail:
            for i in range(1, 5):
                y = base - height * i / 5
                self.line([(x0, y), (x1, y)], fill=INK, alpha=30, width=max(1, int(s)))
            for i in range(int((x1 - x0) / (7 * s))):
                x = x0 + i * 7 * s
                self.line([(x, base - height), (x, base - height * 0.8)], fill=INK, alpha=26,
                          width=max(1, int(s)))

    def figure(self, x, base, h, color=INK, alpha=245, coat=True, pack=False,
               shawl=False, lamp=False, lean=0.0, facing=1):
        s = self.s
        head_r = h * 0.062
        head_cy = base - h + head_r * 1.1
        # head
        self.ellipse(x - head_r, head_cy - head_r, x + head_r, head_cy + head_r,
                     fill=color, alpha=alpha)
        # neck / shoulders
        sh_y = head_cy + head_r * 1.4
        shoulder = h * 0.105
        hip = base - h * 0.52
        hem = base - h * 0.38
        body = [(x - shoulder, sh_y + h * 0.02),
                (x - shoulder * 1.05 + lean * h * 0.1, hip),
                (x - shoulder * 1.2 + lean * h * 0.15, hem),
                (x + shoulder * 1.15 + lean * h * 0.15, hem),
                (x + shoulder * 1.02 + lean * h * 0.1, hip),
                (x + shoulder, sh_y + h * 0.02),
                (x, sh_y - h * 0.012)]
        self.poly(body, fill=color, alpha=alpha)
        # legs
        leg_top = hem - h * 0.04
        for side in (-1, 1):
            lx = x + side * shoulder * 0.36
            self.line([(lx, leg_top), (lx + side * h * 0.012, base - h * 0.03)],
                      fill=color, alpha=alpha, width=max(3, int(h * 0.045)))
        # boots
        self.line([(x - shoulder * 0.55, base - h * 0.015), (x - shoulder * 0.1, base - h * 0.015)],
                  fill=color, alpha=alpha, width=max(3, int(h * 0.035)))
        self.line([(x + shoulder * 0.1, base - h * 0.015), (x + shoulder * 0.6, base - h * 0.015)],
                  fill=color, alpha=alpha, width=max(3, int(h * 0.035)))
        # arms
        self.line([(x - shoulder * 0.92, sh_y + h * 0.03),
                   (x - shoulder * 1.18, hip + h * 0.04)], fill=color, alpha=alpha,
                  width=max(3, int(h * 0.036)))
        if lamp:
            self.line([(x + shoulder * 0.9, sh_y + h * 0.03),
                       (x + shoulder * 1.55, hip - h * 0.02)], fill=color, alpha=alpha,
                      width=max(3, int(h * 0.036)))
            lx = x + shoulder * 1.62
            ly = hip + h * 0.01
            self.line([(lx, ly - h * 0.04), (lx, ly)], fill=color, alpha=alpha,
                      width=max(1, int(2 * s)))
            self.poly([(lx - h * 0.028, ly), (lx + h * 0.028, ly),
                       (lx + h * 0.02, ly + h * 0.075), (lx - h * 0.02, ly + h * 0.075)],
                      fill=AMBER_LIGHT, alpha=230)
            return (lx, ly + h * 0.04)
        else:
            self.line([(x + shoulder * 0.92, sh_y + h * 0.03),
                       (x + shoulder * 1.18, hip + h * 0.04)], fill=color, alpha=alpha,
                      width=max(3, int(h * 0.036)))
        if shawl:
            self.poly([(x - shoulder * 1.02, sh_y), (x - shoulder * 0.4, sh_y - h * 0.02),
                       (x - shoulder * 0.15, hem + h * 0.02), (x - shoulder * 1.1, hem - h * 0.04)],
                      fill=color, alpha=min(255, alpha + 5))
        if pack:
            self.poly([(x - shoulder * 1.05, sh_y + h * 0.01),
                       (x - shoulder * 1.55, sh_y + h * 0.05),
                       (x - shoulder * 1.45, hip + h * 0.02),
                       (x - shoulder * 0.95, hip - h * 0.01)],
                      fill=color, alpha=alpha)
            self.rect(x - shoulder * 1.12, sh_y + h * 0.03, x - shoulder * 0.95, hip,
                      fill=color, alpha=alpha)
        return None

    def birds(self, cx, cy, spread, n=7, color=INK, alpha=170, size=1.0):
        s = self.s
        for i in range(n):
            bx = cx + self.rng.uniform(-spread, spread)
            by = cy + self.rng.uniform(-spread * 0.28, spread * 0.28)
            sz = self.rng.uniform(5, 13) * s * size
            self.line([(bx - sz, by), (bx, by - sz * 0.45), (bx + sz, by)],
                      fill=color, alpha=alpha, width=max(1, int(1.2 * s)))

    def text(self, xy, txt, fnt, fill=BONE, tracking=0, anchor="mm", alpha=255,
             shadow=None, shadow_off=(2, 3), shadow_alpha=120):
        w, h = self.w, self.h
        d = self.d
        total = 0.0
        for ch in txt:
            total += d.textlength(ch, font=fnt) + tracking
        total -= tracking if txt else 0
        x, y = xy
        if anchor == "mm":
            x -= total / 2
            y -= fnt.size / 2
        elif anchor == "lm":
            y -= fnt.size / 2
        elif anchor == "rm":
            x -= total
            y -= fnt.size / 2
        passes = []
        if shadow is not None:
            passes.append((shadow, shadow_alpha, shadow_off[0] * self.s, shadow_off[1] * self.s))
        passes.append((fill, alpha, 0, 0))
        for col, a, ox, oy in passes:
            cx = x + ox
            for ch in txt:
                d.text((cx, y + oy), ch, font=fnt, fill=tuple(col) + (a,), anchor="lm")
                cx += d.textlength(ch, font=fnt) + tracking
        return total


def resize_save(img, path, width, height):
    out = img.convert("RGB").resize((width, height), Image.LANCZOS)
    # gentle output sharpening
    out = out.filter(ImageFilter.UnsharpMask(radius=1.2, percent=55, threshold=2))
    out.save(path, "PNG", optimize=True)
    return out


def add_clouds(art, y0, y1, color=(24, 22, 20), strength=0.6, seed=0):
    w, h = art.w, art.h
    n = noise_streaks(w, h, 6, 26, seed)
    n = 0.55 * n + 0.45 * fbm(w, h, base=10, octaves=4, seed=seed + 9)
    yy = np.arange(h, dtype=np.float32)[:, None] / h
    mask = smoothstep(y0, y0 + 0.05, yy) * (1 - smoothstep(y1 - 0.08, y1, yy))
    a = np.clip(n * mask * strength, 0, 0.92)[..., None]
    arr = art.arr()
    c = np.asarray(color, np.float32) / 255.0
    art.set_arr(arr * (1 - a) + c[None, None, :] * a)
