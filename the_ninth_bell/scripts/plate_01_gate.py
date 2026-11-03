"""Plate I - the gate at Simsara."""
from __future__ import annotations

import sys
import numpy as np
from PIL import Image, ImageDraw

from artlib import Art, INK, FOG, AMBER_LIGHT, BONE, font, resize_save
from night_common import night, stars, mountains, village, glow_lights, snow_ground, signboard

W, H = 2000, 1250


def crow(art, x, y, size=1.0):
    s = art.s * size
    art.ellipse(x - 11 * s, y - 7 * s, x + 9 * s, y + 7 * s, fill=(9, 9, 8), alpha=255)
    art.ellipse(x + 5 * s, y - 13 * s, x + 16 * s, y - 2 * s, fill=(9, 9, 8), alpha=255)
    art.poly([(x + 15 * s, y - 8 * s), (x + 24 * s, y - 5 * s), (x + 15 * s, y - 4 * s)],
             fill=(9, 9, 8), alpha=255)
    art.poly([(x - 9 * s, y - 2 * s), (x - 22 * s, y + 5 * s), (x - 8 * s, y + 4 * s)],
             fill=(9, 9, 8), alpha=255)
    art.line([(x - 3 * s, y + 7 * s), (x - 4 * s, y + 13 * s)], fill=(9, 9, 8), alpha=255,
             width=max(1, int(1.5 * s)))
    art.line([(x + 3 * s, y + 7 * s), (x + 2 * s, y + 13 * s)], fill=(9, 9, 8), alpha=255,
             width=max(1, int(1.5 * s)))


def wall_with_arch(art, x0, x1, top, bottom, ax, aw, spring, color=(38, 34, 29)):
    s = art.s
    w, h = art.w, art.h
    layer = Image.new("RGBA", (w, h), (0, 0, 0, 0))
    d = ImageDraw.Draw(layer)
    d.rectangle([x0, top, x1, bottom], fill=tuple(color) + (255,))

    # courses
    n = 11
    for i in range(1, n):
        yv = top + (bottom - top) * i / n
        d.line([(x0 + 2 * s, yv), (x1 - 2 * s, yv)], fill=(160, 148, 126, 22),
               width=max(1, int(0.9 * s)))
    # occasional vertical joints
    rng = np.random.default_rng(4)
    for i in range(1, n):
        yv = top + (bottom - top) * i / n
        xv = x0 + (x1 - x0) * rng.uniform(0.05, 0.95)
        d.line([(xv, yv), (xv, yv - (bottom - top) / n * 0.8)], fill=(160, 148, 126, 16),
               width=1)
    # shadow down the right side
    d.rectangle([x1 - 80 * s, top, x1, bottom], fill=(8, 8, 7, 70))
    # moss at the foot
    for _ in range(26):
        mx = rng.uniform(x0, x1)
        my = rng.uniform(bottom - 90 * s, bottom)
        d.ellipse([mx, my, mx + rng.uniform(10, 40) * s, my + rng.uniform(5, 18) * s],
                  fill=(58, 64, 49, int(rng.integers(20, 55))))

    # cut the arch
    d.rectangle([ax - aw / 2, spring, ax + aw / 2, bottom], fill=(0, 0, 0, 0))
    d.ellipse([ax - aw / 2, spring - aw / 2, ax + aw / 2, spring + aw / 2], fill=(0, 0, 0, 0))

    art.img.alpha_composite(layer)
    art.d = ImageDraw.Draw(art.img, "RGBA")

    # arch rim
    art.d.arc([ax - aw / 2, spring - aw / 2, ax + aw / 2, spring + aw / 2], 180, 360,
              fill=(10, 9, 8, 190), width=max(3, int(5 * s)))
    art.line([(ax - aw / 2, spring), (ax - aw / 2, bottom)], fill=(10, 9, 8, 170),
             width=max(3, int(4 * s)))
    art.line([(ax + aw / 2, spring), (ax + aw / 2, bottom)], fill=(10, 9, 8, 170),
             width=max(3, int(4 * s)))
    art.d.arc([ax - aw / 2 + 4 * s, spring - aw / 2 + 4 * s, ax + aw / 2 - 4 * s, spring + aw / 2 - 4 * s],
              180, 360, fill=(128, 118, 100, 45), width=max(1, int(1.4 * s)))


