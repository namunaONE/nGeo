"""Plate III - the open door."""
from __future__ import annotations

import math
import sys
import numpy as np
from PIL import Image, ImageDraw, ImageFilter

from artlib import Art, INK, AMBER_LIGHT, BONE, font, smoothstep, fbm, noise_streaks, resize_save
from night_common import night, stars, mountains

W, H = 1600, 2000


def woman_lantern(art, x, base, h):
    s = art.s
    ink = (11, 10, 8)
    head_cy = base - h * 0.92
    hrx, hry = h * 0.042, h * 0.052
    # hair and bun
    art.ellipse(x - hrx * 1.25, head_cy - hry * 1.10, x + hrx * 1.05, head_cy + hry * 1.02,
                fill=(14, 12, 10), alpha=255)
    art.ellipse(x - hrx * 1.0, head_cy - hry * 1.48, x + hrx * 0.25, head_cy - hry * 0.92,
                fill=(14, 12, 10), alpha=255)
    art.ellipse(x - hrx, head_cy - hry, x + hrx, head_cy + hry, fill=ink, alpha=255)
    # neck
    art.rect(x - hrx * 0.38, head_cy + hry * 0.75, x + hrx * 0.38, head_cy + hry * 1.65,
             fill=ink, alpha=255)
    sh_y = base - h * 0.835
    # coat
    coat = [(x - h * 0.070, sh_y), (x - h * 0.078, base - h * 0.58),
            (x - h * 0.098, base - h * 0.30), (x - h * 0.052, base - h * 0.275),
            (x - h * 0.018, base - h * 0.335), (x + h * 0.020, base - h * 0.335),
            (x + h * 0.058, base - h * 0.275), (x + h * 0.098, base - h * 0.30),
            (x + h * 0.078, base - h * 0.58), (x + h * 0.070, sh_y),
            (x, sh_y - h * 0.012)]
    art.poly(coat, fill=ink, alpha=255)
    # shawl
    shawl = [(x - h * 0.088, sh_y + h * 0.008), (x - h * 0.040, sh_y - h * 0.005),
             (x + h * 0.040, sh_y - h * 0.005), (x + h * 0.088, sh_y + h * 0.008),
             (x + h * 0.072, base - h * 0.52), (x + h * 0.020, base - h * 0.56),
             (x, base - h * 0.50), (x - h * 0.026, base - h * 0.56),
             (x - h * 0.078, base - h * 0.52)]
    art.poly(shawl, fill=(23, 21, 17), alpha=255)
    for k in range(7):
        fx = x - h * 0.070 + k * h * 0.023
        art.line([(fx, base - h * 0.53), (fx + 2 * s, base - h * 0.57)],
                 fill=(31, 28, 23), alpha=255, width=max(1, int(1.4 * s)))
    # belt
    art.line([(x - h * 0.074, base - h * 0.585), (x + h * 0.074, base - h * 0.585)],
             fill=(27, 24, 20), alpha=255, width=max(2, int(h * 0.007)))
    # legs
    for side in (-1, 1):
        lx = x + side * h * 0.032
        art.line([(lx, base - h * 0.33), (lx + side * h * 0.006, base - h * 0.035)],
                 fill=ink, alpha=255, width=max(4, int(h * 0.032)))
        art.line([(lx - h * 0.018, base - h * 0.02), (lx + side * h * 0.030, base - h * 0.02)],
                 fill=ink, alpha=255, width=max(4, int(h * 0.022)))
    # left arm
    art.line([(x - h * 0.066, sh_y + h * 0.012), (x - h * 0.086, base - h * 0.58),
              (x - h * 0.075, base - h * 0.49)],
             fill=ink, alpha=255, width=max(4, int(h * 0.028)))
    # right arm holding the lantern
    art.line([(x + h * 0.066, sh_y + h * 0.012), (x + h * 0.092, base - h * 0.60),
              (x + h * 0.100, base - h * 0.525)],
             fill=ink, alpha=255, width=max(4, int(h * 0.028)))
    # lantern
    lx, ly = x + h * 0.102, base - h * 0.505
    art.line([(lx, ly - h * 0.045), (lx, ly - h * 0.015)], fill=(26, 22, 18), alpha=255,
             width=max(1, int(2.0 * s)))
    art.poly([(lx - h * 0.026, ly - h * 0.015), (lx + h * 0.026, ly - h * 0.015),
              (lx + h * 0.020, ly + h * 0.045), (lx - h * 0.020, ly + h * 0.045)],
             fill=(252, 198, 122), alpha=245)
    art.rect(lx - h * 0.030, ly + h * 0.045, lx + h * 0.030, ly + h * 0.052,
             fill=(24, 20, 17), alpha=255)
    art.line([(lx - h * 0.030, ly - h * 0.015), (lx + h * 0.030, ly - h * 0.015)],
             fill=(24, 20, 17), alpha=255, width=max(2, int(2.4 * s)))
    # rim light down the left of the figure
    art.line([(x - h * 0.070, sh_y), (x - h * 0.078, base - h * 0.58),
              (x - h * 0.096, base - h * 0.31)],
             fill=(146, 132, 110), alpha=34, width=max(1, int(1.6 * s)))
    art.d.arc([x - hrx * 1.15, head_cy - hry * 1.15, x + hrx * 1.15, head_cy + hry * 1.15],
              120, 240, fill=(146, 132, 110, 36), width=max(1, int(1.4 * s)))
    return (lx, ly + h * 0.010)


