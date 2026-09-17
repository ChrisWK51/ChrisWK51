# Kit Koon's Blog

Personal blog and portfolio at [www.kitkoon.com](https://www.kitkoon.com/), built with Hugo Extended and the DoIt theme, hosted on Cloudflare Pages.

## Versions

- Hugo Extended **0.166.0**, pinned in [.hugo-version](.hugo-version).
- DoIt **v1.0.2**, pinned by the Git submodule at `themes/DoIt`.

## Local development

Install the matching [Hugo Extended release](https://github.com/gohugoio/hugo/releases/tag/v0.166.0), then initialize the theme:

```sh
git submodule update --init --recursive
hugo server --disableFastRender
```

To preview production features, including Utterances comments:

```sh
hugo server --environment production --disableFastRender
```

Build with `bash scripts/build.sh` (Git Bash on Windows). This checks the installed Hugo version and fails on build warnings. From PowerShell, the equivalent build command is:

```powershell
hugo --environment production --minify --panicOnWarning
./scripts/check-site.ps1
```

## Cloudflare Pages

Configure the existing Pages project as follows. Apply the environment variable to both **Production** and **Preview**.

| Setting | Value |
| --- | --- |
| Production branch | `master` |
| Root directory | Repository root |
| Build command | `bash scripts/build.sh` |
| Build output directory | `public` |
| Environment variable | `HUGO_VERSION=0.166.0` |

Cloudflare uses `HUGO_VERSION` to select Hugo; `.hugo-version` is the repository's version pin and is checked by the build script. See [Cloudflare's Hugo guide](https://developers.cloudflare.com/pages/framework-guides/deploy-a-hugo-site/).

Set the Preview version and review a branch deployment before merging the migration into `master`. Coordinate the Production version change with the merge: the previous LoveIt configuration needs Hugo 0.145.0, while this configuration requires the new version. Confirm the log reports `0.166.0` and `+extended`.

The `Check Hugo build` GitHub workflow validates the site without deploying it. The separate GitHub Pages workflow publishes the existing redirect to kitkoon.com.

## Updating Hugo or the theme

Use a branch, update one pinned version at a time, and run the production build. For a theme release:

```sh
git -C themes/DoIt fetch --tags
git -C themes/DoIt checkout <release-tag>
git add themes/DoIt
```

For Hugo, update `.hugo-version` and test with that exact Extended release. Update Cloudflare's Preview and Production `HUGO_VERSION` when deploying it. Avoid an automatic `latest` setting.

Check the home page and pagination, post URLs, search, cover images, mobile navigation, dark mode, and comments. Utterances uses the existing `ChrisWK51/ChrisWK51` repository and `pathname` mapping, so keep post paths unchanged.

The migration keeps the original post dates and URLs, including `/protfolio/`. Search uses Fuse.js with a small `layouts/index.json` override that provides one result per page and omits date labels for undated pages. The previous unused Markdown output and removed inline Font Awesome option have been dropped. DoIt's built-in share controls use Twitter/X, Facebook, Line, and Telegram; the previous Threads share control is not provided by this theme.

For rollback, revert the migration commit and restore `HUGO_VERSION=0.145.0`. Cloudflare's [deployment rollback](https://developers.cloudflare.com/pages/configuration/rollbacks/) can restore the previously deployed files immediately.

Branding instructions are in [docs/branding.md](docs/branding.md).
