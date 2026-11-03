"""Plate II - the keeper's ledger (close-up)."""
from __future__ import annotations

import math
import sys
import numpy as np
from PIL import Image, ImageDraw, ImageFilter

from artlib import (Art, INK, BONE, RUST, paper_base, font, fbm, noise_streaks,
                    resize_save, dark_base)
from night_common import night

W, H = 1600, 2000


def make_page(pw=1480, ph=1660, seed=31):
    arr = paper_base(pw, ph, seed=seed, top=(224, 214, 193), bottom=(232, 223, 204))
    # foxing and stains
    rng = np.random.default_rng(seed + 2)
    for _ in range(260):
        x = rng.uniform(0, pw)
        y = rng.uniform(0, ph)
        r = rng.uniform(1, 14)
        c = rng.choice([(160, 120, 80), (150, 110, 70), (120, 95, 70)])
        a = rng.uniform(4, 22)
        im = Image.fromarray(arr.astype(np.uint8), "RGB")
        d = ImageDraw.Draw(im, "RGBA")
        d.ellipse([x - r, y - r * 0.7, x + r, y + r * 0.7], fill=tuple(c) + (int(a),))
        arr = np.asarray(im, np.float32)
    # edge darkening
    yy = np.linspace(0, 1, ph, dtype=np.float32)[:, None]
    xx = np.linspace(0, 1, pw, dtype=np.float32)[None, :]
    edge = (np.clip((xx - 0.92) / 0.08, 0, 1) ** 2 + np.clip((0.08 - xx) / 0.08, 0, 1) ** 2 +
            np.clip((yy - 0.94) / 0.06, 0, 1) ** 2)
    arr *= (1 - 0.18 * np.clip(edge, 0, 1))[..., None]
    return Image.fromarray(np.clip(arr, 0, 255).astype(np.uint8), "RGB").convert("RGBA")


