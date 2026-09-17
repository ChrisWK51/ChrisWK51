---
title: "Vibe Coding My Hugo Upgrade: From LoveIt to DoIt"
date: 2026-09-17T21:00:00+08:00
lastmod: 2026-09-17T21:00:00+08:00
draft: false
author: "Kit Koon"
authorLink: "/about/"
description: "An AI-assisted Hugo upgrade from LoveIt to DoIt, with working RSS, a Cloudflare version mismatch, and one last browser cache surprise."
summary: "I wanted to update Hugo without breaking my blog. Here is how an AI-assisted migration to DoIt went, including the Cloudflare build failure and the cache issue that made the finished site look broken."
images: []
tags: ["Hugo", "LoveIt", "DoIt", "Cloudflare", "Vibe Coding"]
categories: ["Miscellaneous"]
toc:
  auto: false
---

## Can I upgrade this without breaking everything?

That was basically my starting question. My blog was running Hugo Extended 0.145.0 with the LoveIt theme, and I wanted to bring it up to date. I liked the existing layout, though. I wanted the site to still feel like my site when the work was done.

I was already using Cloudflare Pages for hosting. The job was to update the site and make sure Cloudflare could build it.

This is a follow-up to [building my personal site with Hugo]({{< relref "/posts/personal_page" >}}), with more debugging than I originally expected.

## Why I moved to DoIt

The first compatibility check gave me a useful answer: the existing LoveIt setup failed to build with Hugo 0.166.0. Simply increasing the version number was going to need more work.

DoIt is based on LoveIt, so it offered a familiar starting point for the migration. I could keep the blog layout, raccoon branding, dark mode, and navigation while updating the theme and its configuration.

These are the versions we ended up testing and deploying:

| Component | Before | After |
| --- | --- | --- |
| Hugo Extended | 0.145.0 | 0.166.0 |
| Theme | LoveIt | DoIt v1.0.2 |
| Hosting | Cloudflare Pages | Cloudflare Pages |

Both Hugo and the theme are pinned to those versions. For the next upgrade, I want to change the pins deliberately and check a preview before deploying.

## The vibe coding part

I used an AI coding assistant to inspect the repository, compare the theme options, update the configuration, and run checks. My side of the conversation was mostly practical questions: will this break, will RSS still work, and why is Cloudflare installing the old version?

The assistant handled much of the repetitive work. The migration included simplifying the theme configuration, moving search to Fuse.js, restoring the post cover images, and adjusting the raccoon logo and narrow mobile header. It also added a build script and a GitHub Actions check.

There were small details to catch. Search initially produced duplicate results for sections within the same page, so we added a search-index template that returns one result per page. Undated pages also needed to stop showing a year of `0001`.

I still had to review the result, test the site, change the Cloudflare settings, and work through the pull request. Being able to ask the assistant about each failure was useful, especially when the problem turned out to be outside the code.

## Keeping the old links and RSS working

At the time of the migration, the site had eight posts and 68 generated HTML page paths. The checks confirmed that all of those paths were preserved, along with the original post dates and feed links.

I specifically checked the RSS feed locally at `http://localhost:1313/posts/index.xml`. It worked. The public feed still lives at [/posts/index.xml](/posts/index.xml), so existing subscribers can keep using it.

Comments mattered too. The site uses Utterances with the page pathname as its issue mapping. Keeping the post paths and the same comment repository preserved that mapping.

We also checked links, images, desktop and mobile search, dark mode, galleries, and the comment widget. A successful build was only part of the review.

## Cloudflare kept installing the old Hugo

The GitHub build passed, but the Cloudflare preview failed. The logs showed the problem clearly:

```text
Installing hugo extended_0.145.0
```

The new build script expected 0.166.0 and stopped. Cloudflare was still selecting the old version before it even ran the script.

The settings needed for the migrated site were:

| Cloudflare Pages setting | Value |
| --- | --- |
| Build command | `bash scripts/build.sh --gc` |
| Output directory | `public` |
| Environment variable | `HUGO_VERSION=0.166.0` |

The detail I had to pay attention to was **Preview and Production have separate environment settings**. My pull request needed the Preview version configured as well. A version written in the repository's `.hugo-version` file did not configure Cloudflare's installer for me.

After sorting out the environment setting, the preview deployed successfully. Both pull request checks passed, I merged into `master`, and the production site was verified with Hugo 0.166.0, DoIt, and a working RSS feed.

## One last surprise: the browser cache

After deployment, I saw a badly arranged page and thought something was still wrong. Clearing my browser cache fixed it.

That was a useful final reminder: even after the build and deployment succeed, check what the browser is actually displaying. A hard refresh or a fresh browser session is a quick thing to try when the page looks different from the preview.

## What I took away

This was a useful way to work with an AI coding assistant. I could describe the outcome I wanted, get help with the edits, and bring back the actual error logs when something failed.

The checks made the migration easier to trust. The version guard caught the Cloudflare mismatch, the path comparison protected existing links, and testing RSS answered one of my main questions. The next update now has a documented build process and a preview workflow to follow.

The blog still looks familiar, the raccoon is still here, and I finally made the displayed name consistent as **Kit Koon**.

## References

- [Hugo 0.166.0 release](https://github.com/gohugoio/hugo/releases/tag/v0.166.0)
- [DoIt v1.0.2 release](https://github.com/HEIGE-PCloud/DoIt/releases/tag/v1.0.2)
- [Cloudflare Pages: choosing a Hugo version](https://developers.cloudflare.com/pages/framework-guides/deploy-a-hugo-site/#use-a-specific-or-newer-hugo-version)
- [This site's source and build instructions](https://github.com/ChrisWK51/ChrisWK51)
