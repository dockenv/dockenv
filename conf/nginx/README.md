## Nginx

``` nginx
# 匹配到 url 则跳转 如 github 下载
location ~ ^/[^/]+/[^/]+/releases/download/ {
    return 301 https://download.fastgit.org$request_uri;
}
```