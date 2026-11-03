"""Plate I - the sign at the gate (close-up)."""
from __future__ import annotations

import math
import sys
import numpy as np
from PIL import Image, ImageDraw, ImageFilter

from artlib import Art, INK, AMBER_LIGHT, BONE, RUST, paper_base, font, fbm, noise_streaks, resize_save
from night_common import night, stars, mountains, village, glow_lights

W, H = 2000, 1250


def wood_board(w, h, seed=5):
    rng = np.random.default_rng(seed)
    yy = np.linspace(0, 1, h, dtype=np.float32)[:, None, None]
    base = np.array([72, 59, 44], np.float32) * (0.86 + 0.22 * (1 - yy))
    arr = np.repeat(base, w, axis=1)
    grain = fbm(w, h, base=6, octaves=6, seed=seed)
    # stretch grain horizontally
    g2 = noise_streaks(w, h, 6, 18, seed + 3)
    arr *= (0.82 + 0.26 * grain[..., None] + 0.10 * g2[..., None])
    rng2 = np.random.default_rng(seed + 7)
    arr += rng2.normal(0, 4.0, (h, w, 1)).astype(np.float32)
    return np.clip(arr, 0, 255)


def draw_board():
    bw, bh = 1720, 820
    pad = 60
    img = Image.new("RGBA", (bw + 2 * pad, bh + 2 * pad), (0, 0, 0, 0))
    board = wood_board(bw + 2 * pad, bh + 2 * pad, seed=5)
    img = Image.fromarray(board.astype(np.uint8), "RGB").convert("RGBA")
    d = ImageDraw.Draw(img)
    # shape with rough edges
    x0, y0, x1, y1 = pad, pad, pad + bw, pad + bh
    d.rectangle([x0, y0, x1, y1], fill=(0, 0, 0, 0))
    mask = Image.new("L", img.size, 0)
    md = ImageDraw.Draw(mask)
    pts = []
    rng = np.random.default_rng(11)
    for i in range(26):
        pts.append((x0 + (x1 - x0) * i / 25, y0 + rng.uniform(-4, 4)))
    for i in range(10):
        pts.append((x1 + rng.uniform(-4, 4), y0 + (y1 - y0) * i / 9))
    for i in range(26):
        pts.append((x1 - (x1 - x0) * i / 25, y1 + rng.uniform(-4, 4)))
    for i in range(10):
        pts.append((x0 + rng.uniform(-4, 4), y1 - (y1 - y0) * i / 9))
    md.polygon(pts, fill=255)
    wood = Image.fromarray(wood_board(bw + 2 * pad, bh + 2 * pad, seed=9).astype(np.uint8), "RGB").convert("RGBA")
    img = Image.new("RGBA", wood.size, (0, 0, 0, 0))
    img.paste(wood, (0, 0), mask)
    d = ImageDraw.Draw(img)

    # grain and knots
    for i in range(40):
        yy = y0 + (y1 - y0) * rng.uniform(0.03, 0.97)
        d.line([(x0 + 10, yy), (x1 - 10, yy + rng.uniform(-8, 8))],
               fill=(35, 27, 20, int(rng.integers(20, 60))), width=int(rng.integers(1, 4)))
    for _ in range(5):
        kx = rng.uniform(x0 + 60, x1 - 60)
        ky = rng.uniform(y0 + 60, y1 - 60)
        for r in range(10, 34, 6):
            d.ellipse([kx - r, ky - r * 0.42, kx + r, ky + r * 0.42],
                      outline=(35, 27, 20, 55), width=2)
    # border
    inset = 34
    d.rectangle([x0 + inset, y0 + inset, x1 - inset, y1 - inset],
                outline=(176, 160, 132, 110), width=4)
    d.rectangle([x0 + inset + 8, y0 + inset + 8, x1 - inset - 8, y1 - inset - 8],
                outline=(48, 38, 28, 120), width=2)

    # lettering
    cream = (224, 212, 190, 238)
    rust = (146, 62, 42, 235)
    f_sim = font("pala.ttf", 152)
    f_num = font("palab.ttf", 330)
    f_warn = font("pala.ttf", 54)
    d.text((bw / 2 + pad, y0 + 118), "SIMSARA", font=f_sim, fill=cream, anchor="mm")
    # letterspacing
    d.text((bw / 2 + pad, y0 + 350), "41", font=f_num, fill=(214, 200, 176, 240), anchor="mm")
    d.line([(bw / 2 + pad - 250, y0 + 525), (bw / 2 + pad + 250, y0 + 525)],
           fill=(146, 62, 42, 200), width=4)
    d.text((bw / 2 + pad, y0 + 585), "DO NOT COUNT THE BELLS", font=f_warn,
           fill=rust, anchor="mm")
    d.text((bw / 2 + pad, y0 + 655), "SIMSARA  \u00b7  41  \u00b7  THE COUNT IS KEPT",
           font=font("pala.ttf", 30), fill=(180, 166, 142, 170), anchor="mm")

    # wear on the paint
    for _ in range(380):
        x = rng.uniform(x0 + 20, x1 - 20)
        y = rng.uniform(y0 + 20, y1 - 20)
        sz = rng.uniform(1, 4)
        d.ellipse([x, y, x + sz, y + sz], fill=(72, 59, 44, int(rng.integers(20, 90))))
    # nails
    for nx, ny in [(x0 + 55, y0 + 55), (x1 - 55, y0 + 55), (x0 + 55, y1 - 55), (x1 - 55, y1 - 55)]:
        d.ellipse([nx - 12, ny - 12, nx + 12, ny + 12], fill=(34, 28, 22, 255),
                  outline=(150, 128, 96, 150), width=2)
        d.line([(nx, ny + 12), (nx, ny + 80)], fill=(86, 52, 34, 65), width=5)

    # snow on the top edge
    snow = [(x0 - 10, y0 + 2)]
    for i in range(31):
        sx = x0 + (x1 - x0) * i / 30
        snow.append((sx, y0 + rng.uniform(-16, 4)))
    snow += [(x1 + 10, y0 + 2), (x1 + 10, y0 - 14), (x0 - 10, y0 - 14)]
    d.polygon(snow, fill=(196, 188, 169, 200))
    # icicles
    for i in range(14):
        ix = x0 + (x1 - x0) * (i + 0.5) / 14 + rng.uniform(-12, 12)
        ln = rng.uniform(18, 70)
        d.polygon([(ix - 4, y1), (ix + 4, y1), (ix, y1 + ln)],
                  fill=(200, 192, 174, 150))

    return img


