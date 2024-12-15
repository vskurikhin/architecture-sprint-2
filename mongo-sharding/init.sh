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
