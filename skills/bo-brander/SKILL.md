---
name: bo-brander
description: "Apply Bo's visual brand identity. Use ONLY when explicitly referenced or requested — do not auto-trigger. Covers HTML/CSS artifacts, slides, prototypes, diagrams, and any visual output. Do NOT apply automatically based on context inference."
allowed-tools: Read Write Edit AskUserQuestion
---

# Bo Brand

## Overview

Apply Bo's brand identity to any personal visual output. This covers color palette, typefaces, iconography, and layout constraints.

## Colors

> Full token spec and WCAG contrast data: `design-system/keld-theme/design-tokens.md`

**Iron Night** — dark surfaces

| Token | Hex | Role |
|---|---|---|
| `--kn0-void` | `#0D1117` | Primary background (dark), primary text (light) |
| `--kn1-iron` | `#374151` | Elevated surfaces, borders, secondary accent |
| `--kn2-slate` | `#4B5563` | Active lines, selections, highlights |
| `--kn3-ash` | `#6B7280` | Secondary text, placeholders, guides |

**Birch Storm** — light surfaces

| Token | Hex | Role |
|---|---|---|
| `--bs0-sand` | `#E4E2DA` | Elevated UI, subtle backgrounds |
| `--bs1-linen` | `#EEEDE9` | Hover states, active lines |
| `--bs2-parchment` | `#F5F4F0` | Primary background (light) |

**Forest** — accents

| Token | Hex | Role |
|---|---|---|
| `--fr0-sage` | `#5C9E86` | Supporting accent, classes, types |
| `--fr1-fern` | `#3E7A62` | **Primary accent** — buttons, links, CTAs |
| `--fr2-forest` | `#2D5E4A` | Secondary accent, keywords |
| `--fr3-deepwater` | `#254D5A` | Tertiary accent, pre-processor |

**Bloom** — semantic

| Token | Hex | Role |
|---|---|---|
| `--bl0-ember` | `#C5414C` | Error |
| `--bl1-ochre` | `#AB5A2B` | Annotation |
| `--bl2-grain` | `#8D6B20` | Warning |
| `--bl3-moss` | `#567A37` | Success |
| `--bl4-heather` | `#885DB4` | Uncommon / highlight |

**Accent usage**: Use `--fr1-fern` for key interactive elements — sparingly, 1–2 per layout. Use `--kn1-iron` for structural/UI elements.

## Typography

| Role | Typeface | Fallback | Weight | Notes |
|---|---|---|---|---|
| Display / H1 | Fraunces | Georgia | 800 | `opsz` 72 or 36, letter-spacing -0.02em |
| H2 | Fraunces | Georgia | 700 | `opsz` 24 |
| H3 | Fraunces | Georgia | 600 | `opsz` 20 |
| Body | Instrument Sans | system-ui, sans-serif | 400 | 16px / 11pt, line-height 1.7 |
| UI labels / metadata | Instrument Sans | system-ui, sans-serif | 500–600 | |

Minimum Fraunces size: 16px / 12pt. Never use Instrument Sans weight 700+.

## Icons

Phosphor Icons, Regular weight only. No mixing weights or libraries.

## Hard constraints

- Fraunces requires `font-variation-settings: 'opsz' [size]` — omitting it is wrong
- Max 3 type sizes per layout
- Body column max 68 characters per line

## Web implementation

```css
/* Google Fonts */
@import url('https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,300;0,9..144,600;0,9..144,700;0,9..144,800;1,9..144,400&family=Instrument+Sans:wght@300;400;500;600&display=swap');

/* Phosphor Icons */
/* <script src="https://unpkg.com/@phosphor-icons/web"></script> */

:root {
  /* Iron Night */
  --kn0-void:      #0D1117;
  --kn1-iron:      #374151;
  --kn2-slate:     #4B5563;
  --kn3-ash:       #6B7280;

  /* Birch Storm */
  --bs0-sand:      #E4E2DA;
  --bs1-linen:     #EEEDE9;
  --bs2-parchment: #F5F4F0;

  /* Forest */
  --fr0-sage:      #5C9E86;
  --fr1-fern:      #3E7A62;
  --fr2-forest:    #2D5E4A;
  --fr3-deepwater: #254D5A;

  /* Bloom */
  --bl0-ember:     #C5414C;
  --bl1-ochre:     #AB5A2B;
  --bl2-grain:     #8D6B20;
  --bl3-moss:      #567A37;
  --bl4-heather:   #885DB4;
}
```
