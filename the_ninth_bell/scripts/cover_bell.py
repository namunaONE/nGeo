"""Cover - the bell in the belfry arch."""
from __future__ import annotations

import math
import sys
import numpy as np
from PIL import Image, ImageDraw, ImageFilter

from artlib import (Art, INK, FOG, FOG_LIGHT, AMBER, AMBER_LIGHT, BONE, RUST,
                    font, smoothstep, resize_save, fbm, noise_streaks)

W, H = 1600, 2200


def belfry(art, cx, spring, halfw, bottom, top):
    w, h = art.w, art.h
    mask = Image.new("L", (w, h), 0)
    d = ImageDraw.Draw(mask)
    d.rectangle([cx - halfw, spring, cx + halfw, bottom], fill=255)
    d.ellipse([cx - halfw, spring - halfw, cx + halfw, spring + halfw], fill=255)
    mask = mask.filter(ImageFilter.GaussianBlur(2.0 * art.s))

    yy = np.linspace(0, 1, h, dtype=np.float32)[:, None, None]
    t = np.clip((yy - top) / (bottom - top), 0, 1)
    top_c = np.array([92, 86, 76], np.float32)
    mid_c = np.array([164, 155, 138], np.float32)
    bot_c = np.array([203, 193, 174], np.float32)
    t1 = np.clip(t / 0.55, 0, 1) ** 0.9
    t2 = np.clip((t - 0.55) / 0.45, 0, 1) ** 0.8
    grad = top_c * (1 - t1) + mid_c * t1
    grad = grad * (1 - t2) + bot_c * t2
    grad = np.repeat(grad, w, axis=1)
    tex = fbm(w, h, base=10, octaves=5, seed=4)
    grad *= (0.90 + 0.18 * tex[..., None])
    layer = Image.fromarray(np.clip(grad, 0, 255).astype(np.uint8), "RGB").convert("RGBA")
    layer.putalpha(mask)
    art.img.alpha_composite(layer)
    art.d = ImageDraw.Draw(art.img, "RGBA")

    # moon behind the bell
    arr = art.arr()
    mx, my, mr = cx, top + 0.18 * h, 0.100 * w
    yy2, xx2 = np.mgrid[0:h, 0:w].astype(np.float32)
    dd = np.sqrt((xx2 - mx) ** 2 + (yy2 - my) ** 2)
    disc = np.clip((mr - dd) / (2.0 * art.s), 0, 1)
    disc *= np.asarray(mask, np.float32) / 255.0
    col = np.array([228, 219, 198], np.float32) / 255.0
    arr = arr * (1 - disc[..., None] * 0.65) + col[None, None, :] * (disc[..., None] * 0.65)
    art.set_arr(arr)
    art.glow(mx, my, mr * 3.2, color=(215, 205, 185), strength=0.22, power=2.8)

    # fog streaks in the opening
    arr = art.arr()
    n = noise_streaks(w, h, 8, 38, 11)
    ymask = np.exp(-((yy[:, 0] - 0.58) / 0.18) ** 2)[:, None] * (np.asarray(mask, np.float32) / 255.0)[..., None]
    a = np.clip(n[..., None] * ymask * 0.35, 0, 0.45)
    arr = arr * (1 - a) + np.array([0.80, 0.77, 0.70]) * a
    art.set_arr(arr)


