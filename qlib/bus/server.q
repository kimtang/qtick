
.import.require`hopen;

d)lib qtick.bus.server 
 Library for working with the lib bus
 q).import.module`bus 
 q).import.module`bus.server
 q).import.module"%qtick%/qlib/bus/server.q"

.bt.addOnlyBehaviour[`.action.init]`.hopen.init;

.bus.server.summary:{}

d)fnc bus.bus.server.summary 
 Give a summary of this function
 q) .bus.server.summary[]

.bt.add[`.hopen.init;`.bus.server.init]{[process;proc0]
 .bus.proc:proc0;
 .bus.con:1!select uid,host,port,user:`,passwd:count[i]#enlist"",mode:`server,hdl:0ni,topic:count[i]#enlist 1#`all from process where `bus.server in/:lib,not env=proc0`env;
 .bus.con:.bus.con,1!select uid,host,port,user:`,passwd:count[i]#enlist"",mode:`client,hdl:0ni,topic:count[i]#enlist 0#` from process where `bus.client in/:lib,env=proc0`env;
 .bus.con:.bus.con,1!select uid,host,port,user:`,passwd:count[i]#enlist"",mode:`client,hdl:0i,topic:count[i]#enlist `all from enlist proc0;
 } 

.bt.add[`.bus.server.init;`.bus.server.init.con]{
 .hopen.add@' 0!select from .bus.con where mode=`server,null hdl;	
 }


.bt.addIff[`.bus.server.con.success]{[result] 0<count select from result where uid in (exec uid from .bus.con) }
.bt.add[`.hopen.success;`.bus.server.con.success]{[result]
 `.bus.con upsert 1!r:select uid,hdl from result where uid in (exec uid from .bus.con);
 { x (".bt.action";`.bus.server.con.handshake;.bus.proc,.bt.md[`topic]1#`all) }@'neg(r`hdl)
 }

.bt.addIff[`.bus.server.con.handshake]{[uid0] 0<count select from .bus.con where uid = uid0 }
.bt.add[`;`.bus.server.con.handshake]{[uid0;topic]
 `.bus.con upsert 1!result:([]uid:1#uid0;hdl:.z.w;topic:enlist topic);
 .bt.md[`result]result
 }

.bt.addIff[`.bus.pc]{[zw] zw in .bus.con`hdl}
.bt.add[`.hopen.pc;`.bus.pc]{[zw] update hdl:0ni from `.bus.con where hdl=zw;}

.bt.addOnlyBehaviour[`.bus.server.con.handshake]`.hopen.handshake;

.bt.add[`;`.bus.receiveBulk]{}

.bt.addIff[`.bus.receiveBulk.server]{ `server=(exec hdl!mode from .bus.con).z.w }
.bt.add[`.bus.receiveBulk;`.bus.receiveBulk.server]{[tcon]
 {[tcon;arg]  arg[`hdl]enlist[".bt.action";`.bus.receiveTweet;] (1#`tcon)!enlist select from tcon where topic in arg`topic }[tcon;]@'select hdl:neg hdl,topic from .bus.con where not null hdl,not mode=`server;
 }

.bt.addIff[`.bus.receiveBulk.client]{ `client=(exec hdl!mode from .bus.con).z.w }
.bt.add[`.bus.receiveBulk`.bus.sendTweet;`.bus.receiveBulk.client]{[tcon]
 tcon:update uid:(exec hdl!uid from .bus.con) .z.w,time:.z.P from tcon; 
 {[tcon;arg]  arg[`hdl]enlist[".bt.action";(`client`server!`.bus.receiveTweet`.bus.receiveBulk) arg`mode;](1#`tcon)!enlist select from tcon where (topic in arg`topic) or `all in arg`topic }[tcon;]@'select hdl:neg hdl,topic,mode from .bus.con where not hdl=.z.w, not null hdl; 
 }

.bt.add[`;`.bus.sendTweet]{[allData] .bt.md[`tcon] enlist `topic`payload#allData}

/ 