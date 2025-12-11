### Dockenv
- 基于 `Docker` 的一站式开发环境
- Run on Github CodeSpace/Codesandbox
- 支持使用全局网络跨 compose 通信

## 软件镜像列表

| 名称       | 版本                    | 备注                      |
| ---------- | ----------------------- | ------------------------- |
| Nginx      | latest                  | 自定义扩展 始终是最新版本 |
| php        | 5.6 7.4 8.0 8.1 8.2 8.3 | 自定义扩展                |
| mysql      | 5.6 5.7 8.0             | 自定义                    |
| MariaDB    | 10.2 - 10.9 latest      | 自定义配置                |
| Redis      | latest                  | 支持定义版本              |
| Memcache   | latest                  | 支持定义版本              |
| PostgreSQL | latest                  | 支持定义版本              |
| Mongo      | latest                  | 支持定义版本              |
| rabbitmq   | latest                  | 支持定义版本              |

## Usage
```sh
# Copy Env File
cp .env-example .env
# Usage:
./dockenv.sh start `{compose}`
# example
./dockenv.sh start dockenv
```
## Compose
- dockenv: Alpine + Nginx/Mysql/Mariadb+Redis/Memcache/PostgreSQL/Mongo
- elk: Elastic/Logstash/Kibana
- gitea: Gitea
- gitlab-jh: Gitlab-Jihu
- manager: Docker Manager
- mariadb: MariaDB latest
- services: Rustfs/RabbitMQ/Meilisearch