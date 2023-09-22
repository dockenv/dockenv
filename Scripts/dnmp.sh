#!/usr/bin/env bash
###
 # @Author: Cloudflying
 # @Date: 2023-04-15 00:14:43
 # @LastEditTime: 2023-04-15 01:10:46
 # @LastEditors: Cloudflying
 # @Description: dnmp 管理脚本
### 

# 检查状态
_status()
{
	docker-compose ps
}

_start()
{
	docker compose up redis memcached
}

_restart()
{
	docker compose restart
}