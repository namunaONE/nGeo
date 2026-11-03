# -*- coding: utf-8 -*-
"""Build the illustrated DOCX for 'The Ninth Bell'."""
from __future__ import annotations

import os
import sys

from docx import Document
from docx.shared import Cm, Pt, RGBColor, Mm
from docx.enum.text import WD_ALIGN_PARAGRAPH, WD_LINE_SPACING, WD_TAB_ALIGNMENT
from docx.enum.section import WD_SECTION
from docx.oxml.ns import qn
from docx.oxml import OxmlElement

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import story_content as S

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
IMG = os.path.join(ROOT, "images")

INK = RGBColor(0x1D, 0x1A, 0x16)
SOFT = RGBColor(0x4A, 0x40, 0x35)
MUTED = RGBColor(0x7A, 0x6C, 0x59)
RUST = RGBColor(0x8B, 0x3A, 0x28)
PAPER = RGBColor(0xF6, 0xF1, 0xE6)

TITLE_FONT = "Palatino Linotype"
BODY_FONT = "Georgia"


def set_run(run, font=BODY_FONT, size=11.3, color=INK, bold=False, italic=False,
            small_caps=False, spacing_pt=0.0):
    run.font.name = font
    run.font.size = Pt(size)
    run.font.color.rgb = color
    run.font.bold = bold
    run.font.italic = italic
    run.font.small_caps = small_caps
    rPr = run._element.get_or_add_rPr()
    rFonts = rPr.find(qn("w:rFonts"))
    if rFonts is None:
        rFonts = OxmlElement("w:rFonts")
        rPr.append(rFonts)
    rFonts.set(qn("w:ascii"), font)
    rFonts.set(qn("w:hAnsi"), font)
    rFonts.set(qn("w:eastAsia"), font)
    if spacing_pt:
        sp = OxmlElement("w:spacing")
        sp.set(qn("w:val"), str(int(spacing_pt * 20)))
        rPr.append(sp)


def add_run(p, text, **kw):
    r = p.add_run(text)
    set_run(r, **kw)
    return r


def rule(doc, width_cm=3.2, color="8B3A28", before=4, after=8):
    p = doc.add_paragraph()
    p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    pf = p.paragraph_format
    side = max(0.0, (16.6 - width_cm) / 2)
    pf.left_indent = Cm(side)
    pf.right_indent = Cm(side)
    pf.space_before = Pt(before)
    pf.space_after = Pt(after)
    pf.line_spacing = Pt(1)
    r = p.add_run("")
    r.font.size = Pt(1)
    pPr = p._p.get_or_add_pPr()
    pBdr = OxmlElement("w:pBdr")
    bottom = OxmlElement("w:bottom")
    bottom.set(qn("w:val"), "single")
    bottom.set(qn("w:sz"), "8")
    bottom.set(qn("w:space"), "1")
    bottom.set(qn("w:color"), color)
    pBdr.append(bottom)
    pPr.append(pBdr)


def body_para(doc, text, first=False):
    p = doc.add_paragraph()
    p.alignment = WD_ALIGN_PARAGRAPH.JUSTIFY
    pf = p.paragraph_format
    pf.line_spacing = 1.42
    pf.space_before = Pt(0)
    pf.space_after = Pt(5)
    if not first:
        pf.first_line_indent = Cm(0.55)
    add_run(p, text, size=11.3, color=INK)
    return p


def section_heading(doc, numeral, title):
    p = doc.add_paragraph()
    p.paragraph_format.page_break_before = True
    p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p.paragraph_format.space_before = Pt(10)
    p.paragraph_format.space_after = Pt(0)
    add_run(p, numeral, font=TITLE_FONT, size=30, color=SOFT, spacing_pt=2)
    rule(doc, width_cm=1.8, color="8B3A28", before=2, after=4)
    p2 = doc.add_paragraph()
    p2.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p2.paragraph_format.space_before = Pt(0)
    p2.paragraph_format.space_after = Pt(17)
    add_run(p2, title.upper(), font=TITLE_FONT, size=10.5, color=MUTED,
            small_caps=True, spacing_pt=2.6)