def draw_bell(art, cx, top, width, height, color=(18, 16, 14)):
    s = art.s
    lip_y = top + height
    half = width / 2
    n = 80

    def profile(t):
        r = (0.32 + 0.43 * smoothstep(0.0, 0.38, t) +
             0.15 * smoothstep(0.38, 0.90, t) +
             0.10 * smoothstep(0.90, 1.0, t))
        r -= 0.020 * math.exp(-((t - 0.56) / 0.20) ** 2)
        return r

    right = [(cx + profile(i / n) * half, top + (i / n) * height) for i in range(n + 1)]
    left = [(cx - profile(i / n) * half, top + (i / n) * height) for i in range(n + 1)]
    body = right + [(cx + half * 1.08, lip_y + 0.010 * height),
                    (cx - half * 1.08, lip_y + 0.010 * height)] + list(reversed(left))
    art.poly(body, fill=color, alpha=255)

    # right-hand shadow hatch
    shade = [(cx + profile(t) * half, top + t * height) for t in np.linspace(0.05, 0.98, 18)]
    shade += [(cx + half * 1.08, lip_y), (cx + half * 0.20, lip_y), (cx, top)]
    art.hatch(shade, angle=78, spacing=7 * s, color=(5, 5, 4), alpha=38,
              width=max(1, int(s)), jitter=1.1 * s)

    # decorative bands
    for t, al in ((0.18, 16), (0.34, 14), (0.50, 12), (0.66, 14), (0.82, 16)):
        art.line([(cx - profile(t) * half, top + t * height),
                  (cx + profile(t) * half, top + t * height)],
                 fill=(168, 148, 116), alpha=al, width=max(1, int(1.2 * s)))
    # inscription band near the lip
    for k in range(26):
        x = cx - half * 0.78 + k * half * 0.06
        art.line([(x, lip_y - height * 0.115), (x, lip_y - height * 0.105)],
                 fill=(168, 148, 116), alpha=34, width=1)

    # rim light down the left edge
    left_edge = [(cx - profile(i / 40) * half, top + (i / 40) * height) for i in range(41)]
    art.line(left_edge, fill=(182, 164, 132), alpha=38, width=max(1, int(1.6 * s)))

    # lip band follows the curve of the mouth
    upper = [(cx + profile(0.94) * half, lip_y - height * 0.055),
             (cx + half * 1.00, lip_y - height * 0.010),
             (cx + half * 1.01, lip_y + height * 0.012),
             (cx - half * 1.01, lip_y + height * 0.012),
             (cx - half * 1.00, lip_y - height * 0.010),
             (cx - profile(0.94) * half, lip_y - height * 0.055)]
    art.poly(upper, fill=(31, 27, 23), alpha=255)
    art.line([(cx - profile(0.94) * half, lip_y - height * 0.056),
              (cx + profile(0.94) * half, lip_y - height * 0.056)],
             fill=(172, 152, 120), alpha=42, width=max(1, int(1.4 * s)))
    # mouth
    art.ellipse(cx - half * 1.01, lip_y - height * 0.020, cx + half * 1.01, lip_y + height * 0.040,
                fill=(3, 3, 3), alpha=255)
    art.d.arc([cx - half * 1.01, lip_y - height * 0.020, cx + half * 1.01, lip_y + height * 0.040],
              0, 180, fill=(138, 120, 94, 95), width=max(1, int(1.4 * s)))

    # crown dome and loop
    art.ellipse(cx - half * 0.34, top - height * 0.052, cx + half * 0.34, top + height * 0.055,
                fill=color, alpha=255)
    art.ellipse(cx - width * 0.038, top - height * 0.095, cx + width * 0.038, top - height * 0.030,
                outline=(20, 18, 15, 255), width=max(2, int(5 * s)))
    art.line([(cx - width * 0.038, top - height * 0.060), (cx + width * 0.038, top - height * 0.060)],
             fill=(20, 18, 15), alpha=255, width=max(2, int(4 * s)))

    # clapper
    art.ellipse(cx - width * 0.045, lip_y - height * 0.075, cx + width * 0.045, lip_y + height * 0.005,
                fill=(8, 7, 6), alpha=255)
    art.ellipse(cx - width * 0.020, lip_y - height * 0.062, cx + width * 0.018, lip_y - height * 0.010,
                fill=(104, 88, 66), alpha=40)

    # crack
    crack = [(cx + width * 0.13, lip_y - height * 0.02),
             (cx + width * 0.17, lip_y - height * 0.14),
             (cx + width * 0.13, lip_y - height * 0.22),
             (cx + width * 0.18, lip_y - height * 0.33),
             (cx + width * 0.15, lip_y - height * 0.40)]
    art.line(crack, fill=(2, 2, 2), alpha=255, width=max(2, int(2.2 * s)))
    art.line([(x + 1.5 * s, y) for x, y in crack], fill=(156, 136, 104), alpha=32,
             width=max(1, int(1.0 * s)))

    # patina
    rng = np.random.default_rng(9)
    for _ in range(60):
        t = rng.uniform(0.08, 0.96)
        r = profile(t)
        x = cx + rng.uniform(-r, r) * half
        y = top + t * height
        sz = rng.uniform(1.4, 4.6) * s
        art.ellipse(x, y, x + sz, y + sz * 0.55, fill=(52, 66, 55),
                    alpha=int(rng.integers(10, 30)))