def render(scale=2, out="plate_02_ledger.png"):
    art = Art(W, H, scale=scale, seed=81)
    arr = np.zeros((art.h, art.w, 3), np.float32)
    yy = np.linspace(0, 1, art.h, dtype=np.float32)[:, None, None]
    arr = np.array([0.035, 0.030, 0.025], np.float32) * (0.8 + 0.4 * (1 - yy))
    arr = np.repeat(arr, art.w, axis=1)
    art.set_arr(arr)

    # table grain
    grain = noise_streaks(art.w, art.h, 5, 30, 4)
    art.set_arr(art.arr() * (0.85 + 0.30 * grain[..., None]))

    # page
    page = make_page()
    pw, ph = page.size
    page = page.rotate(-1.7, resample=Image.BICUBIC, expand=True)
    px = int(0.50 * art.w - page.width / 2)
    py = int(0.47 * art.h - page.height / 2)

    # shadow under the page
    sh = Image.new("RGBA", page.size, (0, 0, 0, 0))
    d = ImageDraw.Draw(sh)
    d.rectangle([20, 24, page.width - 10, page.height], fill=(0, 0, 0, 170))
    sh = sh.filter(ImageFilter.GaussianBlur(18 * art.s))
    art.img.alpha_composite(sh, (int(px + 12 * art.s), int(py + 16 * art.s)))

    art.img.alpha_composite(page, (px, py))
    art.d = ImageDraw.Draw(art.img, "RGBA")

    # draw text on the page in its own coordinate space, then rotate to match
    text_layer = Image.new("RGBA", page.size, (0, 0, 0, 0))
    d = ImageDraw.Draw(text_layer)
    ink = (58, 42, 28, 235)
    red = (134, 46, 32, 235)
    pale = (96, 78, 58, 190)

    m = 130
    d.text((m, 120), "SIMSARA  \u00b7  THE COUNT", font=font("pala.ttf", 38), fill=(70, 54, 38, 230))
    d.line([(m, 175), (pw - m, 175)], fill=(70, 54, 38, 140), width=2)
    d.text((m, 215), "NAME", font=font("pala.ttf", 26), fill=pale)
    d.text((m + 800, 215), "YEAR", font=font("pala.ttf", 26), fill=pale)
    d.text((m + 1010, 215), "COUNT", font=font("pala.ttf", 26), fill=pale)
    d.line([(m, 255), (pw - m, 255)], fill=(90, 70, 50, 110), width=2)
    for x in (m + 790, m + 1000):
        d.line([(x, 255), (x, ph - 250)], fill=(90, 70, 50, 55), width=2)

    rows = [
        ("Asha Sen", "1994", "counted"),
        ("Bikash Thapa", "1995", "41"),
        ("Mina Gurung", "1996", "41"),
        ("Hari Bahadur", "1997", "41"),
        ("Sunita Rai", "1998", "41"),
        ("Prakash Lama", "1999", "41"),
        ("Kamala Devi", "2000", "41"),
        ("Nabin Shrestha", "2001", "41"),
        ("Sita Magar", "2002", "41"),
        ("Deepak Tamang", "2003", "41"),
        ("Anju Karki", "2004", "41"),
        ("Ram Prasad", "2005", "41"),
        ("Laxmi Bhatta", "2006", "41"),
        ("Kiran Yadav", "2007", "41"),
        ("Pema Sherpa", "2008", "41"),
        ("Gita Adhikari", "2009", "41"),
        ("Mohan Chaudhary", "2010", "41"),
        ("Sabina Thapa", "2011", "41"),
        ("Ramesh Bista", "2012", "41"),
        ("Mira Sen", "2025", "counted"),
    ]
    fh = font("segoesc.ttf", 40)
    fh2 = font("segoesc.ttf", 44)
    y = 305
    for i, (name, year, count) in enumerate(rows):
        last = (i == len(rows) - 1)
        f = fh2 if last else fh
        jitter = np.random.default_rng(i).uniform(-1.5, 1.5)
        col = red if last else ink
        d.text((m + 8, y + jitter), name, font=f, fill=col)
        d.text((m + 812, y), year, font=font("pala.ttf", 30), fill=ink)
        d.text((m + 1018, y), count, font=font("pala.ttf", 30), fill=(red if last else ink))
        if i in (0, 6, 13):
            d.line([(m + 4, y + 20), (m + 8 + d.textlength(name, font=f), y + 20)],
                   fill=(120, 80, 54, 150), width=2)
        y += 57

    # red circle around the last name
    last_w = d.textlength("Mira Sen", font=fh2)
    cy = 305 + 57 * (len(rows) - 1) + 18
    d.ellipse([m - 20, cy - 30, m + last_w + 40, cy + 32], outline=red, width=5)
    d.line([(m + last_w + 70, cy - 6), (m + last_w + 250, cy - 6)],
           fill=red, width=3)
    d.text((m + last_w + 260, cy - 22), "this one", font=font("segoesc.ttf", 34), fill=red)

    # margin note
    d.text((m + 10, ph - 175), "She will come back to be counted. She always does.",
           font=font("segoesc.ttf", 36), fill=(72, 53, 38, 220))
    d.text((m + 10, ph - 105), "41", font=font("palab.ttf", 64), fill=(72, 53, 38, 220))
    d.text((m + 110, ph - 92), "souls.  always forty-one.", font=font("pala.ttf", 28),
           fill=(92, 72, 52, 200))

    # page curvature highlight
    d.line([(pw - 80, 80), (pw - 60, ph - 80)], fill=(255, 250, 235, 60), width=12)

    text_layer = text_layer.rotate(-1.7, resample=Image.BICUBIC, expand=True)
    # align the rotated text layer with the page
    art.img.alpha_composite(text_layer, (px, py))
    art.d = ImageDraw.Draw(art.img, "RGBA")

    # pen on the page
    s = art.s
    x0, y0 = px + int(page.width * 0.60), py + int(page.height * 0.80)
    x1, y1 = px + int(page.width * 0.78), py + int(page.height * 0.93)
    art.line([(x0, y0), (x1, y1)], fill=(18, 16, 14), width=max(4, int(8 * s)))
    art.line([(x0, y0), (x1, y1)], fill=(92, 70, 44), width=max(2, int(3 * s)))
    art.line([(x0 - 4 * s, y0 - 2 * s), (x1 - 4 * s, y1 - 2 * s)], fill=(196, 162, 92), alpha=130,
             width=max(1, int(1.5 * s)))
    nib = (x1, y1)
    art.poly([(nib[0] - 5 * s, nib[1] - 5 * s), (nib[0] + 16 * s, nib[1] + 12 * s),
              (nib[0] + 2 * s, nib[1] + 26 * s)], fill=(176, 142, 82), alpha=230)

    # ink bottle at the top right
    bx, by = px + int(page.width * 0.88), py + int(page.height * 0.13)
    art.rect(bx - 22 * s, by - 18 * s, bx + 22 * s, by + 34 * s, fill=(20, 18, 16), alpha=240)
    art.rect(bx - 12 * s, by - 34 * s, bx + 12 * s, by - 16 * s, fill=(12, 11, 10), alpha=240)
    art.ellipse(bx - 10 * s, by - 6 * s, bx + 10 * s, by + 10 * s, fill=(30, 26, 22), alpha=255)

    # lamp warmth from the upper left, shadow to the right
    art.glow(0.06 * art.w, 0.04 * art.h, 0.55 * art.w, color=(255, 186, 108), strength=0.28, power=2.2)
    art.glow(0.12 * art.w, 0.10 * art.h, 0.22 * art.w, color=(255, 206, 140), strength=0.22, power=2.4)
    # cool shadow on the right
    arr = art.arr()
    xx = np.linspace(0, 1, art.w, dtype=np.float32)[None, :, None]
    arr *= (1.0 - 0.28 * np.clip((xx - 0.55) / 0.45, 0, 1))
    art.set_arr(arr)

    art.vignette(amount=0.50, power=1.7)
    art.finish(grain=0.014, contrast=1.04)
    return resize_save(art.img, out, W, H)


if __name__ == "__main__":
    scale = float(sys.argv[1]) if len(sys.argv) > 1 else 2
    out = sys.argv[2] if len(sys.argv) > 2 else "plate_02_ledger.png"
    render(scale=scale, out=out)
    print("wrote", out)
