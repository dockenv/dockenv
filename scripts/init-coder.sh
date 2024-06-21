#!/usr/bin/env bash
###
# @Author: Cloudflying
# @Date: 2024-06-18 10:54:05
 # @LastEditTime: 2024-06-18 11:47:43
 # @LastEditors: Cloudflying
# @Description: Init Code Server
###

CODER_VER="4.90.2"
CODER_URL="https://mirrors.xieke.org/pkgs/Editor/coder/code-server-${CODER_VER}-linux-amd64.tar.gz"

if [[ ! -d /opt/coder ]]; then
  wget -c ${CODER_URL} -O /tmp/coder.tar.gz
fi
