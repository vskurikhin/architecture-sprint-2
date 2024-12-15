# Проектная работа 2
## ЗАДАНИЕ 1 Планирование
### [«Первый вариант схемы»](./task1-planning-step1.drawio.pdf)
### [«Второй вариант схемы»](./task1-planning-step2.drawio.pdf)
### [«Третий вариант схемы»](./task1-planning-step3.drawio.pdf)
### [«Четвёртый вариант схемы»](./task1-planning-step4.drawio.pdf)
### [«Пятый вариант схемы»](./task1-planning-step5.drawio.pdf)

## ЗАДАНИЕ 2 Шардирование
В каталоге mongo-sharding сконфигурировано шардирование в docker-compose.yaml
и атоматизированны настройки в init.sh.
1. Создан сервер конфигурации со статическим ip 173.17.0.10 и портом 27017.
2. Запущены в режиме шардинга shard1-replica1 (ip 173.17.1.1 и порт 27011) и shard2-replica1 (ip 173.17.2.1 и порт 27021).
3. Создан инстанс в режиме роутера со статическим ip 173.17.0.7 и портом 27017.
4. Сконфигурированно приложение pymongo-api.

## ЗАДАНИЕ 3 Репликация
1. Создан сервер конфигурации со статическим ip 173.17.0.10 и портом 27017.
2. Запущены в режиме шардинга три реплики shard1-replica1 (ip 173.17.1.1 и порт 27011), shard1-replica2 (ip 173.17.1.2, порт 27012) и shard1-replica3 (ip 173.17.1.3, порт 27013).
3. Запущены в режиме шардинга три реплики shard2-replica1 (ip 173.17.2.1 и порт 27021), shard2-replica2 (ip 173.17.2.2, порт 27022) и shard2-replica3 (ip 173.17.2.3, порт 27023).
4. Создан инстанс в режиме роутера со статическим ip 173.17.0.7 и портом 27017.
5. Сконфигурированно приложение pymongo-api.

## ЗАДАНИЕ 4 Кэширование
В каталоге mongo-sharding сконфигурировано шардирование в docker-compose.yaml
и атоматизированны настройки в init.sh.
1. Создан сервер конфигурации со статическим ip 173.17.0.10 и портом 27017.
2. Запущены в режиме шардинга три реплики shard1-replica1 (ip 173.17.1.1 и порт 27011), shard1-replica2 (ip 173.17.1.2, порт 27012) и shard1-replica3 (ip 173.17.1.3, порт 27013).
3. Запущены в режиме шардинга три реплики shard2-replica1 (ip 173.17.2.1 и порт 27021), shard2-replica2 (ip 173.17.2.2, порт 27022) и shard2-replica3 (ip 173.17.2.3, порт 27023).
4. Создан инстанс в режиме роутера со статическим ip 173.17.0.7 и портом 27017.
5. Включено кэширование.
6. Сконфигурировано приложение pymongo-api.


PS Поправлен Docker файл. Так как приложение запускалось с ошибкой:
````
pymongo-api  | Traceback (most recent call last):
pymongo-api  |   File "/usr/local/bin/uvicorn", line 8, in <module>
pymongo-api  |     sys.exit(main())
pymongo-api  |              ^^^^^^
pymongo-api  |   File "/usr/local/lib/python3.12/site-packages/click/core.py", line 1157, in __call__
pymongo-api  |     return self.main(*args, **kwargs)
pymongo-api  |            ^^^^^^^^^^^^^^^^^^^^^^^^^^
pymongo-api  |   File "/usr/local/lib/python3.12/site-packages/click/core.py", line 1078, in main
pymongo-api  |     rv = self.invoke(ctx)
pymongo-api  |          ^^^^^^^^^^^^^^^^
pymongo-api  |   File "/usr/local/lib/python3.12/site-packages/click/core.py", line 1434, in invoke
pymongo-api  |     return ctx.invoke(self.callback, **ctx.params)
pymongo-api  |            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pymongo-api  |   File "/usr/local/lib/python3.12/site-packages/click/core.py", line 783, in invoke
pymongo-api  |     return __callback(*args, **kwargs)
pymongo-api  |            ^^^^^^^^^^^^^^^^^^^^^^^^^^^
pymongo-api  |   File "/usr/local/lib/python3.12/site-packages/uvicorn/main.py", line 409, in main
pymongo-api  |     run(
pymongo-api  |   File "/usr/local/lib/python3.12/site-packages/uvicorn/main.py", line 575, in run
pymongo-api  |     server.run()
pymongo-api  |   File "/usr/local/lib/python3.12/site-packages/uvicorn/server.py", line 65, in run
pymongo-api  |     return asyncio.run(self.serve(sockets=sockets))
pymongo-api  |            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pymongo-api  |   File "/usr/local/lib/python3.12/asyncio/runners.py", line 194, in run
pymongo-api  |     return runner.run(main)
pymongo-api  |            ^^^^^^^^^^^^^^^^
pymongo-api  |   File "/usr/local/lib/python3.12/asyncio/runners.py", line 118, in run
pymongo-api  |     return self._loop.run_until_complete(task)
pymongo-api  |            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pymongo-api  |   File "uvloop/loop.pyx", line 1517, in uvloop.loop.Loop.run_until_complete
pymongo-api  |   File "/usr/local/lib/python3.12/site-packages/uvicorn/server.py", line 69, in serve
pymongo-api  |     await self._serve(sockets)
pymongo-api  |   File "/usr/local/lib/python3.12/site-packages/uvicorn/server.py", line 76, in _serve
pymongo-api  |     config.load()
pymongo-api  |   File "/usr/local/lib/python3.12/site-packages/uvicorn/config.py", line 433, in load
pymongo-api  |     self.loaded_app = import_from_string(self.app)
pymongo-api  |                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pymongo-api  |   File "/usr/local/lib/python3.12/site-packages/uvicorn/importer.py", line 19, in import_from_string
pymongo-api  |     module = importlib.import_module(module_str)
pymongo-api  |              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pymongo-api  |   File "/usr/local/lib/python3.12/importlib/__init__.py", line 90, in import_module
pymongo-api  |     return _bootstrap._gcd_import(name[level:], package, level)
pymongo-api  |            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pymongo-api  |   File "<frozen importlib._bootstrap>", line 1387, in _gcd_import
pymongo-api  |   File "<frozen importlib._bootstrap>", line 1360, in _find_and_load
pymongo-api  |   File "<frozen importlib._bootstrap>", line 1331, in _find_and_load_unlocked
pymongo-api  |   File "<frozen importlib._bootstrap>", line 935, in _load_unlocked
pymongo-api  |   File "<frozen importlib._bootstrap_external>", line 994, in exec_module
pymongo-api  |   File "<frozen importlib._bootstrap>", line 488, in _call_with_frames_removed
pymongo-api  |   File "/app/app.py", line 7, in <module>
pymongo-api  |     import motor.motor_asyncio
pymongo-api  |   File "/usr/local/lib/python3.12/site-packages/motor/motor_asyncio.py", line 16, in <module>
pymongo-api  |     from . import core, motor_gridfs
pymongo-api  |   File "/usr/local/lib/python3.12/site-packages/motor/core.py", line 30, in <module>
pymongo-api  |     from pymongo.cursor import _QUERY_OPTIONS, Cursor, RawBatchCursor
pymongo-api  | ImportError: cannot import name '_QUERY_OPTIONS' from 'pymongo.cursor' (/usr/local/lib/python3.12/site-packages/pymongo/cursor.py)
````