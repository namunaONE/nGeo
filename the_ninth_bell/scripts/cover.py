"""Cover plate for 'The Ninth Bell' - night ink wash."""
from __future__ import annotations

import math
import sys
import numpy as np
from PIL import Image, ImageDraw

from artlib import (Art, INK, FOG, FOG_LIGHT, AMBER, AMBER_LIGHT, BONE, RUST,
                    dark_base, font, smoothstep, resize_save, add_clouds, noise_streaks)

W, H = 1600, 2200


def moon(art, cx, cy, r):
    w, h = art.w, art.h
    arr = art.arr()
    y0, y1 = max(0, int(cy - r * 2.2)), min(h, int(cy + r * 2.2))
    x0, x1 = max(0, int(cx - r * 2.2)), min(w, int(cx + r * 2.2))
    yy, xx = np.mgrid[y0:y1, x0:x1].astype(np.float32)
    d = np.sqrt((xx - cx) ** 2 + (yy - cy) ** 2)
    ang = np.arctan2(yy - cy, xx - cx)
    edge = r * (1.0 + 0.010 * np.sin(ang * 3 + 0.6) + 0.006 * np.sin(ang * 7))
    disc = np.clip((edge - d) / (2.0 * art.s), 0, 1)
    halo = np.exp(-np.clip(d - r, 0, None) / (r * 0.7)) * (d > r) * 0.55
    sub = arr[y0:y1, x0:x1]
    sub = sub * (1 - halo[..., None] * 0.55)
    col = np.array([235, 225, 202], np.float32) / 255.0
    sub = sub * (1 - disc[..., None] * 0.94) + col[None, None, :] * (disc[..., None] * 0.94)
    # craters
    rng = np.random.default_rng(19)
    for _ in range(16):
        a = rng.uniform(0, 2 * math.pi)
        rr = rng.uniform(0, r * 0.78)
        px = cx + math.cos(a) * rr
        py = cy + math.sin(a) * rr
        cr = rng.uniform(0.035, 0.11) * r
        cd = np.sqrt((xx - px) ** 2 + (yy - py) ** 2)
        cm = np.clip((cr - cd) / (2.0 * art.s), 0, 1) * 0.07
        sub = sub * (1 - cm[..., None]) + np.array([0.55, 0.51, 0.44])[None, None, :] * cm[..., None]
    arr[y0:y1, x0:x1] = sub
    art.set_arr(arr)
    art.glow(cx, cy, r * 3.2, color=(200, 192, 174), strength=0.20, power=2.8)
    art.glow(cx, cy, r * 1.6, color=(238, 228, 205), strength=0.20, power=2.4)


