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

CDC Bot 以前喺幾個私人 Discord server 用過一排。嗰陣想慳返啲管理工夫，我就用 Python 同 [Discord.py](https://discordpy.readthedocs.io/) 寫咗個 bot，而家已經停用。

管理員可以叫佢禁言、封鎖成員或者清訊息。平時大家亦可以玩自訂指令，有活動就用 webhook 喺頻道出通知。

呢個係我第一次用 Python 接 API。Discord 有人落指令，個 bot 先收到事件再回應，我寫佢嗰陣先開始接觸非同步程式。要知個 bot 仲有冇在線，我用咗 Flask 配 UptimeRobot。之後有機會想重寫一版，順便試吓 Telegram bot。

## 相關連結

- [GitHub 原始碼](https://github.com/ChrisWK51/CDCBot)
- [Discord.py 文件](https://discordpy.readthedocs.io/en/stable/)
- [Flask 文件](https://flask.palletsprojects.com)
