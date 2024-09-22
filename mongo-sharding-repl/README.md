# Проектная работа 2
## ЗАДАНИЕ 3 Репликация
### [«Второй вариант схемы»](../mongo-sharding/task1-planning-step2.drawio.pdf)
В каталоге mongo-sharding сконфигурировано шардирование в docker-compose.yaml
и атоматизированны настройки в init.sh.
1. Создан сервер конфигурации со статическим ip 173.17.0.10 и портом 27017.
2. Запущены в режиме шардинга три реплики shard1-replica1 (ip 173.17.1.1 и порт 27011), shard1-replica2 (ip 173.17.1.2, порт 27012) и shard1-replica3 (ip 173.17.1.3, порт 27013).
3. Запущены в режиме шардинга три реплики shard2-replica1 (ip 173.17.2.1 и порт 27021), shard2-replica2 (ip 173.17.2.2, порт 27022) и shard2-replica3 (ip 173.17.2.3, порт 27023).
4. Создан инстанс в режиме роутера со статическим ip 173.17.0.7 и портом 27017.
5. Сконфигурировано приложение pymongo-api.
### Результат:
````
% curl http://localhost:8080/ | jq
{
  "mongo_topology_type": "Sharded",
  "mongo_replicaset_name": null,
  "mongo_db": "somedb",
  "read_preference": "Primary()",
  "mongo_nodes": [
    [
      "mongos_router",
      27020
    ]
  ],
  "mongo_primary_host": null,
  "mongo_secondary_hosts": [],
  "mongo_address": [
    "mongos_router",
    27020
  ],
  "mongo_is_primary": true,
  "mongo_is_mongos": true,
  "collections": {
    "helloDoc": {
      "documents_count": 1000
    }
  },
  "shards": {
    "shard1": "shard1/shard1-replica1:27011,shard1-replica2:27012,shard1-replica3:27013",
    "shard2": "shard2/shard2-replica1:27021,shard2-replica2:27022,shard2-replica3:27023"
  },
  "cache_enabled": false,
  "status": "OK"
}
````