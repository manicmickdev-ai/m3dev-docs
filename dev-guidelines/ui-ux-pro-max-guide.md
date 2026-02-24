# UI/UX Pro Max Plugin Guide

> **Plugin:** `ui-ux-pro-max@ui-ux-pro-max-skill`
> **Version:** v2.0.x
> **Scope:** User (global)
> **Category:** Design Intelligence & UI Generation

---

## Overview

UI/UX Pro Max is an AI design intelligence skill that automatically generates complete, production-grade design systems before writing any UI code. It combines a BM25 search engine over curated design databases with 100 industry-specific reasoning rules to produce consistent, professional interfaces.

**Key capability:** When you ask Claude to build any UI, this skill intercepts the request, generates a complete design system (colors, typography, layout patterns, component style), then implements the UI against that system — ensuring visual consistency across the entire project.

---

## Design Assets Library

| Asset Type | Count | Description |
|-----------|-------|-------------|
| UI Styles | **67** | Named visual paradigms (glassmorphism, brutalism, etc.) |
| Color Palettes | **96** | Industry-specific curated color sets |
| Font Pairings | **57** | Curated typography combos with Google Fonts imports |
| Chart Types | **25** | Recommendations for dashboards and analytics |
| Tech Stacks | **13** | Framework-specific implementation guidelines |
| UX Guidelines | **99** | Best practices and anti-pattern rules |
| Reasoning Rules | **100** | Industry-specific design system generation |

---

## Supported UI Styles (67 Total)

### General Styles (49)
| Style | Best For |
|-------|----------|
| Minimalism & Swiss Style | Enterprise apps, dashboards, documentation |
| Glassmorphism | Modern SaaS, financial dashboards |
| Claymorphism | Educational apps, children's apps, SaaS |
| Brutalism | Design portfolios, artistic projects |
| Neumorphism | Health/wellness apps, meditation platforms |
| Dark Mode (OLED) | Night-mode apps, coding platforms |
| Bento Box Grid | Dashboards, product pages, portfolios |
| AI-Native UI | AI products, chatbots, copilots |
| Neubrutalism | Gen Z brands, startups, Figma-style |
| Soft UI Evolution | Modern enterprise apps, SaaS |
| Aurora UI | Modern SaaS, creative agencies |
| Liquid Glass | Premium SaaS, high-end e-commerce |
| Cyberpunk UI | Gaming, tech products, crypto apps |
| HUD / Sci-Fi FUI | Sci-fi games, space tech, cybersecurity |
| Spatial UI (VisionOS) | Spatial computing, VR/AR |
| Flat Design | Web apps, mobile apps, startup MVPs |
| Motion-Driven | Portfolio sites, storytelling platforms |
| Retro-Futurism | Gaming, entertainment, music platforms |
| 3D & Hyperrealism | Gaming, product showcase, immersive |
| Accessible & Ethical | Government, healthcare, education |
| Pixel Art | Indie games, retro tools, creative |
| Parallax Storytelling | Brand storytelling, product launches |
| Kinetic Typography | Hero sections, marketing sites |
| Y2K Aesthetic | Fashion brands, music, Gen Z |
| Vaporwave | Music platforms, gaming, portfolios |
| Memphis Design | Creative agencies, music, youth brands |
| Organic Biophilic | Wellness apps, sustainability brands |
| Voice-First Multimodal | Voice assistants, accessibility apps |
| 3D Product Preview | E-commerce, furniture, fashion |
| Editorial Grid / Magazine | News sites, blogs, magazines |
| Vintage Analog / Retro Film | Photography, music/vinyl brands |
| *(18 more...)* | Various specialized use cases |

### Landing Page Styles (8)
| Style | Best For |
|-------|----------|
| Hero-Centric Design | Strong visual identity products |
| Conversion-Optimized | Lead generation, sales pages |
| Feature-Rich Showcase | SaaS, complex products |
| Minimal & Direct | Simple products, apps |
| Social Proof-Focused | Services, B2C products |
| Interactive Product Demo | Software, tools |
| Trust & Authority | B2B, enterprise, consulting |
| Storytelling-Driven | Brands, agencies, nonprofits |

### BI/Analytics Dashboard Styles (10)
| Style | Best For |
|-------|----------|
| Data-Dense Dashboard | Complex data analysis |
| Executive Dashboard | C-suite summaries |
| Real-Time Monitoring | Operations, DevOps |
| Predictive Analytics | Forecasting, ML insights |
| Financial Dashboard | Finance, accounting |
| *(5 more...)* | Specialized dashboard types |

---

## Supported Tech Stacks (13)

| Category | Stacks |
|----------|--------|
| **Web HTML** | HTML + Tailwind (default) |
| **React** | React, Next.js, shadcn/ui |
| **Vue** | Vue, Nuxt.js, Nuxt UI |
| **Other Web** | Svelte, Astro |
| **iOS** | SwiftUI |
| **Android** | Jetpack Compose |
| **Cross-Platform** | React Native, Flutter |

---

## How Design System Generation Works

