
.import.require`hopen

d)lib qtick.bus.client 
 Library for working with the lib bus
 q).import.module`bus 
 q).import.module`bus.client
 q).import.module"%qtick%/qlib/bus/client.q"

.bus.tcon:enlist`topic`payload!(`;{})
.bus.topic:1#`

.bt.addOnlyBehaviour[`.action.init]`.hopen.init;

.bt.add[`.hopen.init;`.bus.client.init]{
 .bus.topic:(distinct (exec sym from .bt.repository) ,distinct raze exec (trigger,sym) from .bt.behaviours) except `;	
 .bus.con:first select uid,host,port,user:`,passwd:count[i]#enlist"",mode:`server,hdl:0ni from .self.process where `bus.server in/:lib,env=.self.proc`env;
 .hopen.add@' enlist .bus.con;
 } 

.bt.addIff[`.bus.client.con.success]{[result] 0<count select from result where uid in (exec uid from .bus.con) }
.bt.add[`.hopen.success;`.bus.client.con.success]{[result]
 update hdl:result[0]`hdl from `.bus.con; 
 neg[.bus.con`hdl] (".bt.action";`.bus.server.con.handshake;.self.proc,.bt.md[`topic].bus.topic);
 } 

.bt.addIff[`.bus.pc]{[zw] zw = .bus.con`hdl}
.bt.add[`.hopen.pc;`.bus.pc]{[zw] update hdl:0ni from `.bus.con;}

.bt.addDelay[`.bus.loop]{`tipe`time!(`in;00:00:00.5)}
.bt.add[`.bus.client.init`.bus.loop;`.bus.loop]{}

.bt.addIff[`.bus.publishBulk]{(not null .bus.con`hdl) and not 1=count .bus.tcon }
.bt.add[`.bus.loop;`.bus.publishBulk]{
 tcon:select from .bus.tcon where not null topic;
 delete from `.bus.tcon where not null topic;
 neg[.bus.con.hdl] (".bt.action";`.bus.receiveBulk;.bt.md[`tcon] tcon);	
 }

.bt.add[`;`.bus.sendTweet]{[allData] `.bus.tcon insert enlist `topic`payload#allData;}


.bt.add[`;`.bus.receiveTweet]{[tcon] { .bt.action[x`topic] x }@'0!`topic xgroup tcon;}

/

x:first 0!`topic xgroup tcon

x`topic
x