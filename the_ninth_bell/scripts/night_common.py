"""Shared night-scene helpers for the interior plates."""
from __future__ import annotations

import math
import numpy as np

from artlib import (Art, INK, FOG, FOG_LIGHT, AMBER, AMBER_LIGHT, BONE, RUST,
                    dark_base, smoothstep, lerp)


def night(W, H, scale=2, seed=1, horizon=0.64):
    art = Art(W, H, scale=scale, seed=seed,
              base=dark_base(int(W * scale), int(H * scale), seed=seed,
                             top=(12, 12, 12), mid=(33, 30, 26), bottom=(18, 17, 15)))
    w, h = art.w, art.h
    arr = art.arr()
    yy = np.arange(h, dtype=np.float32)[:, None] / h
    arr *= (0.82 + 0.28 * smoothstep(0.0, 0.66, yy))[..., None]
    art.set_arr(arr)
    return art


def stars(art, n=70, ymax=0.48, seed=3):
    rng = np.random.default_rng(seed)
    w, h = art.w, art.h
    for _ in range(n):
        x = rng.uniform(0.01, 0.99) * w
        y = rng.uniform(0.01, ymax) * h
        sz = rng.uniform(0.5, 1.8) * art.s
        art.ellipse(x, y, x + sz, y + sz, fill=(205, 196, 176),
                    alpha=int(rng.integers(16, 62)))


def mountains(art, base_y, layers=4, seed=11, amp=0.024, step=0.026,
              top=(56, 51, 43), bottom=(82, 74, 61)):
    h = art.h
    for i in range(layers):
        t = i / max(1, layers - 1)
        y0 = base_y + i * step * h
        top_c = lerp(np.asarray(top, np.float32), np.asarray((17, 16, 14), np.float32), t * 0.9)
        bot_c = lerp(np.asarray(bottom, np.float32), np.asarray((26, 24, 20), np.float32), t * 0.9)
        art.ridge(y0 * h, amp * h * (1 - 0.10 * i), seed + i * 13,
                  color_top=tuple(top_c.astype(int)), color_bottom=tuple(bot_c.astype(int)),
                  rim=(88, 80, 67), rim_alpha=14, softness=1.8 - 0.2 * i,
                  octaves=6, massifs=3)
        if i < layers - 1:
            art.fog(y0 * h - 0.02 * h, y0 * h + 0.055 * h,
                    color=(88, 82, 73), strength=0.08, seed=seed + i * 31,
                    streak=0.6, softness=0.10)


def village(art, cx, base, width, n=8, lit=0.45, seed=5, color=(20, 18, 16),
            min_w=0.035, max_w=0.075):
    rng = np.random.default_rng(seed)
    w, h = art.w, art.h
    houses = []
    for i in range(n):
        hw = rng.uniform(min_w, max_w) * width
        hh = hw * rng.uniform(0.50, 0.78)
        hx = cx + rng.uniform(-0.5, 0.5) * width - hw / 2
        hy = base + rng.uniform(-0.012, 0.020) * h
        is_lit = rng.random() < lit
        houses.append((hy, hx, hw, hh, is_lit, rng.choice([-1, 1])))
    houses.sort(key=lambda t: t[0])
    lights = []
    for hy, hx, hw, hh, is_lit, side in houses:
        art.house(hx, hy, hw, hh, color=color, alpha=255, lit=is_lit,
                  detail=False, chimney=True, side=side)
        if is_lit:
            lights.append((hx + hw * 0.10, hy - hh * 0.42, hw * 0.30))
    return lights


def glow_lights(art, lights, strength=0.5):
    for lx, ly, lr in lights:
        art.glow(lx, ly, lr * 3.0, color=(238, 176, 96), strength=strength * 0.55, power=2.5)
        art.glow(lx, ly, lr * 0.9, color=(255, 206, 132), strength=strength, power=2.0)