def page_break(doc):
    p = doc.add_paragraph()
    p.paragraph_format.space_before = Pt(0)
    p.paragraph_format.space_after = Pt(0)
    r = p.add_run()
    r.add_break(6)  # WD_BREAK.PAGE == 6


def add_page_field(p):
    fld = OxmlElement("w:fldSimple")
    fld.set(qn("w:instr"), " PAGE ")
    r = OxmlElement("w:r")
    t = OxmlElement("w:t")
    t.text = "1"
    r.append(t)
    fld.append(r)
    p._p.append(fld)


def footer(section):
    section.footer.is_linked_to_previous = False
    p = section.footer.paragraphs[0]
    p.text = ""
    p.paragraph_format.space_before = Pt(3)
    p.paragraph_format.tab_stops.add_tab_stop(Cm(16.55), WD_TAB_ALIGNMENT.RIGHT)
    add_run(p, "THE NINTH BELL", font=TITLE_FONT, size=7.5, color=MUTED, spacing_pt=1.6)
    add_run(p, "\t", size=8)
    r = p.add_run()
    set_run(r, font=TITLE_FONT, size=8, color=MUTED)
    add_page_field(p)
    pPr = p._p.get_or_add_pPr()
    pBdr = OxmlElement("w:pBdr")
    top = OxmlElement("w:top")
    top.set(qn("w:val"), "single")
    top.set(qn("w:sz"), "4")
    top.set(qn("w:space"), "4")
    top.set(qn("w:color"), "C9BFA9")
    pBdr.append(top)
    pPr.append(pBdr)


def plate_page(doc, image, number, caption):
    spacer = doc.add_paragraph()
    spacer.paragraph_format.page_break_before = True
    spacer.paragraph_format.space_before = Pt(0)
    spacer.paragraph_format.space_after = Pt(10)
    p = doc.add_paragraph()
    p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p.paragraph_format.space_before = Pt(0)
    p.paragraph_format.space_after = Pt(12)
    path = os.path.join(IMG, image)
    from PIL import Image
    with Image.open(path) as im:
        iw, ih = im.size
    portrait = ih > iw
    if portrait:
        width = Cm(11.6)
    else:
        width = Cm(15.8)
    run = p.add_run()
    run.add_picture(path, width=width)
    rule(doc, width_cm=1.6, color="8B3A28", before=0, after=5)
    p2 = doc.add_paragraph()
    p2.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p2.paragraph_format.space_after = Pt(2)
    add_run(p2, f"PLATE {number}", font=TITLE_FONT, size=7.5, color=RUST,
            small_caps=True, spacing_pt=2.2)
    p3 = doc.add_paragraph()
    p3.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p3.paragraph_format.space_after = Pt(0)
    add_run(p3, caption, font=TITLE_FONT, size=10, color=SOFT, italic=True, spacing_pt=0.4)


