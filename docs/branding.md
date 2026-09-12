# Raccoon logo

The editable source is [static/images/raccoon.svg](../static/images/raccoon.svg).
It uses the surrounding text color so the header logo follows the site's theme.
The header embeds it through the LoveIt title prefix; the visible blog name labels
the home link, so the decorative icon is hidden from screen readers.

The favicon uses the same shape in off-white on charcoal. The SVG, ICO, PNG,
Apple touch icon, Safari mask, and webmanifest live in static/.
The generated icons are static assets; building the blog does not require Chrome.

After editing the source SVG, regenerate the icon exports on Windows:

```powershell
.\scripts\export-icons.ps1
```

The export script uses headless Google Chrome and System.Drawing.
Pass -ChromePath if Chrome is installed in a different location.

Header sizing lives in [assets/css/_custom.scss](../assets/css/_custom.scss).
The full name and logo were checked in light and dark themes, including a 320 px
phone viewport. Browser tab exports include 16 px and 32 px sizes.
