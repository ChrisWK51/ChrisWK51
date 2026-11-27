---
title: "同 AI 一齊升級 Hugo，由 LoveIt 搬去 DoIt"
date: 2026-09-17T21:00:00+08:00
lastmod: 2026-09-19
draft: false
author: "Kit Koon"
authorLink: "/zh-tw/about/"
description: "更新 Hugo 之後搬去 DoIt，搞掂 Cloudflare 版本設定，最後仲畀瀏覽器快取嚇咗一嚇。"
summary: "更新 Hugo 之後搬去 DoIt，搞掂 Cloudflare 版本設定，最後仲畀瀏覽器快取嚇咗一嚇。"
images: []
tags: ["Hugo", "LoveIt", "DoIt", "Cloudflare", "Vibe Coding"]
categories: ["Miscellaneous"]
toc:
  auto: false
---

我想升級 Hugo，但最想知嘅係會唔會整壞個 blog。我幾鍾意而家個樣，冇打算為咗升個版本就由頭整過。

同 AI 傾咗幾轉，最後升級咗 Hugo，亦由 LoveIt 搬去 DoIt。個站已經喺 Cloudflare Pages 跑緊，所以部署設定都要一齊試。最初點樣搭起個站，我寫過喺[之前嗰篇]({{< relref "/posts/personal_page" >}})。

## 點解換 DoIt

用原本嘅 LoveIt 配 Hugo 0.166.0，一 build 就失敗。DoIt 係由 LoveIt 發展出嚟，兩個主題個樣幾似，我可以保留原本嘅排版、深色模式、導覽列，仲有隻浣熊。

| 元件 | 之前 | 之後 |
| --- | --- | --- |
| Hugo Extended | 0.145.0 | 0.166.0 |
| 主題 | LoveIt | DoIt v1.0.2 |

兩個版本都固定咗，下次升級可以開另一條 branch 慢慢試。

## 同 AI 點樣分工

我叫 AI 睇個 repo、比較主題，再落手改。佢改咗設定、將搜尋換成 Fuse.js，加埋 build script 同 GitHub 嘅 build check。

中途仲執咗文章封面、浣熊標誌對齊，同埋窄螢幕上面嘅頁首。搜尋本身會搵到幾個相同結果，我哋改咗個 template，每頁只出現一次，亦唔會再喺冇日期嘅頁面顯示 `0001` 年。

我負責喺本機試、睇返啲改動，再處理 Cloudflare 設定同 pull request。部署失敗嗰陣，我就將 log 貼返入對話一齊搵原因。

## 舊網址同 RSS

升級前個站有八篇文，一共產生 68 個 HTML 頁面。升級後檢查過，舊網址同文章日期都對得返，搜尋、圖片、手機排版、深色模式同留言亦試過。

我特別想保留 `/posts/index.xml`。本機打開 `http://localhost:1313/posts/index.xml` 正常，原有嘅[英文 RSS](/posts/index.xml) 亦沿用同一條網址。Utterances 留言係靠文章路徑搵返對應嘅 GitHub issue，保留路徑同 repo，舊留言就繼續用得。

## Cloudflare 一直裝返舊版 Hugo

本機同 GitHub 都 build 到，但 Cloudflare Preview 個 log 寫住：

```text
Installing hugo extended_0.145.0
```

Script 要求 0.166.0，所以即刻停咗。我改完設定再試，個 log 仲係 0.145.0。

原來要改嘅係 **Preview**。Cloudflare 將 Preview 同 Production 分開，而我條 branch 用緊 Preview。Repo 入面嘅 `.hugo-version` 冇幫我改到 Cloudflare 裝邊個版本。

| Cloudflare Pages 設定 | 值 |
| --- | --- |
| Build command | `bash scripts/build.sh --gc` |
| Output directory | `public` |
| Preview 同 Production 嘅環境變數 | `HUGO_VERSION=0.166.0` |

改完 Preview 就部署到。兩個 check 都過，我 merge 入 `master`，再確認正式網站已經跑緊新版，RSS 亦開到。

## 最後嚇咗一嚇：瀏覽器快取

一打開正式網站，隻浣熊遮住咗段自我介紹，下面啲間距又怪怪哋。搞掂個 build，以為仲有嘢整壞咗。

![清除快取前，浣熊同首頁介紹疊埋一齊。](browser-cache-before-refresh.png)

清咗瀏覽器快取，再 refresh 一次，個版面就正常返。

## 參考

- [Hugo 0.166.0](https://github.com/gohugoio/hugo/releases/tag/v0.166.0)
- [DoIt v1.0.2](https://github.com/HEIGE-PCloud/DoIt/releases/tag/v1.0.2)
- [Cloudflare Pages 嘅 Hugo 版本設定](https://developers.cloudflare.com/pages/framework-guides/deploy-a-hugo-site/#use-a-specific-or-newer-hugo-version)
- [網站原始碼](https://github.com/ChrisWK51/ChrisWK51)
- [建構同部署筆記](https://github.com/ChrisWK51/ChrisWK51/blob/master/docs/site-maintenance.md)