def render(scale=2, out="plate_01_gate.png"):
    art = night(W, H, scale=scale, seed=101, horizon=0.63)
    s = scale
    w, h = art.w, art.h
    stars(art, n=85, ymax=0.42, seed=4)

    # world beyond the gate
    mountains(art, 0.536, layers=4, seed=21, amp=0.025, step=0.024)
    art.fog(0.545, 0.650, color=(94, 88, 77), strength=0.12, seed=9, streak=0.55, softness=0.10)
    lights = village(art, 0.442 * w, 0.648 * h, 0.205 * w, n=9, lit=0.60, seed=12,
                     min_w=0.030, max_w=0.055)
    art.house(0.505 * w, 0.642 * h, 0.072 * w, 0.042 * h, color=(18, 16, 14), alpha=255,
              lit=True, detail=False, chimney=True, side=1)
    lights.append((0.509 * w, 0.626 * h, 0.020 * w))
    glow_lights(art, lights, strength=0.42)
    art.fog(0.635, 0.745, color=(83, 78, 69), strength=0.15, seed=19, streak=0.6, softness=0.10)

    # snow road
    snow_ground(art, 0.760, seed=31, tone=(35, 32, 28))
    road = [(0.330 * w, 1.02 * h), (0.545 * w, 1.02 * h), (0.492 * w, 0.820 * h),
            (0.392 * w, 0.820 * h)]
    art.poly(road, fill=(55, 50, 42), alpha=255)
    art.line([(0.360 * w, 1.02 * h), (0.410 * w, 0.822 * h)], fill=(105, 96, 80), alpha=24,
             width=max(2, int(7 * s)))
    art.line([(0.515 * w, 1.02 * h), (0.470 * w, 0.822 * h)], fill=(105, 96, 80), alpha=24,
             width=max(2, int(7 * s)))
    # footprints through the arch
    for i in range(8):
        t = i / 7
        fx = (0.447 - 0.020 * t) * w
        fy = (0.985 - 0.110 * t) * h
        art.ellipse(fx, fy, fx + 2.6 * s, fy + 1.4 * s, fill=(120, 111, 95), alpha=24)

    # the wall and its arch
    ax, aw = 0.440 * w, 0.300 * w
    spring = 0.735 * h
    wall_with_arch(art, -10, w + 10, 0.430 * h, 1.04 * h, ax, aw, spring,
                   color=(37, 33, 28))
    # snow cap
    rng = np.random.default_rng(8)
    pts = [(0, 0.430 * h)]
    for i in range(41):
        x = w * i / 40
        pts.append((x, 0.430 * h - rng.uniform(0.004, 0.014) * h))
    pts += [(w, 0.430 * h), (w, 0.444 * h), (0, 0.444 * h)]
    art.poly(pts, fill=(182, 174, 156), alpha=165)
    art.line([(0, 0.431 * h), (w, 0.431 * h)], fill=(208, 198, 178), alpha=70,
             width=max(1, int(1.4 * s)))

    # wall lantern
    lx, ly = 0.607 * w, 0.560 * h
    art.line([(lx, ly - 0.055 * h), (lx, ly - 0.018 * h)], fill=(28, 24, 20), alpha=255,
             width=max(2, int(2.4 * s)))
    art.poly([(lx - 0.016 * w, ly - 0.018 * h), (lx + 0.016 * w, ly - 0.018 * h),
              (lx + 0.012 * w, ly + 0.020 * h), (lx - 0.012 * w, ly + 0.020 * h)],
             fill=(34, 29, 24), alpha=255)
    art.rect(lx - 0.010 * w, ly - 0.012 * h, lx + 0.010 * w, ly + 0.018 * h,
             fill=(255, 196, 118), alpha=235)
    art.line([(lx, ly - 0.018 * h), (lx, ly - 0.005 * h)], fill=(34, 29, 24), alpha=255,
             width=max(1, int(1.4 * s)))
    art.glow(lx, ly, 0.055 * w, color=(255, 188, 108), strength=0.50, power=2.2)

    # sign on the right pier
    signboard(art, 0.735 * w, 0.610 * h, 0.135 * w, 0.080 * h,
              ["SIMSARA", "41", "do not count the bells"], tilt=-0.024)
    art.line([(0.675 * w, 0.515 * h), (0.673 * w, 0.570 * h)], fill=(70, 62, 50), alpha=230,
             width=max(1, int(2.0 * s)))
    art.line([(0.795 * w, 0.515 * h), (0.797 * w, 0.570 * h)], fill=(70, 62, 50), alpha=230,
             width=max(1, int(2.0 * s)))
    art.line([(0.655 * w, 0.515 * h), (0.815 * w, 0.515 * h)], fill=(57, 50, 41), alpha=240,
             width=max(2, int(3 * s)))
    art.glow(0.737 * w, 0.612 * h, 0.075 * w, color=(220, 160, 92), strength=0.10, power=2.2)

    # the one walking in
    art.figure(0.440 * w, 0.972 * h, 0.145 * h, color=(9, 9, 8), alpha=255, pack=True, lean=0.01)
    art.glow(0.440 * w, 0.915 * h, 0.035 * w, color=(210, 170, 110), strength=0.06)

    crow(art, 0.185 * w, 0.415 * h, size=1.5)

    # snow flecks
    rng = np.random.default_rng(6)
    for _ in range(260):
        x = rng.uniform(0, w)
        y = rng.uniform(0.20, 1.0) * h
        sz = rng.uniform(0.5, 1.7) * s
        art.ellipse(x, y, x + sz, y + sz, fill=(200, 190, 170), alpha=int(rng.integers(10, 48)))

    art.vignette(amount=0.38, power=2.0)
    art.finish(grain=0.012, contrast=1.04)
    return resize_save(art.img, out, W, H)


if __name__ == "__main__":
    scale = float(sys.argv[1]) if len(sys.argv) > 1 else 2
    out = sys.argv[2] if len(sys.argv) > 2 else "plate_01_gate.png"
    render(scale=scale, out=out)
    print("wrote", out)