def render(scale=2, out="cover_bell.png"):
    art = Art(W, H, scale=scale, seed=51)
    arr = np.zeros((art.h, art.w, 3), np.float32)
    yy = np.linspace(0, 1, art.h, dtype=np.float32)[:, None, None]
    top = np.array([0.045, 0.045, 0.042], np.float32)
    mid = np.array([0.095, 0.088, 0.078], np.float32)
    bot = np.array([0.050, 0.048, 0.044], np.float32)
    t1 = smoothstep(0, 0.7, yy)
    t2 = smoothstep(0.7, 1, yy)
    low = top * (1 - t1) + mid * t1
    high = mid * (1 - t2) + bot * t2
    arr = np.where(yy < 0.7, low, high)
    arr = np.repeat(arr, art.w, axis=1)
    n = fbm(art.w, art.h, base=5, octaves=5, seed=3)
    arr *= (0.9 + 0.2 * n[..., None])
    art.set_arr(arr)

    cx = 0.500 * art.w
    belfry(art, cx, 0.345 * art.h, 0.300 * art.w, 0.812 * art.h, 0.110 * art.h)

    # nine rings
    for i in range(1, 10):
        r = (0.10 + 0.038 * i) * art.w
        art.d.arc([cx - r, 0.560 * art.h - r, cx + r, 0.560 * art.h + r],
                  200, 340, fill=(220, 208, 184, max(8, 32 - i * 3)),
                  width=max(1, int(1.1 * art.s)))

    # beam
    beam_y = 0.085 * art.h
    art.rect(cx - 0.340 * art.w, beam_y, cx + 0.340 * art.w, beam_y + 0.028 * art.h,
             fill=(19, 17, 13), alpha=255)
    art.line([(cx - 0.340 * art.w, beam_y + 0.003 * art.h),
              (cx + 0.340 * art.w, beam_y + 0.003 * art.h)],
             fill=(118, 100, 74), alpha=35, width=max(1, int(1.2 * art.s)))
    for i in range(9):
        x = cx - 0.30 * art.w + i * 0.075 * art.w
        art.line([(x, beam_y), (x + 3 * art.s, beam_y + 0.028 * art.h)],
                 fill=(6, 6, 5), alpha=70, width=1)
    for side in (-1, 1):
        art.line([(cx + side * 0.16 * art.w, beam_y + 0.028 * art.h),
                  (cx + side * 0.085 * art.w, 0.188 * art.h)],
                 fill=(92, 78, 58), alpha=235, width=max(2, int(3.0 * art.s)))

    draw_bell(art, cx, 0.225 * art.h, 0.540 * art.w, 0.365 * art.h)

    # fog below the bell, and a far-off window
    art.fog(0.78, 0.93, color=(72, 66, 56), strength=0.26, seed=7, streak=0.6)
    art.figure(0.500 * art.w, 0.798 * art.h, 0.050 * art.h, color=(7, 7, 6),
               alpha=255, pack=True, lean=0.0)

    # typography
    gold = (209, 191, 160)
    art.text((0.5 * art.w, 0.830 * art.h), "A GHOST STORY", font("pala.ttf", 0.0078 * art.h),
             fill=gold, tracking=0.0055 * art.h, alpha=215)
    art.line([(0.395 * art.w, 0.840 * art.h), (0.605 * art.w, 0.840 * art.h)],
             fill=gold, alpha=80, width=max(1, int(0.9 * art.s)))
    art.text((0.5 * art.w, 0.884 * art.h), "THE NINTH BELL", font("palab.ttf", 0.055 * art.h),
             fill=(233, 223, 203), tracking=0.0072 * art.h, alpha=255)
    art.line([(0.365 * art.w, 0.922 * art.h), (0.635 * art.w, 0.922 * art.h)],
             fill=(139, 58, 40), alpha=170, width=max(1, int(1.1 * art.s)))
    art.text((0.5 * art.w, 0.938 * art.h), "A STORY FROM SIMSARA", font("pala.ttf", 0.0110 * art.h),
             fill=gold, tracking=0.0068 * art.h, alpha=225)
    art.text((0.5 * art.w, 0.972 * art.h), "WRITTEN AND ILLUSTRATED FOR THIS EDITION",
             font("pala.ttf", 0.0068 * art.h), fill=(150, 140, 123), tracking=0.0034 * art.h, alpha=140)

    art.vignette(amount=0.50, power=1.7)
    art.finish(grain=0.014, contrast=1.04)
    return resize_save(art.img, out, W, H)


if __name__ == "__main__":
    scale = float(sys.argv[1]) if len(sys.argv) > 1 else 2
    out = sys.argv[2] if len(sys.argv) > 2 else "cover_bell.png"
    render(scale=scale, out=out)
    print("wrote", out)
