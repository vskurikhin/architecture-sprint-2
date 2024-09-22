# Проектная работа 2
## ЗАДАНИЕ 4 Кэширование
### [«Третий вариант схемы»](./task1-planning-step3.drawio.pdf)
В каталоге mongo-sharding сконфигурировано шардирование в docker-compose.yaml
и атоматизированны настройки в init.sh.
1. Создан сервер конфигурации со статическим ip 173.17.0.10 и портом 27017.
2. Запущены в режиме шардинга три реплики shard1-replica1 (ip 173.17.1.1 и порт 27011), shard1-replica2 (ip 173.17.1.2, порт 27012) и shard1-replica3 (ip 173.17.1.3, порт 27013).
3. Запущены в режиме шардинга три реплики shard2-replica1 (ip 173.17.2.1 и порт 27021), shard2-replica2 (ip 173.17.2.2, порт 27022) и shard2-replica3 (ip 173.17.2.3, порт 27023).
4. Создан инстанс в режиме роутера со статическим ip 173.17.0.7 и портом 27017.
5. Включено кэширование.
6. Сконфигурировано приложение pymongo-api.
### Запуск
Запуск: ``docker compose up -d``
а так же
``init.sh``
### Результат, первые 3 запуска:
````
% time curl -v http://localhost:8080/
* Host localhost:8080 was resolved.
* IPv6: ::1
* IPv4: 127.0.0.1
*   Trying [::1]:8080...
* Connected to localhost (::1) port 8080
> GET / HTTP/1.1
> Host: localhost:8080
> User-Agent: curl/8.6.0
> Accept: */*
>
< HTTP/1.1 200 OK
< date: Sun, 22 Sep 2024 14:22:11 GMT
< server: uvicorn
< content-length: 558
< content-type: application/json
< x-api-request-id: ba86a37b-da99-402f-8612-0d10d321ecc1
<
* Connection #0 to host localhost left intact
{"mongo_topology_type":"Sharded","mongo_replicaset_name":null,"mongo_db":"somedb","read_preference":"Primary()","mongo_nodes":[["mongos_router",27020]],"mongo_primary_host":null,"mongo_secondary_hosts":[],"mongo_address":["mongos_router",27020],"mongo_is_primary":true,"mongo_is_mongos":true,"collections":{"helloDoc":{"documents_count":1000}},"shards":{"shard1":"shard1/shard1-replica1:27011,shard1-replica2:27012,shard1-replica3:27013","shard2":"shard2/shard2-replica1:27021,shard2-replica2:27022,shard2-replica3:27023"},"cache_enabled":true,"status":"OK"}
curl -v http://localhost:8080/  0,00s user 0,01s system 18% cpu 0,101 total
````
````
% time curl -v http://localhost:8080/
* Host localhost:8080 was resolved.
* IPv6: ::1
* IPv4: 127.0.0.1
*   Trying [::1]:8080...
* Connected to localhost (::1) port 8080
> GET / HTTP/1.1
> Host: localhost:8080
> User-Agent: curl/8.6.0
> Accept: */*
>
< HTTP/1.1 200 OK
< date: Sun, 22 Sep 2024 14:22:25 GMT
< server: uvicorn
< content-length: 558
< content-type: application/json
< x-api-request-id: 1e9ad79f-396f-418c-844a-f208915ef535
<
* Connection #0 to host localhost left intact
{"mongo_topology_type":"Sharded","mongo_replicaset_name":null,"mongo_db":"somedb","read_preference":"Primary()","mongo_nodes":[["mongos_router",27020]],"mongo_primary_host":null,"mongo_secondary_hosts":[],"mongo_address":["mongos_router",27020],"mongo_is_primary":true,"mongo_is_mongos":true,"collections":{"helloDoc":{"documents_count":1000}},"shards":{"shard1":"shard1/shard1-replica1:27011,shard1-replica2:27012,shard1-replica3:27013","shard2":"shard2/shard2-replica1:27021,shard2-replica2:27022,shard2-replica3:27023"},"cache_enabled":true,"status":"OK"}
curl -v http://localhost:8080/  0,01s user 0,01s system 35% cpu 0,044 total
````
````
% time curl -v http://localhost:8080/
* Host localhost:8080 was resolved.
* IPv6: ::1
* IPv4: 127.0.0.1
*   Trying [::1]:8080...
* Connected to localhost (::1) port 8080
> GET / HTTP/1.1
> Host: localhost:8080
> User-Agent: curl/8.6.0
> Accept: */*
>
< HTTP/1.1 200 OK
< date: Sun, 22 Sep 2024 14:24:06 GMT
< server: uvicorn
< content-length: 558
< content-type: application/json
< x-api-request-id: 3f6ad8fa-c07f-478e-97b8-a0b0d9ddce6b
<
* Connection #0 to host localhost left intact
{"mongo_topology_type":"Sharded","mongo_replicaset_name":null,"mongo_db":"somedb","read_preference":"Primary()","mongo_nodes":[["mongos_router",27020]],"mongo_primary_host":null,"mongo_secondary_hosts":[],"mongo_address":["mongos_router",27020],"mongo_is_primary":true,"mongo_is_mongos":true,"collections":{"helloDoc":{"documents_count":1000}},"shards":{"shard1":"shard1/shard1-replica1:27011,shard1-replica2:27012,shard1-replica3:27013","shard2":"shard2/shard2-replica1:27021,shard2-replica2:27022,shard2-replica3:27023"},"cache_enabled":true,"status":"OK"}curl -v http://localhost:8080/
0,01s user 0,01s system 24% cpu 0,069 total
````
