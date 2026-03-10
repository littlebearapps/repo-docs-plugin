# Social Preview Image Specification & Creation Guide

When you share your GitHub repo link on Twitter/X, Slack, Discord, or LinkedIn, GitHub automatically displays your social preview image. This guide covers specifications, design recommendations, and tools.

---

## Technical Specifications

| Spec | Value |
|------|-------|
| **Dimensions** | 1280 × 640 pixels (2:1 aspect ratio) |
| **File format** | PNG or JPEG |
| **File size** | Under 1 MB (ideally <300 KB) |
| **Recommended compression** | JPEG at 85% quality, or PNG with level 9 compression |
| **Set via** | Repository Settings > Social preview (manual upload) |

---

## Design Recommendations

### Layout Principles

- **Project name in large text** — survives thumbnail cropping at small sizes
- **Value proposition below the name** — one-liner that answers "why should I care?"
- **Key visual element** — logo, icon, or illustrative graphic
- **Keep critical content centred** — different platforms crop differently (Twitter crops more aggressively than Discord)
- **Brand colours for recognition** — use your project's primary colours
- **Whitespace** — don't overcrowd. 20% empty space looks professional.

### Text Guidelines

**Project name:**
- Font: Bold, sans-serif (Helvetica, Arial, or system sans-serif)
- Size: 72–96px (large enough to read at thumbnail size)
- Placement: Top 1/3 of image, centred

**Tagline/Value proposition:**
- Font: Regular or semi-bold, sans-serif
- Size: 36–48px
- Colour: Slightly lighter than project name, but still readable
- Placement: Below project name, centred
- Example: "Turn code into documentation with AI"

**Optional secondary text:**
- Font: Small, 18–24px
- Examples: version number, "⭐ Open Source", "MIT License"
- Placement: Bottom of image, left or right

### Visual Elements

**Logo placement:**
- Right side of image (leaves room for project name on left)
- Size: 200–300px square
- Ensure high contrast against background

**Background:**
- Solid colour: Choose your brand primary colour (or complementary)
- Gradient: Subtle gradient (left to right) for depth
- Avoid: Busy textures or patterns (reduces readability at small sizes)

**Icon/graphic options:**
- Symbol representing your tool (e.g., 📚 for documentation, 🔧 for developer tools)
- Simplified version of your logo
- Abstract illustration reflecting your project's purpose
- Screenshot or demo (if design is very clean and uncluttered)

---

## Example Layouts

### Layout A: Logo Right (Recommended for Text-Heavy Projects)

```
┌─────────────────────────────────────────┐
│                                         │
│   PitchDocs                        [📚] │
│   Turn code into docs with AI           │
│                                         │
│                                         │
│                          MIT • Open Source
└─────────────────────────────────────────┘
```

### Layout B: Centred Logo (Recommended for Visual Projects)

```
┌─────────────────────────────────────────┐
│                                         │
│                  [Logo]                 │
│                                         │
│           PitchDocs                     │
│      Turn code into docs with AI        │
│                                         │
│           ⭐ GitHub                    │
└─────────────────────────────────────────┘
```

### Layout C: Split Design (Recommended for Contrast)

```
┌─────────────────────┬───────────────────┐
│ Dark background     │ Light background  │
│ PitchDocs           │        [Logo]     │
│ Turn code into      │                   │
│ docs with AI        │                   │
│                     │                   │
│ ⭐ OpenSource      │    MIT License    │
└─────────────────────┴───────────────────┘
```

---

## Colour Palette

Choose your brand primary colour for the background, with high-contrast text.

**Recommended high-contrast combinations:**

