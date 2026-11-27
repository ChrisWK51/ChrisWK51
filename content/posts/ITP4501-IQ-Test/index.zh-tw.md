---
title: "用 Java 寫 Android IQ 測驗"
date: 2020-07-16T00:00:00+08:00
lastmod: 2025-05-21T16:10:00+08:00
draft: false
author: "Kit Koon"
authorLink: "/zh-tw/about/"
description: "IVE ITP4501 課堂作品，有計時數字推理題，可以用 SQLite 儲存同翻睇成績。"
summary: "IVE ITP4501 課堂作品，有計時數字推理題，可以用 SQLite 儲存同翻睇成績。"
images: []
featuredImage: "featured-image.png"
resources:
- name: "featured-image"
  src: "featured-image.png"

tags: ["Java","SQLite","Android Development","Completed"]
categories: ["project"]

lightgallery: true

toc:
  auto: false
---

## 簡介

讀 IVE 嘅 **ITP4501** 嗰陣，我用 Java 寫咗個 Android IQ 測驗 app。玩法係答一系列數字推理題，答完就可以睇返表現。

## 功能

- 每題都有計時，揀完答案即時知道啱定錯，答錯亦可以睇返正確答案。
- 做完整份測驗會自動計分，顯示成績總結。
- 題目、分數同測驗紀錄都存在 SQLite。
- 可以用成績表同比較分數嘅棒形圖睇返自己有冇進步。

## 學到啲咩

由 Android 畫面、Java 邏輯到 SQLite 都要自己接埋一齊。除咗計啱個分，我仲要諗用家點樣知道答錯咗邊題，同埋下次開 app 點樣搵返上次成績。呢啲細節令我開始留意用家實際點用個程式。

## 相關連結

- [GitHub 原始碼](https://github.com/ChrisWK51/ITP4501-IQ-Test)
- [課程資料](https://www.vtc.edu.hk/admission/tc/programme/it114105-higher-diploma-in-software-engineering/)
