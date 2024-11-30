d)lib qtick.heartbeat.client 
 Library for working with the lib tick
 q).import.module`heartbeat.client 
 q).import.module`qtick.heartbeat.client
 q).import.module"%qtick%/qlib/heartbeat/client.q"


.heartbeat.sendTime:`second$2

.bt.add[`.bus.client.con.success`.bus.server.init;`.heartbeat.init]{
 .heartbeat.proc:.self.proc;
 }

.bt.addDelay[`.heartbeat.sendHeartbeat]{`tipe`time!(`in;.heartbeat.sendTime)}
.bt.add[`.heartbeat.init`.heartbeat.sendHeartbeat;`.heartbeat.sendHeartbeat]{
 `topic`payload!enlist[`.heartbeat.receiveHeartBeat;] (`time`sym`pid!(.z.P;.heartbeat.proc`uid;.z.i)),.Q.w[]
 }

.bt.addOnlyBehaviour[`.heartbeat.sendHeartbeat]`.bus.sendTweet 


/

select from .bt.history where action like ".bus*"