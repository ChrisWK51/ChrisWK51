param(
    [string]$PublicDir = (Join-Path $PSScriptRoot '../public')
)
$ErrorActionPreference = 'Stop'
$publicRoot = (Resolve-Path -LiteralPath $PublicDir).Path
$files = @(Get-ChildItem -LiteralPath $publicRoot -Recurse -File)
# Use case-sensitive paths to catch links that would fail on Cloudflare's Linux build.
$paths = [Collections.Generic.HashSet[string]]::new([StringComparer]::Ordinal)
foreach ($file in $files) {
    $null = $paths.Add([IO.Path]::GetRelativePath($publicRoot, $file.FullName).Replace('\', '/'))
}
$errors = [Collections.Generic.List[string]]::new()
$requiredPages = @(
    'index.html', 'page/2/index.html', 'posts/index.html', 'tags/index.html',
    'about/index.html', 'projects/index.html', 'next-js.learn/index.html',
    'personal_page/index.html', 'welcome-to-my-page/index.html', 'comp2421_pa1/index.html',
    'cdcbot/index.html', 'protfolio/index.html', 'timelytaste/index.html',
    'itp4501-iq-test/index.html', '404.html'
)
foreach ($path in $requiredPages) {
    if (-not $paths.Contains($path)) { $errors.Add("Missing established page: $path") }
}
foreach ($path in @('favicon.svg', 'images/raccoon.svg', 'welcome-to-my-page/featured-image.jpg', 'itp4501-iq-test/featured-image.png')) {
    if (-not $paths.Contains($path)) { $errors.Add("Missing branding or cover asset: $path") }
}

$siteOrigin = [uri]'https://www.kitkoon.com/'
$htmlFiles = @($files | Where-Object Extension -eq '.html')
foreach ($file in $htmlFiles) {
    $relative = [IO.Path]::GetRelativePath($publicRoot, $file.FullName).Replace('\', '/')
    $pageUri = [uri]::new($siteOrigin, $relative)
    $html = [IO.File]::ReadAllText($file.FullName)
    $tags = [regex]::Matches($html, '<(?:a|img|script|link|use|source)\b[^>]*>', 'IgnoreCase')
    foreach ($tag in $tags) {
        foreach ($attribute in [regex]::Matches($tag.Value, '\b(?:href|src)=(?:"(?<url>[^"]*)"|''(?<url>[^'']*)''|(?<url>[^\s>]+))', 'IgnoreCase')) {
            $url = [Net.WebUtility]::HtmlDecode($attribute.Groups['url'].Value)
            if (-not $url -or $url.StartsWith('#')) { continue }
            $target = [uri]::new($pageUri, $url)
            if ($target.Scheme -notin @('http', 'https') -or $target.Host -ne $siteOrigin.Host) { continue }
            $targetPath = [uri]::UnescapeDataString($target.AbsolutePath).TrimStart('/')
            if (-not $targetPath -or $targetPath.EndsWith('/')) { $targetPath += 'index.html' }
            if (-not $paths.Contains($targetPath) -and -not $paths.Contains("$targetPath/index.html")) {
                $errors.Add("$relative references missing local file: $url")
            }
        }
    }
}

$search = @(Get-Content -LiteralPath (Join-Path $publicRoot 'index.json') -Raw | ConvertFrom-Json)
$uris = [Collections.Generic.HashSet[string]]::new([StringComparer]::Ordinal)
foreach ($entry in $search) {
    if (-not $uris.Add($entry.uri)) { $errors.Add("Duplicate search result: $($entry.uri)") }
    if ($entry.date -eq '0001-01-01') { $errors.Add("Invalid search date: $($entry.uri)") }
    if (-not $paths.Contains($entry.uri.TrimStart('/') + 'index.html')) {
        $errors.Add("Search result has no page: $($entry.uri)")
    }
}
foreach ($uri in @('/about/', '/projects/', '/timelytaste/', '/itp4501-iq-test/')) {
    if (-not $uris.Contains($uri)) { $errors.Add("Missing search result: $uri") }
}

foreach ($feedPath in @('index.xml', 'posts/index.xml')) {
    [xml]$feed = Get-Content -LiteralPath (Join-Path $publicRoot $feedPath) -Raw
    if (@($feed.rss.channel.item).Count -lt 8) { $errors.Add("$feedPath is missing existing posts") }
}

if ($errors.Count) { throw ($errors -join [Environment]::NewLine) }
Write-Output ("Checked {0} HTML files, local links/assets, {1} unique search results, and both post feeds." -f $htmlFiles.Count, $search.Count)

