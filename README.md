### Dockenv
> 基于 `Docker` 的一站式开发环境

## 软件镜像列表

| 名称 | 版本 | 备注 |
|---|---|---|
| Nginx | latest | 自定义扩展 始终是最新版本 |
| php | 5.6 7.4 8.0 8.1 8.2 8.3 | 自定义扩展 |
| mysql | 5.6 5.7 8.0 | 自定义 |
| MariaDB | 10.2 - 10.9 latest | 自定义配置 |
| Redis | latest | 支持定义版本 |
| Memcache | latest | 支持定义版本 |
| PostgreSQL | latest | 支持定义版本 |
| Mongo | latest | 支持定义版本 |
| rabbitmq | latest | 支持定义版本 |

## Usage
```sh
cp .env-example .env
docker-compose up -d
```