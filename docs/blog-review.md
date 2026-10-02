# Blog and portfolio review

The site works best with two entry points: a chronological blog for returning readers and a curated Projects page for people assessing your work. Your projects cover backend, web, mobile, and assembly programming, but most write-ups currently list features without enough detail about how you built them.

## Organization applied

- **Home:** Welcome to My Blog is pinned first with `pinOnHome: true`; the remaining posts are newest first. The pin applies before pagination, so the welcome post appears only once.
- **Blog, categories, tags, and RSS:** newest posts first. Post weights remain unset so the homepage pin does not affect these lists.
- **Projects:** featured work, learning and coursework, then archived projects. Tutorial work is clearly identified.
- **Navigation:** About, Blog, Projects, and Tags. Existing category pages remain available through post metadata.
- **Post previews:** explicit summaries, descriptive titles, consistent author names, and links to the current About page.
- **Project articles:** consistent Overview, Features, and What I learned headings. Added links between the React portfolio and its Hugo replacement.
- **Assets:** removed nonexistent cover-image declarations from TimelyTaste and both personal-site write-ups.

No post dates or existing post URLs were changed. The spelling of the existing /protfolio/ URL is preserved so incoming links continue to work.

## Homepage order

| Position | Post | Recorded date |
| --- | --- | --- |
| 1 (pinned) | Welcome to My Blog | 2025-05-20, 00:00 HKT |
| 2 | OpenWrt and Tailscale: My VPN Routing at Home and Away | 2026-10-01 |
| 3 | Vibe Coding My Hugo Upgrade: From LoveIt to DoIt | 2026-09-17 |
| 4 | Next.js Dashboard: Learning Full-Stack Development | 2025-09-26 |
| 5 | Building My Personal Site with Hugo | 2025-05-20, 17:26 HKT |
| 6 | MIPS Radix Converter | 2023-03-26 |
| 7 | CDC Bot: A Python Discord Bot | 2022-04-22 |
| 8 | My First Portfolio with React | 2022-01-05 |
| 9 | TimelyTaste: A Food Delivery Backend | 2022-01-05 |
| 10 | IQ Test: An Android App in Java | 2020-07-16 |

The homepage shows six posts per page, including the pinned welcome post on page one, and uses title order to break timestamp ties among the other posts. Year-grouped archives may order tied posts differently. TimelyTaste still leads the curated Projects page.

**Check TimelyTaste's date:** its timestamp exactly matches the old React portfolio's timestamp. Confirm the actual date before changing it; the current date alone does not establish an error.

## Content improvements to prioritize

| Post | Most useful next addition |
| --- | --- |
| TimelyTaste | Explain your individual contribution to the group project. Show the service boundaries and trace one request or event through the system. Include one actual test example. |
| Hugo personal site | Show a specific maintenance problem in the React version and how Hugo changed the editing or publishing workflow. Add a before/after screenshot if available. |
| Next.js dashboard | Explain one concept you can now apply independently. Separate tutorial-provided functionality from any changes you made, and include a screenshot or working demo. |
| Android IQ test | Show the question and results screens, explain the SQLite data model, and describe one implementation challenge. |
| MIPS converter | Include one input/output example and explain how you handled negative integers or invalid input in assembly. |
| CDC Bot | Show a concrete command and how it works. Clarify what Flask and UptimeRobot monitored and whether a separate restart mechanism existed. |
| React portfolio | Add a screenshot and one specific lesson that informed the replacement site. Keep its archived status visible. |
| Welcome post | Keep it as an introduction. Use the Projects and About pages as the main destinations for new visitors. |

For future project posts, aim to answer: What problem did I solve? What did I personally build? Which decision was difficult, and why did I choose this approach? What evidence shows the result? What would I change next?

Replace repeated phrases such as “a great learning experience” with concrete examples. Add outcomes, usage figures, or performance claims only when you have evidence for them.

The About page could also be shorter: lead with what you build, follow with education, and finish with personal interests and contact links. Its broad statements about enthusiasm currently take more space than examples of your work.

## Maintaining the order

1. Create a post with Hugo, for example: hugo new content posts/my-project/index.md.
2. Use the date field for the post's intended place in the timeline and lastmod for subsequent revisions. Leave weight unset for chronological ordering.
   The welcome post uses `pinOnHome: true` for homepage-only pinning. The local `layouts/_partials/head/paginator.html` override applies this before DoIt's pagination; keep its section and taxonomy handling in sync when updating the theme.
3. Write a short description for metadata and a summary for the homepage preview.
4. For a project, use the existing project category and technology tags with consistent spelling.
5. Add the project to the appropriate group in content/projects/index.md. This page's order is maintained independently of publication dates.
6. Keep established URLs when changing titles; use Hugo relref links for internal content references.

This uses Hugo's documented [default page ordering](https://gohugo.io/quick-reference/page-collections/): weight, then descending date, then title.

## Existing technical follow-ups

- The unused Markdown page output was removed during the September 2026 DoIt migration, resolving the previous missing-template warning.
- Cloudflare Pages builds the site. GitHub Pages publishes a redirect to kitkoon.com, and the separate Hugo check workflow validates builds. Current versions and deployment settings are in [the site maintenance guide](site-maintenance.md).

Review scope: local content, configuration, theme behavior, and generated pages. The live domain could not be retrieved during the review; external project repositories and their implementation claims were not audited.

## Validation

Built successfully with Hugo Extended 0.145.0 and the repository's pinned LoveIt theme, including production Git metadata. Checked chronological ordering across both homepage pages, the Blog archive, the project category, and both RSS feeds. Verified all seven curated project links, preserved all 67 existing HTML paths, and confirmed that post dates are unchanged. Checked the Projects page in a local browser. The existing Markdown-output warning remains.

## Homepage pin validation (2026-10-02)

Built with the pinned Hugo Extended 0.166.0 and passed the existing site checks: 86 HTML files, local links/assets, 12 unique search results, and both main post feeds. Compared builds before and after the change: all 10 posts appear once across the two homepage pages, Welcome is first, and the remaining posts keep their chronological order. All 35 archive/category/tag pages and 37 RSS feeds retain their previous post order; feed publication dates are unchanged.
