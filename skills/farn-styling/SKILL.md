---
name: farn-styling
description: Apply the Farn design system's colors and typography to any visual output. Use when explicitly requested — do not auto-trigger.
allowed-tools: Read Write Edit AskUserQuestion
---

# Farn Painter

## Overview

Apply the Farn design system's color palette and typefaces to any HTML/CSS artifact, slide, prototype, or visual output.

## Colors

**Iron Night** — dark surfaces

| Token | Hex | Role |
|---|---|---|
| `--in0-void` | `#0D1117` | Primary background (dark), primary text (light) |
| `--in1-iron` | `#374151` | Elevated surfaces, borders |
| `--in2-slate` | `#4B5563` | Active lines, selections |
| `--in3-ash` | `#6B7280` | Secondary text, placeholders, guides |

**Birch Mist** — light surfaces

| Token | Hex | Role |
|---|---|---|
| `--bm0-sand` | `#D5D2C7` | Elevated UI, subtle backgrounds |
| `--bm1-mist` | `#E9E6DC` | Hover states, active lines |
| `--bm2-birch` | `#F7F6F3` | Primary background (light), primary text (dark) |

**Forest** — accents

| Token | Hex | Role |
|---|---|---|
| `--fo0-glade` | `#94C5AF` | **Dark-mode primary accent** — buttons, links, indicators |
| `--fo1-fern` | `#327A59` | **Light-mode primary accent** — buttons, links, CTAs |
| `--fo2-forest` | `#2D5E4A` | Secondary accent |
| `--fo3-deepwater` | `#254D5A` | Tertiary accent, code block backgrounds (light mode) |

**Bloom** — semantic

| Token | Hex | Role |
|---|---|---|
| `--bl0-ember` | `#C5414C` | Error |
| `--bl1-ochre` | `#AB5A2B` | Annotation |
| `--bl2-grain` | `#8D6B20` | Warning |
| `--bl3-moss` | `#567A37` | Success |
| `--bl4-heather` | `#885DB4` | Uncommon / highlight |

**Accent usage:**
- Light mode interactive elements (buttons, links, CTAs) → `--fo1-fern`
- Dark mode interactive elements → `--fo0-glade` (lighter hex for contrast on dark surfaces)
- Structural / UI chrome (borders, elevated surfaces) → `--in1-iron`
- Semantic states (error, warning, success) → Bloom palette
- In application CSS, prefer semantic tokens (`--color-accent`, `--color-bg`) over raw palette tokens — palette tokens are reference-level

## Typography

| Role | Typeface | Weight | Size | opsz | Notes |
|---|---|---|---|---|---|
| Display | Fraunces | 800 | clamp(3rem, 7vw, 4.5rem) | 72 | letter-spacing -0.02em |
| H1 | Fraunces | 800 | clamp(2.5rem, 5vw, 4rem) | 72 | letter-spacing -0.02em |
| H2 | Fraunces | 700 | clamp(1.5rem, 3vw, 2rem) | 24 | letter-spacing -0.02em |
| H3 | Fraunces | 600 | clamp(1.1rem, 2vw, 1.35rem) | 20 | letter-spacing -0.01em |
| H4 | Instrument Sans | 600 | 16px | — | |
| H5 | Instrument Sans | 600 | 14px | — | letter-spacing 0.04em |
| Body | Instrument Sans | 400 | 16px / lh 1.7 | — | |
| Code | JetBrains Mono | 400–500 | 12–13px / lh 1.6 | — | |

**Hard constraints:**
- Fraunces requires `font-variation-settings: 'opsz' [size]` — omitting it is wrong
- Fraunces minimum size: 16px — never smaller
- Never use Instrument Sans weight 700+
- Max 3 type sizes per layout
- Body column max 68 characters per line

## Web implementation

```css
@import url('https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,300..900;1,9..144,300..900&family=Instrument+Sans:wght@400;500;600&family=JetBrains+Mono:wght@400;500&display=swap');

:root {
  /* Iron Night */
  --in0-void:      #0D1117;
  --in1-iron:      #374151;
  --in2-slate:     #4B5563;
  --in3-ash:       #6B7280;

  /* Birch Mist */
  --bm0-sand:      #D5D2C7;
  --bm1-mist:      #E9E6DC;
  --bm2-birch:     #F7F6F3;

  /* Forest */
  --fo0-glade:     #94C5AF;
  --fo1-fern:      #327A59;
  --fo2-forest:    #2D5E4A;
  --fo3-deepwater: #254D5A;

  /* Bloom */
  --bl0-ember:     #C5414C;
  --bl1-ochre:     #AB5A2B;
  --bl2-grain:     #8D6B20;
  --bl3-moss:      #567A37;
  --bl4-heather:   #885DB4;

  /* Typography */
  --font-display: 'Fraunces', Georgia, serif;
  --font-body:    'Instrument Sans', system-ui, sans-serif;
  --font-mono:    'JetBrains Mono', 'Courier New', monospace;
}
```
