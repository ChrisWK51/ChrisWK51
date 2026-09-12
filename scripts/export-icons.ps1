# Regenerate browser icons after editing static/images/raccoon.svg.
# Requires Google Chrome (headless) and PowerShell on Windows.
param(
    [string]$ChromePath = 'C:\Program Files\Google\Chrome\Application\chrome.exe'
)

$ErrorActionPreference = 'Stop'
if (-not (Test-Path -LiteralPath $ChromePath)) {
    throw 'Chrome was not found. Pass its executable path with -ChromePath.'
}

$repoRoot = Split-Path -Parent $PSScriptRoot
$staticRoot = Join-Path $repoRoot 'static'
$sourcePath = Join-Path $staticRoot 'images/raccoon.svg'
$source = [System.IO.File]::ReadAllText($sourcePath)
$shape = [regex]::Match($source, '(?s)<g id="raccoon".*?</g>').Value
if (-not $shape) { throw 'The source SVG must contain the raccoon group.' }

$favicon = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64">
  <title>Kit Koon's Blog</title>
  <rect width="64" height="64" rx="14" fill="#252627"/>
  <g color="#f5f5f5">$shape</g>
</svg>
"@
$utf8 = [System.Text.UTF8Encoding]::new($false)
[System.IO.File]::WriteAllText((Join-Path $staticRoot 'favicon.svg'), $favicon, $utf8)
[System.IO.File]::WriteAllText((Join-Path $staticRoot 'safari-pinned-tab.svg'), $source, $utf8)

$exportDir = Join-Path ([System.IO.Path]::GetTempPath()) ('kitkoon-icons-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $exportDir | Out-Null
$htmlPath = Join-Path $exportDir 'icon.html'
$pngPath = Join-Path $exportDir 'icon-512.png'
# Use a solid tile for home-screen icons; platforms apply their own corner masks.
$html = @"
<!doctype html><html><head><meta charset="utf-8">
<style>html,body{margin:0;width:512px;height:512px;overflow:hidden;background:#252627}svg{display:block;width:512px;height:512px}</style>
</head><body>$favicon</body></html>
"@
[System.IO.File]::WriteAllText($htmlPath, $html, $utf8)
$profileDir = Join-Path $exportDir 'chrome-profile'
$arguments = @(
    '--headless', '--disable-gpu', '--no-first-run', '--no-default-browser-check',
    '--hide-scrollbars', '--force-device-scale-factor=1', '--window-size=512,512',
    '--virtual-time-budget=1000', "--user-data-dir=`"$profileDir`"",
    "--screenshot=`"$pngPath`"", ([uri]$htmlPath).AbsoluteUri
)
$browser = Start-Process -FilePath $ChromePath -ArgumentList $arguments -WindowStyle Hidden -Wait -PassThru
if ($browser.ExitCode -ne 0 -or -not (Test-Path -LiteralPath $pngPath)) {
    throw 'Chrome failed to render the favicon.'
}

Add-Type -AssemblyName System.Drawing
$master = [System.Drawing.Image]::FromFile($pngPath)
try {
    if ($master.Width -ne 512 -or $master.Height -ne 512) {
        throw 'Expected a 512 by 512 icon export.'
    }
    $outputs = @{
        'android-chrome-512x512.png' = 512
        'android-chrome-192x192.png' = 192
        'apple-touch-icon.png' = 180
        'favicon-32x32.png' = 32
        'favicon-16x16.png' = 16
    }
    foreach ($entry in $outputs.GetEnumerator()) {
        $bitmap = [System.Drawing.Bitmap]::new($entry.Value, $entry.Value)
        $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
        try {
            $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
            $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
            $graphics.DrawImage($master, 0, 0, $entry.Value, $entry.Value)
            $bitmap.Save((Join-Path $staticRoot $entry.Key), [System.Drawing.Imaging.ImageFormat]::Png)
        } finally {
            $graphics.Dispose()
            $bitmap.Dispose()
        }
    }
} finally {
    $master.Dispose()
}

# ICO supports PNG payloads; include both standard tab sizes.
$icons = @(16, 32)
$stream = [System.IO.File]::Create((Join-Path $staticRoot 'favicon.ico'))
$writer = [System.IO.BinaryWriter]::new($stream)
try {
    $writer.Write([uint16]0)
    $writer.Write([uint16]1)
    $writer.Write([uint16]$icons.Count)
    $offset = 6 + 16 * $icons.Count
    foreach ($size in $icons) {
        $bytes = [System.IO.File]::ReadAllBytes((Join-Path $staticRoot "favicon-${size}x${size}.png"))
        $writer.Write([byte]$size)
        $writer.Write([byte]$size)
        $writer.Write([byte]0)
        $writer.Write([byte]0)
        $writer.Write([uint16]1)
        $writer.Write([uint16]32)
        $writer.Write([uint32]$bytes.Length)
        $writer.Write([uint32]$offset)
        $offset += $bytes.Length
    }
    foreach ($size in $icons) {
        $writer.Write([System.IO.File]::ReadAllBytes((Join-Path $staticRoot "favicon-${size}x${size}.png")))
    }
} finally {
    $writer.Dispose()
}
Write-Output 'Exported SVG, PNG, Safari, and ICO icons to static/.'
