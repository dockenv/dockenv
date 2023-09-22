#!/usr/bin/env bash
###
 # @Author: Cloudflying
 # @Date: 2023-04-15 00:13:05
 # @LastEditTime: 2023-04-15 00:21:13
 # @LastEditors: Cloudflying
 # @Description: 初始化 DNMP 环境
### 

# 应用配置文件
mkdir -p conf/{nginx,redis,memcached} conf/nginx/vhost
# 应用数据
mkdir -p data/{nginx,redis,memcached}
# 应用日志
mkdir -p logs/{nginx,redis}