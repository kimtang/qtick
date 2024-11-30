d)lib qtick.heartbeat.server 
 Library for working with the lib tick
 q).import.module`heartbeat.server 
 q).import.module`qtick.heartbeat.server
 q).import.module"%qtick%/qlib/heartbeat/server.q"

.heartbeat.sendTime:`second$2


.bt.add[`.bus.client.con.success`.bus.server.init;`.heartbeat.init]{
 .heartbeat.proc:.self.proc;
 }

.bt.addDelay[`.heartbeat.sendHeartbeat]{`tipe`time!(`in;.heartbeat.sendTime)}
.bt.add[`.heartbeat.init`.heartbeat.sendHeartbeat;`.heartbeat.sendHeartbeat]{
 .bt.md[`payload] enlist (`time`sym`pid!(.z.P;.heartbeat.proc`uid;.z.i)),.Q.w[]
 }

.bt.add[`.heartbeat.sendHeartbeat;`.heartbeat.receiveHeartBeat]{[payload] upd[`heartbeat] raze payload }


/