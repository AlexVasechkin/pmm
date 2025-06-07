# Дашборд для мониторинга СУБД на базе Percona Monitoring and Management

Данная сборка может выполнять мониторинг самых популярных СУБД:

- MySQL
- PostgreSQL
- ClickHouse
- MongoDB
  etc.

## Состав сборки

Сборка состоит из двух компонент:

1. PMM-Server. Здесь сохраняются данные и хостится Grafana Dashboard
2. PMM-Client. Клиент предоставляет набор утилит и экспортет метрик из целевых СУБД на PMM-Server

## Последовательность подключения

1. Создать внешнюю docker сеть:

```bash
docker network create pmm-network
```

2. Необходимо запустить docker-compose.yaml. Запустить PMM-Client и PMM-Server
3. Открыть Dashboard и на этапе первого входа сменить стандартный пароль. localhost:3080. логин пароль - admin:admin
4. Подключиться к оболочке контейнера pmm-client:

```bash
docker exec -it mon_pmm-client /bin/bash
```

5. выполнить регистрацию клиента на pmm-сервере (потребуется логин и пароль от админ панели grafana):

```bash
pmm-admin config --server-insecure-tls --server-url=https://admin:<пароль>@mon_pmm-server:443
```

6. Добавить контейнер целевой СУБД. Необходимо добавить контейнер СУБД в `pmm-network`, чтобы `pmm-client` мог получить у нему доступ. Пример конфигурации в `./database/docker-compose.yaml`

7. Создать пользователя СУБД. Примеры в `mysql_user.sql` и `postgres_user.sql`.

8. Как и в п.4 необходимо внутри контейнера `mon_pmm-client` подключить целевую СУБД:

```bash
pmm-admin add mysql <имя сервера СУБД для отображения в Grafana> <db_host>:<db_port> \
 --username=<db_user, например pmm> \
 --password=<db_password> \
 --query-source=perfschema

pmm-admin add postgresql <имя сервера СУБД для отображения в Grafana> <db_host>:<db_port> \
 --username=<db_user, например pmm> \
 --password=<db_password>
```

### Важно

пользователь бд, под которым выполняется подключение должен иметь привилегии SELECT, PROCESS, REPLICATION CLIENT, RELOAD и BACKUP_ADMIN.
На local окружении можно подключить под root.
На prod необходимо создать пользователя и дать ему привилегии. Пример запросов на создание и выдачу привилегий в файле `./create_pmm_user.sql`