def build():
    doc = Document()
    # core properties
    doc.core_properties.title = S.TITLE
    doc.core_properties.subject = S.SUBTITLE
    doc.core_properties.comments = "An illustrated ghost story."

    # ---- cover section (full bleed) ----
    cover = doc.sections[0]
    cover.page_width = Cm(21.0)
    cover.page_height = Cm(29.7)
    cover.top_margin = Cm(0)
    cover.bottom_margin = Cm(0)
    cover.left_margin = Cm(0)
    cover.right_margin = Cm(0)
    cover.header_distance = Cm(0)
    cover.footer_distance = Cm(0)

    p = doc.add_paragraph()
    p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p.paragraph_format.space_before = Pt(0)
    p.paragraph_format.space_after = Pt(0)
    p.paragraph_format.line_spacing = Pt(1)
    run = p.add_run()
    run.add_picture(os.path.join(IMG, "cover_bell.png"), width=Cm(21.0), height=Cm(29.6))

    # ---- main section ----
    main = doc.add_section(WD_SECTION.NEW_PAGE)
    main.page_width = Cm(21.0)
    main.page_height = Cm(29.7)
    main.top_margin = Cm(2.1)
    main.bottom_margin = Cm(1.95)
    main.left_margin = Cm(2.2)
    main.right_margin = Cm(2.2)
    main.header_distance = Cm(1.0)
    main.footer_distance = Cm(1.0)
    # page numbering starts at 1
    sectPr = main._sectPr
    pgNum = OxmlElement("w:pgNumType")
    pgNum.set(qn("w:start"), "1")
    sectPr.append(pgNum)
    footer(main)

    # ---- title page ----
    for _ in range(3):
        sp = doc.add_paragraph()
        sp.paragraph_format.space_after = Pt(0)
        sp.paragraph_format.line_spacing = Pt(18)
    p = doc.add_paragraph()
    p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p.paragraph_format.space_after = Pt(6)
    add_run(p, "AN ILLUSTRATED GHOST STORY", font=TITLE_FONT, size=9, color=MUTED,
            small_caps=True, spacing_pt=3.0)
    rule(doc, width_cm=4.2, color="8B3A28", before=2, after=14)
    p = doc.add_paragraph()
    p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p.paragraph_format.space_after = Pt(6)
    add_run(p, S.TITLE.upper(), font=TITLE_FONT, size=33, color=INK, bold=True, spacing_pt=4.0)
    rule(doc, width_cm=5.2, color="8B3A28", before=2, after=12)
    p = doc.add_paragraph()
    p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p.paragraph_format.space_after = Pt(38)
    add_run(p, S.SUBTITLE, font=TITLE_FONT, size=13.5, color=SOFT, italic=True, spacing_pt=0.6)
    p = doc.add_paragraph()
    p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p.paragraph_format.space_after = Pt(30)
    add_run(p, "Written and illustrated in ink", font=TITLE_FONT, size=9.5, color=MUTED,
            italic=True)

    p = doc.add_paragraph()
    p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p.paragraph_format.space_before = Pt(70)
    p.paragraph_format.space_after = Pt(4)
    add_run(p, S.EPIGRAPH, font=TITLE_FONT, size=11.5, color=SOFT, italic=True)
    p = doc.add_paragraph()
    p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    add_run(p, S.EPIGRAPH_SOURCE, font=TITLE_FONT, size=8.5, color=MUTED,
            small_caps=True, spacing_pt=1.4)

    # ---- story ----
    for idx, sec in enumerate(S.SECTIONS):
        section_heading(doc, sec["numeral"], sec["title"])
        for j, para in enumerate(sec["paras"]):
            body_para(doc, para, first=(j == 0))
        if sec.get("plate"):
            pl = sec["plate"]
            plate_page(doc, pl["image"], pl["number"], pl["caption"])

    # ---- colophon ----
    for k in range(7):
        sp = doc.add_paragraph()
        sp.paragraph_format.space_after = Pt(0)
        sp.paragraph_format.line_spacing = Pt(16)
        if k == 0:
            sp.paragraph_format.page_break_before = True
    p = doc.add_paragraph()
    p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p.paragraph_format.space_after = Pt(18)
    add_run(p, "CODA", font=TITLE_FONT, size=9, color=RUST, small_caps=True, spacing_pt=3)
    p = doc.add_paragraph()
    p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p.paragraph_format.space_after = Pt(14)
    add_run(p, S.COLOPHON, font=TITLE_FONT, size=10.5, color=SOFT, italic=True)
    rule(doc, width_cm=3.0, color="8B3A28", before=6, after=16)
    p = doc.add_paragraph()
    p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    add_run(p, "SIMSARA  \u00b7  41", font=TITLE_FONT, size=8, color=MUTED,
            small_caps=True, spacing_pt=2.4)

    out = os.path.join(ROOT, "The_Ninth_Bell_Illustrated.docx")
    doc.save(out)
    print("saved", out)
    return out


if __name__ == "__main__":
    build()
