---
title: "用 Python 寫嘅 Discord 機械人 CDC Bot"
date: 2022-04-22T00:00:00+08:00
lastmod: 2025-05-20T18:50:00+08:00
draft: false
author: "Kit Koon"
authorLink: "/zh-tw/about/"
description: "用 Python 同 Discord.py 寫嘅伺服器管理機械人，有自訂指令同通知，現已停用。"
summary: "用 Python 同 Discord.py 寫嘅伺服器管理機械人，有自訂指令同通知，現已停用。"
images: []

tags: ["Python","Discord.py","UptimeRobot","Flask","Archived"]
categories: ["project"]

lightgallery: true

toc:
  auto: false
---

## 簡介

我寫 CDC Bot 嗰陣，想將 Discord 伺服器入面啲重複工作交畀機械人處理，順便加幾個好玩嘅指令。程式用 **Python** 同 [Discord.py](https://discordpy.readthedocs.io/)，另外用 Flask 配 UptimeRobot 監察佢係咪仲在線。

佢喺幾個私人伺服器用過一排，而家已經停用。

## 功能

- 管理員可以將成員禁言、封禁或者清除訊息。
- 成員可以用自訂指令同機械人互動。
- 用 webhook 將指定活動嘅通知傳入頻道。
- 用 Flask 同 UptimeRobot 留意服務有冇中斷。

## 學到啲咩

呢個係我第一次用 Python 接 API。寫完指令仲要等 Discord 嘅事件、處理非同步回應，再諗點樣知道個 bot 有冇跌線。最開心係見到朋友真係會喺伺服器用佢。之後有機會想重寫一版，亦想試整 Telegram bot。

## 相關連結

- [GitHub 原始碼](https://github.com/ChrisWK51/CDCBot)
- [Discord.py 文件](https://discordpy.readthedocs.io/en/stable/)
- [Flask 文件](https://flask.palletsprojects.com)