When you make a UI request, the skill runs **5 parallel searches**:

```
1. Product type matching  → 100 industry categories
2. Style recommendations  → 67 available styles
3. Color palette selection → 96 palettes
4. Landing page patterns  → 24 pattern types
5. Typography pairing     → 57 font combinations
```

The BM25 reasoning engine then:
- Matches your product type to industry rules
- Applies style priorities
- Filters anti-patterns for your industry
- Generates a complete design system spec

**Example output for a wellness spa:**
```
STYLE:     Soft UI Evolution
COLORS:    #E8B4B8 (Soft Pink), #A8D5BA (Sage Green), #D4AF37 (Gold)
FONTS:     Cormorant Garamond / Montserrat
EFFECTS:   Soft shadows + Smooth transitions (200-300ms)
AVOID:     Bright neon, harsh animations, dark mode, AI purple/pink gradients
```

---

## Industry-Specific Reasoning Rules (100 Rules)

| Category | Examples |
|----------|----------|
| **Tech & SaaS** | SaaS, Micro SaaS, B2B Enterprise, Developer Tools, AI/Chatbot |
| **Finance** | Fintech, Banking, Crypto, Insurance, Trading Dashboard |
| **Healthcare** | Medical Clinic, Pharmacy, Dental, Mental Health |
| **E-commerce** | General, Luxury, Marketplace, Subscription Box |
| **Services** | Beauty/Spa, Restaurant, Hotel, Legal, Consulting |
| **Creative** | Portfolio, Agency, Photography, Gaming, Music |
| **Emerging Tech** | Web3/NFT, Spatial Computing, Quantum, Autonomous Systems |

---

## Usage

### Auto-Activation (Claude Code)
The skill activates automatically for any UI/UX request:

```
Build a landing page for my SaaS product
Create a dashboard for ML experiment tracking
Design a portfolio website with dark mode
Make a mobile app UI for e-commerce
Build a fintech banking app with dark theme
```

### Explicit Invocation
```
/ui-ux-pro-max Build a landing page for my SaaS product
```

### Design System CLI (Advanced)
```bash
# Generate design system with ASCII output
python3 .claude/skills/ui-ux-pro-max/scripts/search.py "beauty spa wellness" \
  --design-system -p "Serenity Spa"

# Domain-specific search
python3 .claude/skills/ui-ux-pro-max/scripts/search.py "glassmorphism" --domain style
python3 .claude/skills/ui-ux-pro-max/scripts/search.py "elegant serif" --domain typography
python3 .claude/skills/ui-ux-pro-max/scripts/search.py "dashboard" --domain chart

# Stack-specific guidelines
python3 .claude/skills/ui-ux-pro-max/scripts/search.py "form validation" --stack react
python3 .claude/skills/ui-ux-pro-max/scripts/search.py "responsive layout" --stack shadcn
```

---

## Persistent Design System (Cross-Session)

For multi-session projects, save your design system to files:

```bash
# Generate and persist to design-system/MASTER.md
python3 .claude/skills/ui-ux-pro-max/scripts/search.py "SaaS dashboard" \
  --design-system --persist -p "MyApp"

# Create page-specific overrides
python3 .claude/skills/ui-ux-pro-max/scripts/search.py "SaaS dashboard" \
  --design-system --persist -p "MyApp" --page "dashboard"
```

**File structure:**
```
design-system/
├── MASTER.md           ← Global: colors, typography, spacing, components
└── pages/
    ├── dashboard.md    ← Dashboard-specific overrides
    └── checkout.md     ← Checkout-specific overrides
```

**Retrieval pattern:** Page-specific files override Master when present.

---

## Pre-Delivery Checklist (Auto-Applied)

The skill validates every UI output against these rules:
- [ ] No emojis as icons (use SVG: Heroicons/Lucide)
- [ ] `cursor-pointer` on all clickable elements
- [ ] Hover states with smooth transitions (150-300ms)
- [ ] Light mode: text contrast 4.5:1 minimum (WCAG AA)
- [ ] Focus states visible for keyboard navigation
- [ ] `prefers-reduced-motion` respected
- [ ] Responsive breakpoints: 375px, 768px, 1024px, 1440px

---

## M3Dev Use Cases

| Project Type | Recommended Style | Stack |
|-------------|------------------|-------|
| ML Dashboard | Data-Dense / Executive Dashboard | Next.js + shadcn/ui |
| API Console | Minimalism / Dark Mode | React |
| Inference Monitor | Real-Time Monitoring Dashboard | React + Recharts |
| Model Registry UI | Bento Box Grid / AI-Native UI | Next.js |
| Developer Portal | Trust & Authority / Feature-Rich | Astro or Next.js |
| Internal Admin | Flat Design / Accessible | Next.js + shadcn/ui |

---

## Requirements

- Python 3.x (required for CLI search commands)
- No external Python packages needed (built-in stdlib only)

---

## Installation Verification

The skill is installed globally. To verify it's active:
```
/ui-ux-pro-max test
```
If it responds with a design system analysis, it's working.