def render(scale=2, out="plate_03_door.png"):
    art = night(W, H, scale=scale, seed=91)
    s = scale
    w, h = art.w, art.h

    # interior wall
    arr = art.arr()
    yy = np.linspace(0, 1, h, dtype=np.float32)[:, None, None]
    arr = np.array([0.070, 0.060, 0.050], np.float32) * (0.8 + 0.35 * (1 - yy))
    arr = np.repeat(arr, w, axis=1)
    tex = fbm(w, h, base=8, octaves=5, seed=2)
    arr *= (0.85 + 0.25 * tex[..., None])
    art.set_arr(arr)

    # floorboards
    fy = 0.845 * h
    art.rect(0, fy, w, h, fill=(24, 20, 17), alpha=255)
    for i in range(9):
        yv = fy + (h - fy) * (i + 1) / 9
        art.line([(0, yv), (w, yv)], fill=(58, 48, 38), alpha=45, width=max(1, int(1.4 * s)))
    for i in range(7):
        xv = w * (i + 0.5) / 7
        art.line([(xv, fy), (xv + (xv - w / 2) * 0.25, h)], fill=(12, 10, 9), alpha=90,
                 width=max(1, int(1.2 * s)))

    # doorway
    dx0, dx1 = 0.315 * w, 0.675 * w
    dy0, dy1 = 0.115 * h, 0.865 * h
    # fog beyond
    mask = Image.new("L", (w, h), 0)
    ImageDraw.Draw(mask).rectangle([dx0, dy0, dx1, dy1], fill=255)
    yy2 = np.linspace(0, 1, h, dtype=np.float32)[:, None, None]
    t = np.clip((yy2 - dy0 / h) / ((dy1 - dy0) / h), 0, 1)
    top_c = np.array([150, 141, 124], np.float32)
    bot_c = np.array([84, 78, 68], np.float32)
    grad = top_c * (1 - t) + bot_c * t
    grad = np.repeat(grad, w, axis=1)
    grad *= (0.9 + 0.2 * fbm(w, h, base=10, octaves=5, seed=7)[..., None])
    layer = Image.fromarray(np.clip(grad, 0, 255).astype(np.uint8), "RGB").convert("RGBA")
    layer.putalpha(mask.filter(ImageFilter.GaussianBlur(1.5 * s)))
    art.img.alpha_composite(layer)
    art.d = ImageDraw.Draw(art.img, "RGBA")

    # distant lane and window in the fog
    art.line([(0.45 * w, 0.90 * h), (0.50 * w, 0.55 * h)], fill=(185, 175, 155), alpha=35,
             width=max(2, int(9 * s)))
    art.rect(0.585 * w, 0.505 * h, 0.610 * w, 0.535 * h, fill=(255, 200, 122), alpha=220)
    art.glow(0.597 * w, 0.520 * h, 0.045 * w, color=(255, 190, 110), strength=0.45)
    # far roofs
    for i in range(4):
        hx = 0.34 * w + i * 0.075 * w
        art.house(hx, 0.66 * h + (i % 2) * 0.02 * h, 0.065 * w, 0.030 * h,
                  color=(70, 64, 55), alpha=255, lit=False, detail=False, chimney=False)

    # door frame (four members, so the opening stays open)
    fw = 28 * s
    art.rect(dx0 - fw, dy0 - fw, dx1 + fw, dy0, fill=(20, 17, 14), alpha=255)
    art.rect(dx0 - fw, dy0, dx0, dy1, fill=(20, 17, 14), alpha=255)
    art.rect(dx1, dy0, dx1 + fw, dy1, fill=(20, 17, 14), alpha=255)
    art.rect(dx0 - fw, dy1, dx1 + fw, dy1 + fw, fill=(20, 17, 14), alpha=255)
    art.d.rectangle([dx0, dy0, dx1, dy1], outline=(12, 10, 9, 200), width=max(2, int(4 * s)))

    # open door panel, swung toward the viewer on the left
    door = [(dx0, dy0), (0.105 * w, 0.175 * h), (0.125 * w, 0.955 * h), (dx0, dy1)]
    art.poly(door, fill=(31, 26, 21), alpha=255)
    art.hatch(door, angle=82, spacing=8 * s, color=(8, 7, 6), alpha=45, width=max(1, int(s)),
              jitter=1.2 * s)
    # panels
    for off in (0.08, 0.48):
        p0 = (dx0 - (dx0 - 0.105 * w) * off, dy0 + (0.175 * h - dy0) * off)
        p1 = (0.105 * w + (dx0 - 0.105 * w) * (0.18 + off), 0.175 * h + (0.955 * h - 0.175 * h) * (0.08 + off))
        art.poly([p0, (p0[0] + 0.06 * w, p0[1] + 0.01 * h),
                  (p0[0] + 0.08 * w, p0[1] + 0.28 * h), (p0[0] + 0.015 * w, p0[1] + 0.30 * h)],
                 outline=(14, 12, 10), width=max(1, int(2 * s)))
    # hinges
    for hy in (0.28 * h, 0.72 * h):
        art.ellipse(dx0 - 10 * s, hy - 10 * s, dx0 + 6 * s, hy + 10 * s,
                    fill=(10, 9, 8), alpha=255)
    # door edge highlight
    art.line([(dx0, dy0), (0.105 * w, 0.175 * h), (0.125 * w, 0.955 * h), (dx0, dy1)],
             fill=(120, 102, 78), alpha=40, width=max(1, int(1.8 * s)))

    # the woman in the doorway
    lamp_pos = woman_lantern(art, 0.505 * w, 0.870 * h, 0.555 * h)
    if lamp_pos:
        art.glow(lamp_pos[0], lamp_pos[1], 0.10 * w, color=(255, 190, 108), strength=0.55, power=2.2)
        art.glow(lamp_pos[0], lamp_pos[1], 0.035 * w, color=(255, 218, 160), strength=0.65, power=2.0)

    # light on the floor
    art.poly([(dx0, dy1), (dx1, dy1), (0.72 * w, 1.02 * h), (0.22 * w, 1.02 * h)],
             fill=(218, 160, 92), alpha=9)
    art.glow(0.50 * w, 0.86 * h, 0.35 * w, color=(220, 160, 90), strength=0.20, power=2.0)

    # foreground table with recorder
    ty = 0.92 * h
    art.rect(0, ty, w, h, fill=(12, 11, 10), alpha=255)
    art.line([(0, ty), (w, ty)], fill=(92, 80, 63), alpha=50, width=max(1, int(1.4 * s)))
    # recorder body
    rx, ry = 0.26 * w, 0.945 * h
    art.rect(rx, ry, rx + 0.16 * w, ry + 0.045 * h, fill=(22, 20, 18), alpha=255)
    art.rect(rx + 0.012 * w, ry + 0.008 * h, rx + 0.070 * w, ry + 0.038 * h,
             fill=(34, 31, 27), alpha=255)
    art.rect(rx + 0.082 * w, ry + 0.008 * h, rx + 0.148 * w, ry + 0.038 * h,
             fill=(34, 31, 27), alpha=255)
    for cxr in (rx + 0.035 * w, rx + 0.115 * w):
        art.ellipse(cxr - 0.020 * w, ry + 0.006 * h, cxr + 0.020 * w, ry + 0.040 * h,
                    fill=(9, 9, 8), alpha=255)
        art.ellipse(cxr - 0.011 * w, ry + 0.014 * h, cxr + 0.011 * w, ry + 0.032 * h,
                    fill=(54, 49, 41), alpha=255)
        art.ellipse(cxr - 0.004 * w, ry + 0.020 * h, cxr + 0.004 * w, ry + 0.028 * h,
                    fill=(110, 100, 84), alpha=140)
    # mic stand
    art.line([(0.66 * w, 0.93 * h), (0.70 * w, 0.80 * h)], fill=(28, 25, 21), alpha=255,
             width=max(2, int(3 * s)))
    art.ellipse(0.685 * w, 0.785 * h, 0.715 * w, 0.815 * h, fill=(18, 16, 14), alpha=255)

    art.vignette(amount=0.55, power=1.7)
    art.finish(grain=0.016, contrast=1.05)
    return resize_save(art.img, out, W, H)


if __name__ == "__main__":
    scale = float(sys.argv[1]) if len(sys.argv) > 1 else 2
    out = sys.argv[2] if len(sys.argv) > 2 else "plate_03_door.png"
    render(scale=scale, out=out)
    print("wrote", out)