def snow_ground(art, y, seed=7, tone=(38, 35, 30), tracks=None):
    art.ridge(y * art.h, 0.020 * art.h, seed,
              color=(tone[0] - 4, tone[1] - 4, tone[2] - 4),
              color_bottom=(tone[0] + 6, tone[1] + 5, tone[2] + 4),
              octaves=6, massifs=3, softness=1.0)
    rng = np.random.default_rng(seed + 5)
    w, h = art.w, art.h
    for _ in range(int(0.00004 * w * h / max(art.s, 1))):
        x = rng.uniform(0, w)
        yv = rng.uniform(y, 1.0) * h
        ln = rng.uniform(0.003, 0.013) * h
        art.line([(x, yv), (x + rng.uniform(-0.004, 0.004) * w, yv - ln)],
                 fill=(78, 71, 59), alpha=int(rng.integers(10, 34)), width=max(1, int(art.s)))
    if tracks:
        for t in tracks:
            art.line(t, fill=(120, 112, 96), alpha=22, width=max(2, int(5 * art.s)))


def stone_block(art, x0, y0, x1, y1, color=(45, 40, 34), alpha=255, courses=8, seed=1):
    s = art.s
    art.rect(x0, y0, x1, y1, fill=color, alpha=alpha)
    rng = np.random.default_rng(seed)
    for i in range(1, courses):
        yv = y0 + (y1 - y0) * i / courses
        art.line([(x0 + 2 * s, yv), (x1 - 2 * s, yv)], fill=(150, 139, 119), alpha=24,
                 width=max(1, int(0.9 * s)))
    for i in range(courses):
        yv = y0 + (y1 - y0) * (i + 0.5) / courses
        cols = max(2, int((x1 - x0) / (18 * s)))
        for j in range(cols):
            xv = x0 + (x1 - x0) * (j + 0.5 + 0.22 * (i % 2)) / cols
            if xv >= x1:
                continue
            art.line([(xv, yv), (xv, yv - (y1 - y0) / courses * 0.9)],
                     fill=(150, 139, 119), alpha=18, width=1)
    # shadowed right edge
    art.hatch([(x1 - (x1 - x0) * 0.18, y0), (x1, y0), (x1, y1), (x1 - (x1 - x0) * 0.18, y1)],
              angle=80, spacing=6 * s, color=(8, 8, 7), alpha=30, width=max(1, int(s)),
              jitter=1.0 * s)


def signboard(art, cx, cy, w, h, lines, tilt=-0.035, seed=4):
    """A hanging wooden board with painted lettering (drawn flat, then rotated)."""
    from PIL import Image, ImageDraw
    from artlib import font
    s = art.s
    pad = int(6 * s)
    board = Image.new("RGBA", (int(w + 2 * pad), int(h + 2 * pad)), (0, 0, 0, 0))
    d = ImageDraw.Draw(board)
    bw, bh = int(w), int(h)
    d.rectangle([pad, pad, pad + bw, pad + bh], fill=(62, 52, 41, 255),
                outline=(26, 22, 18, 255), width=max(2, int(2 * s)))
    # wood grain
    for i in range(7):
        yy = pad + bh * (i + 0.5) / 7
        d.line([(pad + 3 * s, yy), (pad + bw - 3 * s, yy + (i % 2 - 0.5) * 3 * s)],
               fill=(40, 33, 26, 90), width=max(1, int(s)))
    f1 = font("pala.ttf", int(bh * 0.30))
    f2 = font("pala.ttf", int(bh * 0.155))
    # lettering
    txt_w = sum(d.textlength(c, font=f1) for c in lines[0])
    d.text((pad + bw / 2, pad + bh * 0.30), lines[0], font=f1, fill=(214, 202, 181, 235), anchor="mm")
    d.text((pad + bw / 2, pad + bh * 0.56), lines[1], font=f1, fill=(214, 202, 181, 235), anchor="mm")
    d.text((pad + bw / 2, pad + bh * 0.80), lines[2], font=f2, fill=(170, 94, 62, 235), anchor="mm")
    board = board.rotate(tilt, resample=Image.BICUBIC, center=(pad + bw / 2, pad + bh / 2))
    art.img.alpha_composite(board, (int(cx - board.width / 2), int(cy - board.height / 2)))
    art.d = ImageDraw.Draw(art.img, "RGBA")