| Background | Text | Works? |
|-----------|------|--------|
| Dark blue (#0066CC) | White | ✅ Excellent |
| Deep purple (#4B0082) | White | ✅ Excellent |
| Dark grey (#333333) | White | ✅ Excellent |
| Bright orange (#FF6600) | Black | ✅ Good |
| Teal (#008B8B) | White | ✅ Good |
| Light grey (#F0F0F0) | Dark blue | ✅ Good (light mode) |

**Avoid:**
- Light text on light background (unreadable)
- Red/green combinations (accessibility issue for colourblind users)
- Pastels (poor contrast, blurry at thumbnails)

---

## Tools for Creation

### Canva (Easiest for Non-Designers)

1. Visit [canva.com](https://canva.com/)
2. Search for "GitHub social preview" or "1280x640"
3. Choose a template
4. Customise with your project name, logo, colours
5. Download as PNG (Canva auto-optimises)

**Pros:** Fast, templates, auto-sizing
**Cons:** Watermark on free tier, limited customisation

### Figma (Best for Control)

1. Visit [figma.com](https://figma.com/) (free account)
2. Create a new file
3. Set canvas size to 1280 × 640
4. Import your logo, add text, shapes
5. Export as PNG at 2x scale (then resize to 1280×640)

**Pros:** Precise, portable, vector-based
**Cons:** Learning curve, more time-consuming

### Command Line (For Developers)

Use **ImageMagick** or **ffmpeg** to generate images programmatically:

```bash
# Create a 1280x640 image with background colour and text
convert -size 1280x640 xc:"#0066CC" \
  -pointsize 72 -fill white \
  -gravity Center -annotate +0+50 "PitchDocs" \
  -pointsize 36 -annotate +0-30 "Turn code into docs with AI" \
  social-preview.png

# Compress
imagemin social-preview.png --out-dir=. --plugin=optipng
```

**Pros:** Automated, scriptable, no UI
**Cons:** Requires command line, less visual feedback

### og-image Generators

Use **[og-image.vercel.app](https://og-image.vercel.app/)** (by Vercel) for dynamic generation:

1. Visit https://og-image.vercel.app/
2. Test your design in the URL: `?title=YourProjectName&description=Your%20tagline`
3. Export as PNG
4. Or deploy your own instance for automatic generation

**Pros:** Fast, parametric, no design skills needed
**Cons:** Limited customisation, hosted only

---

## How to Set on GitHub

1. **Push your image to a public location** (GitHub repo, or web host)
   ```bash
   git add docs/social-preview.png
   git commit -m "Add social preview image"
   git push
   ```

2. **Go to Repository Settings** → **General** → **Social preview**

3. **Upload the image:**
   - File size: 1–1000 KB
   - Format: PNG or JPEG
   - Dimensions: 1280 × 640

4. **Save**

5. **Verify:** Share your repo link on Twitter/Slack and check the preview

---

## Examples from Similar Projects

- **Untether:** Dark background with project name + lightning bolt icon
- **Outlook Assistant:** Microsoft Outlook branding with project name
- **PitchDocs (recommended):** Dark blue background, centred "PitchDocs" text, documentation emoji, "Turn code into docs with AI"

---

## Testing Your Preview

After uploading, test on each platform:

### Twitter/X
- Paste your GitHub URL into a tweet draft
- Use Twitter's Card validator: [cards-dev.twitter.com](https://cards-dev.twitter.com/validator)

### Slack
- Paste your GitHub URL in a Slack message
- Slack shows preview within 2–5 seconds

### Discord
- Paste your GitHub URL in a Discord message
- Preview appears immediately

### LinkedIn
- Paste your GitHub URL into a LinkedIn post
- Preview appears after a few seconds

### Facebook
- Use Facebook's Share Debugger: [developers.facebook.com/tools/debug/sharing](https://developers.facebook.com/tools/debug/sharing)

---

## Dark Mode Considerations

GitHub supports dark mode. Test that your image works in both:

- **Light mode preview:** On white/light backgrounds
- **Dark mode preview:** On dark backgrounds

**If your image has a light background:** It might blend into GitHub's light UI. Consider adding a subtle border.

**If your image has a dark background:** It will stand out on both light and dark GitHub UIs. Preferred.

---

## Optimisation Checklist

- [ ] Image is exactly 1280 × 640 pixels
- [ ] File size is under 1 MB (ideally <300 KB)
- [ ] Project name is readable at 200px wide (phone thumbnail size)
- [ ] Text has high contrast against background
- [ ] Logo/icon is centred and visible
- [ ] No text is cut off at edges (safe area: 50px margin)
- [ ] Tested on Twitter, Slack, Discord, LinkedIn
- [ ] Works in both light and dark mode
- [ ] No spelling errors

---

## Timeline

1. **Design:** 15–30 minutes (Canva) or 30–60 minutes (Figma)
2. **Upload to GitHub:** 2 minutes
3. **Verify across platforms:** 5–10 minutes
4. **Total time:** 30–80 minutes

---

## Iteration

After launch, monitor:
- How your image looks across platforms
- Feedback from the community
- Whether people are clicking through from previews

If needed, iterate:
- Simplify text if it's unreadable at small sizes
- Increase colour contrast if it's washing out
- Add/remove visual elements based on feedback