def render(scale=2, out="cover.png"):
    art = Art(W, H, scale=scale, seed=41,
              base=dark_base(int(W * scale), int(H * scale), seed=41,
                             top=(13, 13, 13), mid=(39, 36, 31), bottom=(21, 20, 18)))
    s = scale
    w, h = art.w, art.h

    arr = art.arr()
    yy = np.arange(h, dtype=np.float32)[:, None] / h
    arr *= (0.80 + 0.30 * smoothstep(0.0, 0.65, yy))[..., None]
    art.set_arr(arr)

    moon(art, 0.600 * w, 0.238 * h, 0.062 * w)
    add_clouds(art, 0.15, 0.38, color=(16, 15, 14), strength=0.55, seed=3)
    add_clouds(art, 0.21, 0.32, color=(28, 25, 21), strength=0.30, seed=8)
    for _ in range(95):
        sx = art.rng.uniform(0.02, 0.98) * w
        sy = art.rng.uniform(0.02, 0.44) * h
        sz = art.rng.uniform(0.6, 2.1) * s
        art.ellipse(sx, sy, sx + sz, sy + sz, fill=(205, 196, 176),
                    alpha=int(art.rng.integers(18, 72)))

    # mountains: a far massif broken by overlapping foothills
    art.ridge(0.650 * h, 0.032 * h, 23, fade=0.04, octaves=6, massifs=4,
              color_top=(46, 41, 35), color_bottom=(66, 59, 49),
              rim=(104, 96, 81), rim_alpha=10, softness=2.0)
    art.fog(0.625, 0.720, color=(92, 87, 78), strength=0.08, seed=15, streak=0.55, softness=0.14)
    art.ridge(0.684 * h, 0.020 * h, 61, fade=0.02, octaves=6, massifs=4,
              color_top=(34, 31, 26), color_bottom=(50, 45, 38),
              rim=(86, 79, 67), rim_alpha=10, softness=1.6)
    art.ridge(0.716 * h, 0.016 * h, 67, fade=0.01, octaves=6, massifs=3,
              color_top=(28, 25, 21), color_bottom=(42, 38, 32),
              rim=(74, 68, 57), rim_alpha=9, softness=1.4)
    art.ridge(0.744 * h, 0.013 * h, 71, fade=0.00, octaves=6, massifs=3,
              color_top=(23, 21, 18), color_bottom=(34, 30, 26),
              rim=(64, 58, 49), rim_alpha=9, softness=1.2)
    art.fog(0.710, 0.800, color=(88, 83, 74), strength=0.09, seed=25, streak=0.65, softness=0.12)
    art.ridge(0.775 * h, 0.012 * h, 37, fade=0.00, octaves=6, massifs=3,
              color_top=(18, 17, 15), color_bottom=(27, 24, 20),
              rim=(58, 53, 45), rim_alpha=9, softness=1.0)

    # village shelf
    shelf = 0.802 * h
    art.ridge(shelf, 0.010 * h, 51, color=(28, 25, 21), color_bottom=(44, 39, 33),
              octaves=5, massifs=2, softness=1.0)
    # low stone wall along the terraces
    for t in (0.818, 0.835):
        yv = t * h
        art.line([(0.16 * w, yv), (0.55 * w, yv - 0.004 * h)],
                 fill=(76, 69, 58), alpha=55, width=max(1, int(1.4 * s)))
    # low mist gathering at the village feet
    art.fog(0.790, 0.880, color=(158, 151, 137), strength=0.16, seed=31, streak=0.6, softness=0.08)

    # faint track
    track = []

    lights = []
    houses = [
        (0.268, 0.816, 0.062, 0.036, True, 1),
        (0.332, 0.822, 0.044, 0.027, False, -1),
        (0.378, 0.812, 0.040, 0.025, True, 1),
        (0.420, 0.824, 0.036, 0.023, False, -1),
        (0.458, 0.816, 0.033, 0.021, True, 1),
        (0.300, 0.838, 0.036, 0.022, False, -1),
        (0.350, 0.842, 0.031, 0.020, False, 1),
        (0.440, 0.842, 0.030, 0.019, True, -1),
        (0.230, 0.830, 0.030, 0.019, False, 1),
        (0.490, 0.830, 0.028, 0.018, False, -1),
        (0.406, 0.834, 0.026, 0.017, False, 1),
        (0.322, 0.848, 0.026, 0.017, False, -1),
    ]
    for hx, hy, hw, hh, lit, side in houses:
        art.house(hx * w, hy * h, hw * w, hh * h, color=(20, 18, 16), alpha=255,
                  lit=lit, detail=False, chimney=True, side=side)
        if lit:
            lights.append((hx * w + hw * w * 0.12, hy * h - hh * h * 0.38, 0.021 * w))

    # tower on the right spur
    tx, tb = 0.720 * w, 0.836 * h
    th, tw = 0.205 * h, 0.058 * w
    art.rocks(tx, tb + 0.006 * h, 0.10 * w, 0.030 * h, color=(23, 21, 18), alpha=255, seed=3)
    art.tower(tx, tb, th, tw, color=(17, 15, 13), alpha=255, detail=True, bell=True, roof=True, lit=0.7)
    # moonlit edge
    art.line([(tx - tw / 2 + 2 * s, tb), (tx - tw * 0.39 + 2 * s, tb - th * 0.985)],
             fill=(128, 119, 101), alpha=40, width=max(1, int(1.4 * s)))
    art.line([(tx - tw * 0.39, tb - th * 0.99), (tx - tw * 0.39 - tw * 0.28, tb - th * 1.045)],
             fill=(128, 119, 101), alpha=30, width=max(1, int(s)))
    # warm belfry lamp
    by = tb - th * 0.865
    art.glow(tx, by, 0.020 * w, color=(255, 190, 110), strength=0.55, power=2.4)
    art.ellipse(tx - 1.6 * s, by - 2.5 * s, tx + 1.6 * s, by + 2.5 * s,
                fill=(255, 214, 150), alpha=235)
    lights.append((tx, by, 0.010 * w))
    # keeper's window, low in the shaft
    wy = tb - th * 0.56
    art.rect(tx - tw * 0.09, wy, tx + tw * 0.09, wy + th * 0.030,
             fill=(255, 205, 130), alpha=225)
    art.glow(tx, wy + th * 0.015, 0.020 * w, color=(255, 190, 110), strength=0.35, power=2.4)
    lights.append((tx, wy + th * 0.015, 0.010 * w))

    # foreground
    art.ridge(0.888 * h, 0.026 * h, 77, color=(18, 17, 15), color_bottom=(12, 12, 11),
              octaves=6, massifs=3, softness=1.2)
    for i in range(60):
        gx = art.rng.uniform(0, 1) * w
        gy = art.rng.uniform(0.888, 1.0) * h
        ln = art.rng.uniform(0.004, 0.016) * h
        art.line([(gx, gy), (gx + art.rng.uniform(-0.005, 0.005) * w, gy - ln)],
                 fill=(70, 63, 52), alpha=int(art.rng.integers(14, 42)), width=max(1, int(s)))

    # footprints in the snow
    for i in range(7):
        t = i / 6
        fx = (0.498 - 0.055 * t) * w
        fy = (0.982 - 0.070 * t) * h
        side = 1 if i % 2 == 0 else -1
        art.ellipse(fx + side * 2.2 * s, fy, fx + side * 2.2 * s + 2.4 * s, fy + 1.2 * s,
                    fill=(160, 150, 132), alpha=26)

    # dark treeline on the far bank
    for i in range(48):
        x = art.rng.uniform(0.02, 0.98) * w
        if 0.24 < x / w < 0.56:
            continue
        base = 0.845 * h + art.rng.uniform(-0.01, 0.02) * h
        art.pine(x, base, art.rng.uniform(0.018, 0.040) * h, color=(13, 12, 11),
                 alpha=245, slim=art.rng.uniform(0.7, 1.0), tiers=8)

    # edge trees
    for i in range(4):
        x = (0.018 + 0.040 * i) * w
        base = (0.925 + art.rng.uniform(-0.01, 0.03)) * h
        art.pine(x, base, art.rng.uniform(0.08, 0.15) * h, color=(9, 9, 8),
                 alpha=252, slim=art.rng.uniform(0.85, 1.15))
    for i in range(4):
        x = (0.875 + 0.035 * i) * w
        base = (0.940 + art.rng.uniform(-0.01, 0.025)) * h
        art.pine(x, base, art.rng.uniform(0.06, 0.12) * h, color=(9, 9, 8),
                 alpha=252, slim=art.rng.uniform(0.8, 1.1))
    art.bare_tree(0.072 * w, 0.995 * h, 0.30 * h, color=(10, 10, 9), alpha=250, depth=9, seed=4, lean=0.06)
    art.bare_tree(0.962 * w, 1.005 * h, 0.20 * h, color=(10, 10, 9), alpha=245, depth=8, seed=9, lean=-0.08)

    # the one walking
    lp = art.figure(0.460 * w, 0.942 * h, 0.062 * h, color=(8, 8, 7), alpha=252,
                    pack=True, lean=0.02, lamp=True)
    if lp:
        art.glow(lp[0], lp[1], 0.030 * w, color=(255, 188, 108), strength=0.45, power=2.4)

    for lx, ly, lr in lights:
        art.glow(lx, ly, lr * 2.8, color=(238, 176, 96), strength=0.32, power=2.5)
        art.glow(lx, ly, lr * 0.85, color=(255, 206, 132), strength=0.58, power=2.0)

    art.birds(0.660 * w, 0.335 * h, 0.050 * w, n=6, color=(15, 14, 12), alpha=170, size=1.0)
    art.birds(0.590 * w, 0.150 * h, 0.085 * w, n=5, color=(15, 14, 12), alpha=130, size=0.9)

    # typography
    f_title = font("palab.ttf", 0.056 * h)
    f_sub = font("pala.ttf", 0.0125 * h)
    f_top = font("pala.ttf", 0.0085 * h)
    f_bot = font("pala.ttf", 0.0080 * h)
    gold = (207, 190, 160)

    art.text((0.5 * w, 0.047 * h), "A GHOST STORY", f_top,
             fill=gold, tracking=0.0065 * h, alpha=215)
    art.line([(0.395 * w, 0.059 * h), (0.605 * w, 0.059 * h)], fill=gold, alpha=80,
             width=max(1, int(0.9 * s)))
    art.text((0.5 * w, 0.108 * h), "THE NINTH BELL", f_title, fill=(233, 223, 203),
             tracking=0.0078 * h, alpha=255, shadow=(0, 0, 0), shadow_off=(3, 4), shadow_alpha=160)
    art.line([(0.360 * w, 0.147 * h), (0.640 * w, 0.147 * h)], fill=gold, alpha=95,
             width=max(1, int(1.0 * s)))
    art.text((0.5 * w, 0.162 * h), "A STORY FROM SIMSARA", f_sub,
             fill=gold, tracking=0.0080 * h, alpha=225)

    art.text((0.5 * w, 0.972 * h), "WRITTEN AND ILLUSTRATED FOR THIS EDITION", f_bot,
             fill=(165, 156, 139), tracking=0.0040 * h, alpha=155)

    art.vignette(amount=0.48, power=1.8)
    art.finish(grain=0.015, contrast=1.04)

    return resize_save(art.img, out, W, H)


if __name__ == "__main__":
    scale = float(sys.argv[1]) if len(sys.argv) > 1 else 2
    out = sys.argv[2] if len(sys.argv) > 2 else "cover.png"
    render(scale=scale, out=out)
    print("wrote", out)
