"""Plate III - the lamp in the window."""
from __future__ import annotations

import math
import sys
import numpy as np
from PIL import Image, ImageDraw, ImageFilter

from artlib import Art, INK, AMBER_LIGHT, BONE, font, smoothstep, fbm, noise_streaks, resize_save
from night_common import night, mountains

W, H = 2000, 1250


def render(scale=2, out="plate_03_window.png"):
    art = night(W, H, scale=scale, seed=95)
    s = scale
    w, h = art.w, art.h

    # stone wall
    arr = art.arr()
    yy = np.linspace(0, 1, h, dtype=np.float32)[:, None, None]
    arr = np.array([0.085, 0.075, 0.062], np.float32) * (0.8 + 0.3 * (1 - yy))
    arr = np.repeat(arr, w, axis=1)
    arr *= (0.85 + 0.25 * fbm(w, h, base=7, octaves=5, seed=2)[..., None])
    art.set_arr(arr)
    rng = np.random.default_rng(4)
    for i in range(1, 9):
        yv = h * i / 9
        art.line([(0, yv), (w, yv + rng.uniform(-3, 3))], fill=(150, 136, 112), alpha=16,
                 width=max(1, int(1.2 * s)))
    for i in range(24):
        x = rng.uniform(0, w)
        y = rng.uniform(0, h)
        art.line([(x, y), (x, y + rng.uniform(20, 80) * s)], fill=(150, 136, 112), alpha=12,
                 width=1)

    # window opening
    x0, x1 = 0.365 * w, 0.735 * w
    y0, y1 = 0.150 * h, 0.690 * h
    # interior light gradient
    mask = Image.new("L", (w, h), 0)
    ImageDraw.Draw(mask).rectangle([x0, y0, x1, y1], fill=255)
    t = np.linspace(0, 1, h, dtype=np.float32)[:, None, None]
    top_c = np.array([255, 222, 168], np.float32)
    bot_c = np.array([176, 112, 58], np.float32)
    grad = top_c * (1 - t) + bot_c * t
    grad = np.repeat(grad, w, axis=1)
    grad *= (0.9 + 0.2 * fbm(w, h, base=9, octaves=5, seed=8)[..., None])
    layer = Image.fromarray(np.clip(grad, 0, 255).astype(np.uint8), "RGB").convert("RGBA")
    layer.putalpha(mask)
    art.img.alpha_composite(layer)
    art.d = ImageDraw.Draw(art.img, "RGBA")

    # interior: desk, ledger, seated woman
    dk = (48, 26, 14)
    desk_y = 0.575 * h
    art.rect(x0 + 0.03 * w, desk_y, x1 - 0.02 * w, desk_y + 0.030 * h, fill=dk, alpha=255)
    # ledger on the desk
    art.poly([(0.560 * w, desk_y + 0.004 * h), (0.660 * w, desk_y + 0.004 * h),
              (0.668 * w, desk_y + 0.028 * h), (0.555 * w, desk_y + 0.028 * h)],
             fill=(66, 38, 20), alpha=255)
    art.line([(0.607 * w, desk_y + 0.004 * h), (0.607 * w, desk_y + 0.028 * h)],
             fill=(42, 24, 13), alpha=255, width=max(1, int(1.4 * s)))
    # chair back
    art.rect(0.505 * w, 0.440 * h, 0.545 * w, 0.590 * h, fill=(54, 30, 17), alpha=255)
    # woman: hair, head, shoulders, arm
    hx, hy = 0.525 * w, 0.405 * h
    art.ellipse(hx - 0.035 * w, hy - 0.040 * h, hx + 0.035 * w, hy + 0.040 * h,
                fill=(58, 32, 18), alpha=255)
    art.ellipse(hx - 0.018 * w, hy - 0.052 * h, hx + 0.012 * w, hy - 0.030 * h,
                fill=(58, 32, 18), alpha=255)
    art.poly([(0.475 * w, 0.520 * h), (0.490 * w, 0.455 * h), (0.515 * w, 0.440 * h),
              (0.550 * w, 0.445 * h), (0.570 * w, 0.480 * h), (0.565 * w, 0.560 * h),
              (0.480 * w, 0.560 * h)], fill=(52, 29, 16), alpha=255)
    # arm to the pen
    art.line([(0.552 * w, 0.465 * h), (0.590 * w, 0.540 * h), (0.620 * w, 0.565 * h)],
             fill=(52, 29, 16), alpha=255, width=max(4, int(0.018 * h)))
    art.line([(0.620 * w, 0.565 * h), (0.638 * w, 0.548 * h)], fill=(40, 23, 13), alpha=255,
             width=max(2, int(0.006 * h)))
    # lamp on the desk
    lamp_x, lamp_y = 0.690 * w, 0.545 * h
    art.rect(lamp_x - 0.018 * w, lamp_y, lamp_x + 0.018 * w, lamp_y + 0.030 * h,
             fill=(70, 40, 20), alpha=255)
    art.ellipse(lamp_x - 0.020 * w, lamp_y - 0.050 * h, lamp_x + 0.020 * w, lamp_y + 0.010 * h,
                fill=(255, 214, 150), alpha=255)
    art.glow(lamp_x, lamp_y - 0.02 * h, 0.12 * w, color=(255, 200, 125), strength=0.50, power=2.2)

    # window frame
    fw = 22 * s
    art.rect(x0 - fw, y0 - fw, x1 + fw, y0, fill=(26, 22, 18), alpha=255)
    art.rect(x0 - fw, y1, x1 + fw, y1 + fw, fill=(26, 22, 18), alpha=255)
    art.rect(x0 - fw, y0, x0, y1, fill=(26, 22, 18), alpha=255)
    art.rect(x1, y0, x1 + fw, y1, fill=(26, 22, 18), alpha=255)
    # mullions
    mx = (x0 + x1) / 2
    my = (y0 + y1) / 2
    art.rect(mx - 8 * s, y0, mx + 8 * s, y1, fill=(30, 25, 20), alpha=255)
    art.rect(x0, my - 8 * s, x1, my + 8 * s, fill=(30, 25, 20), alpha=255)
    art.line([(mx - 8 * s, y0), (mx - 8 * s, y1)], fill=(120, 100, 76), alpha=32,
             width=max(1, int(1.2 * s)))
    art.line([(x0, my - 8 * s), (x1, my - 8 * s)], fill=(120, 100, 76), alpha=32,
             width=max(1, int(1.2 * s)))

    # curtains at the sides
    art.poly([(x0 - fw, y0 - fw), (x0 + 0.035 * w, y0 - fw), (x0 + 0.020 * w, y1 + fw),
              (x0 - fw, y1 + fw)], fill=(38, 24, 18), alpha=255)
    art.poly([(x1 - 0.035 * w, y0 - fw), (x1 + fw, y0 - fw), (x1 + fw, y1 + fw),
              (x1 - 0.020 * w, y1 + fw)], fill=(36, 23, 17), alpha=255)
    for i in range(6):
        fx = x0 - fw + i * 0.012 * w
        art.line([(fx, y0 - fw), (fx + 0.010 * w, y1 + fw)], fill=(14, 10, 8), alpha=50,
                 width=max(1, int(1.2 * s)))

    # snow on the sill
    art.poly([(x0 - fw, y1 + fw), (x1 + fw, y1 + fw), (x1 + fw, y1 + fw + 0.035 * h),
              (x0 - fw, y1 + fw + 0.045 * h)], fill=(170, 164, 148), alpha=235)
    rng = np.random.default_rng(9)
    for i in range(30):
        sx = rng.uniform(x0 - fw, x1 + fw)
        sy = y1 + fw + rng.uniform(0, 0.035) * h
        r = rng.uniform(2, 8) * s
        art.ellipse(sx, sy, sx + r, sy + r * 0.6, fill=(198, 190, 172), alpha=180)
    # icicles
    for i in range(12):
        ix = x0 - fw + (x1 - x0 + 2 * fw) * (i + 0.5) / 12
        ln = rng.uniform(0.015, 0.055) * h
        art.poly([(ix - 3 * s, y1 + fw + 0.030 * h), (ix + 3 * s, y1 + fw + 0.030 * h),
                  (ix, y1 + fw + 0.030 * h + ln)], fill=(190, 184, 168), alpha=160)

    # condensation / reflections on the glass
    for i in range(22):
        gx = rng.uniform(x0, x1)
        gy = rng.uniform(y0, my)
        r = rng.uniform(2, 6) * s
        art.ellipse(gx, gy, gx + r, gy + r, fill=(255, 240, 210), alpha=18)
    for i in range(9):
        gx = rng.uniform(x0, x1)
        art.line([(gx, y0), (gx + rng.uniform(-0.02, 0.02) * w, my)],
                 fill=(255, 245, 220), alpha=16, width=max(1, int(s)))

    # outside: snow, branch, arriving figure
    art.ridge(0.86 * h, 0.018 * h, 71, color=(26, 24, 20), color_bottom=(40, 36, 31),
              octaves=6, massifs=3, softness=1.0)
    art.poly([(0, 0.95 * h), (w, 0.94 * h), (w, h), (0, h)], fill=(54, 50, 43), alpha=255)
    for i in range(50):
        sx = rng.uniform(0, w)
        sy = rng.uniform(0.94, 1.0) * h
        art.line([(sx, sy), (sx + rng.uniform(-6, 6) * s, sy - rng.uniform(3, 14) * s)],
                 fill=(110, 102, 88), alpha=30, width=1)
    art.bare_tree(0.085 * w, 0.960 * h, 0.34 * h, color=(13, 12, 10), alpha=250, depth=8, seed=4, lean=0.05)
    art.figure(0.175 * w, 0.955 * h, 0.115 * h, color=(10, 10, 9), alpha=255, pack=True, lean=0.01)
    # footprints
    for i in range(6):
        fx = 0.175 * w + i * 0.025 * w
        fy = 0.958 * h - i * 0.004 * h
        art.ellipse(fx, fy, fx + 3 * s, fy + 2 * s, fill=(120, 112, 97), alpha=30)

    # window glow outside
    art.glow(0.55 * w, 0.55 * h, 0.35 * w, color=(255, 188, 110), strength=0.22, power=2.2)

    art.vignette(amount=0.55, power=1.7)
    art.finish(grain=0.015, contrast=1.05)
    return resize_save(art.img, out, W, H)


if __name__ == "__main__":
    scale = float(sys.argv[1]) if len(sys.argv) > 1 else 2
    out = sys.argv[2] if len(sys.argv) > 2 else "plate_03_window.png"
    render(scale=scale, out=out)
    print("wrote", out)
