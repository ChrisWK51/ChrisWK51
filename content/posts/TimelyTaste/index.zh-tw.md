---
title: "TimelyTaste 外賣平台後端"
date: 2022-01-05T00:00:00+08:00
lastmod: 2025-05-21T00:00:00+08:00
draft: false
author: "Kit Koon"
authorLink: "/zh-tw/about/"
description: "理大嘅小組作品，用 Python、Flask、MongoDB 同 Docker 整事件驅動嘅外賣平台後端。"
summary: "理大嘅小組作品，用 Python、Flask、MongoDB 同 Docker 整事件驅動嘅外賣平台後端。"
images: []

tags: ["Python", "Flask", "Pytest", "Docker", "MongoDB", "Completed"]
categories: ["project"]

lightgallery: true

toc:
  auto: false
---

TimelyTaste 係我哋讀理大 **COMP3122** 嗰陣一齊做嘅外賣平台後端。設計 API 嗰陣，我哋參考咗 Uber Eats。

後端分咗幾個微服務，用 Python 同 Flask 寫 REST API，資料就放喺 MongoDB。服務之間靠事件通知對方，成套可以用 Docker Compose 一齊開。我哋亦寫咗單元測試，方便分開試每個服務。

幾個人分開寫服務，我哋要先夾好一邊會發咩事件，另一邊先知點接。

## 相關連結

- [GitHub 原始碼](https://github.com/ChrisWK51/TimelyTaste)
- [Uber Eats API](https://developer.uber.com/docs/eats/introduction)
- [Docker 文件](https://docs.docker.com/)
- [Flask 文件](https://flask.palletsprojects.com/)
- [MongoDB 文件](https://docs.mongodb.com/)
- [Pytest 文件](https://docs.pytest.org/)
