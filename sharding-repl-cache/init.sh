#!/usr/bin/env bash

docker exec -it configSrv mongosh --port 27017 <<EOF
rs.initiate(
  {
    _id : "config_server",
       configsvr: true,
    members: [
      { _id : 0, host : "configSrv:27017" }
    ]
  }
);
exit();
EOF

docker exec -it shard1-replica1 mongosh --port 27011 <<EOF
rs.initiate(
    {
      _id : "shard1",
      members: [
        { _id : 0, host : "shard1-replica1:27011" },
        { _id : 1, host : "shard1-replica2:27012" },
        { _id : 2, host : "shard1-replica3:27013" }
      ]
    }
);
exit();
EOF


docker exec -it shard2-replica1 mongosh --port 27021 <<EOF
rs.initiate(
    {
      _id : "shard2",
      members: [
        { _id : 255, host : "shard2-replica1:27021" },
        { _id : 254, host : "shard2-replica2:27022" },
        { _id : 253, host : "shard2-replica3:27023" }
      ]
    }
);
exit();
EOF

docker exec -it mongos_router mongosh --port 27020 <<EOF
sh.addShard( "shard1/shard1-replica1:27011");
sh.addShard( "shard2/shard2-replica1:27021");

sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } )

use somedb

for(var i = 0; i < 1000; i++) db.helloDoc.insert({age:i, name:"ly"+i})

db.helloDoc.countDocuments()
exit();
EOF

docker exec -it redis-1
echo "yes" | redis-cli --cluster create   173.17.0.2:6379   173.17.0.3:6379   173.17.0.4:6379   173.17.0.5:6379   173.17.0.6:6379   173.17.0.8:6379   --cluster-replicas 1