def render(scale=2, out="plate_01_sign.png"):
    art = night(W, H, scale=scale, seed=71)
    s = scale
    w, h = art.w, art.h
    stars(art, n=40, ymax=0.35, seed=4)

    mountains(art, 0.560, layers=3, seed=33, amp=0.020, step=0.024)
    art.fog(0.540, 0.700, color=(88, 82, 72), strength=0.14, seed=9, streak=0.6, softness=0.12)
    lights = village(art, 0.50 * w, 0.745 * h, 0.34 * w, n=7, lit=0.5, seed=20,
                     min_w=0.030, max_w=0.050)
    glow_lights(art, lights, strength=0.35)
    art.fog(0.730, 0.900, color=(74, 69, 60), strength=0.20, seed=15, streak=0.55, softness=0.10)

    # faint beam overhead
    art.rect(0.06 * w, 0.020 * h, 0.94 * w, 0.045 * h, fill=(18, 16, 13), alpha=255)
    art.line([(0.06 * w, 0.021 * h), (0.94 * w, 0.021 * h)], fill=(120, 104, 80), alpha=40,
             width=max(1, int(1.4 * s)))

    # board
    board = draw_board()
    # scale board to 0.86 w
    target_w = int(0.86 * w)
    target_h = int(board.height * target_w / board.width)
    board = board.resize((target_w, target_h), Image.LANCZOS)
    board = board.rotate(-1.6, resample=Image.BICUBIC, expand=True)
    bx = int(0.50 * w - board.width / 2)
    by = int(0.46 * h - board.height / 2)
    art.img.alpha_composite(board, (bx, by))
    art.d = ImageDraw.Draw(art.img, "RGBA")

    # chains from the beam to the board
    for cx in (bx + int(0.16 * board.width), bx + int(0.84 * board.width)):
        top_y = 0.045 * h
        bot_y = by + int(0.10 * board.height)
        n = 16
        for i in range(n):
            t0 = i / n
            t1 = (i + 0.65) / n
            x0 = cx - (cx - (bx + board.width / 2)) * 0.05 * t0
            x1 = cx - (cx - (bx + board.width / 2)) * 0.05 * t1
            y0 = top_y + (bot_y - top_y) * t0
            y1 = top_y + (bot_y - top_y) * t1
            art.ellipse(min(x0, x1) - 3 * s, min(y0, y1), max(x0, x1) + 3 * s, max(y0, y1) + 5 * s,
                        outline=(72, 64, 52), width=max(1, int(1.2 * s)))

    # warmth from the left and a cold edge from the right
    art.glow(0.0 * w, 0.52 * h, 0.26 * w, color=(220, 160, 92), strength=0.22, power=2.4)
    art.glow(0.94 * w, 0.60 * h, 0.18 * w, color=(120, 130, 140), strength=0.08, power=2.8)

    # snow drift at the bottom
    art.fog(0.900, 1.0, color=(120, 114, 101), strength=0.25, seed=31, streak=0.5)

    art.vignette(amount=0.48, power=1.8)
    art.finish(grain=0.016, contrast=1.05)
    return resize_save(art.img, out, W, H)


if __name__ == "__main__":
    scale = float(sys.argv[1]) if len(sys.argv) > 1 else 2
    out = sys.argv[2] if len(sys.argv) > 2 else "plate_01_sign.png"
    render(scale=scale, out=out)
    print("wrote", out)
