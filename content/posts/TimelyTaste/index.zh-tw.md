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

## 簡介

TimelyTaste 係我哋喺香港理工大學讀 **COMP3122** 嗰陣做嘅小組作品。我哋參考 Uber Eats API，將外賣平台嘅後端拆成幾個微服務，用 REST API 提供功能，再用事件通知其他服務有嘢要處理。

## 功能

- 微服務之間用事件溝通。
- 用 Docker Compose 一齊啟動同管理啲服務。
- 用 REST API 處理外賣平台嘅請求。
- 用單元測試檢查服務嘅行為。

## 學到啲咩

呢次有機會用 Docker、Flask 同 MongoDB 寫一個分開幾個服務嘅後端。小組開發除咗要搞掂自己嗰部分，仲要同組員夾好服務之間點溝通，最後先可以一齊跑得順。

## 相關連結

- [GitHub 原始碼](https://github.com/ChrisWK51/TimelyTaste)
- [Uber Eats API](https://developer.uber.com/docs/eats/introduction)
- [Docker 文件](https://docs.docker.com/)
- [Flask 文件](https://flask.palletsprojects.com/)
- [MongoDB 文件](https://docs.mongodb.com/)
- [Pytest 文件](https://docs.pytest.org/)
