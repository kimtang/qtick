
/ default.futubull.qdata.admin.replay:localhost:32006::

d)lib qtick.tick.replay 
 Library for working with the lib tick
 q).import.module`tick.replay 
 q).import.module`qtick.tick.replay
 q).import.module"%qtick%/qlib/tick/replay.q"

/ 
 select from .bt.history where not null error
 select from .bt.history where action like ".tick*"
\


.tick.zd:17 2 6

/ `proc0`schema`process set' (.self.proc;.self.schema;.self.process)

.bt.add[`.action.init;`.tick.init.schemas]{[proc0;schema;process]
 s0:select from schema where (.Q.dd . proc0`env`proc) in/:replay;
 s1:select env,tname,tick from s0;
 s2:update tick:{[env0;x] first (x where .Q.dd[env0;`tick] = x),x }[proc0`env]@'tick from s1;
 .tick.staging:`$.bt.print[":%dataDir%/%env%/%proc%/staging"].self.proc;
 .tick.con:select uid,luid,env,proc,host:host,user:proc0`uid,port,passwd:count[i]#enlist"",hdl:0ni,mode:`init from process where luid in distinct raze exec tick from s2;
 .tick.schemas:select from s0;
 .tick.process:process;
 .tick.c:exec tname!column from .tick.schemas;
 .tick.t:exec tname!tname from .tick.schemas; 
 .tick.tipe: 2!ungroup select tname,column,tipe from .tick.schemas;
 .tick.hattr: 2!ungroup select tname,column,hattr from .tick.schemas;  
 .tick.u: (enlist[`]!enlist {[x;y]}), exec tname!upd from .tick.schemas;
 .tick.oc: exec tname!ocolumn from .tick.schemas;   
 .tick.a:exec tname!rattr from .tick.schemas;
 .bt.execute[{[tname;column;tipe] tname set flip column!tipe$\:()}]@'.tick.schemas;  
 .tick.files:flip`date`file`num`replay!();
 .tick.eod:flip `date`staging`tname`column`tipe`hattr`hdb`saved!"dsssccsb"$\:();
 .tick.symFile: `$.bt.print["%env%sym"] proc0;
 .tick.osymFile: `$.bt.print["o%env%sym"] proc0;
 }


.bt.add[`.tick.init.schemas;`.tick.cleanUp]{[proc0]
 if[()~`$.bt.print[":%dataDir%/%env%/%proc%/staging/%date%"] aData:proc0,.bt.md[`date] .z.D;:()];
 if[not ()~`$.bt.print[":%dataDir%/%env%/%proc%/staging/%date%.old"]aData;@[system;;()] .bt.print["rm -rf %dataDir%/%env%/%proc%/staging/%date%.old"]aData];
 @[system;;()] .bt.print["mv %dataDir%/%env%/%proc%/staging/%date% %dataDir%/%env%/%proc%/staging/%date%.old"] aData;
 }


/ .bt.add[`.bus.handshake;`.tick.init.schemas]{}
/ .bt.action[`.tick.waitForTick]()!()
/  select from .bt.history where action like ".tick*"
/ .bt.putArg 4226j

.bt.add[`.bus.client.con.success;`.tick.waitForTick]{ `topic`payload!(`.tick.askForLogs;.tick.con) } 

.bt.addOnlyBehaviour[`.tick.waitForTick]`.bus.sendTweet



.bt.addIff[`.tick.logFiles]{[payload]payload:raze payload ;payload[`uid] in .tick.con`uid }
.bt.add[`;`.tick.logFiles]{[payload] payload:raze payload;
 t:flip select date:payload[`d],file:payload[`logFiles] from ([]) ;
 t:update num:{"J"$last "." vs x}@'string file,replay:0b from t;
 .tick.files : `date`num xasc  0!(2!t) uj 2!.tick.files; 
 }

.bt.addDelay[`.tick.replay.loop]{`tipe`time!(`in;00:00:01)}
.bt.addIff[`.tick.replay.loop]{0<count select from .tick.files where not replay }
.bt.add[`.tick.logFiles`.tick.replay.loop;`.tick.replay.loop]{
 a:first select from .tick.files where not replay;
 update replay:1b from `.tick.files where file = a`file,date = a`date;
 a  
 }


.bt.add[`.tick.replay.loop;`.tick.replay.logFile]{[allData]
 -11!allData`file;
 / t:tables[] 0;
 {[a;t]
  cls:.tick.c t; 
  staging:`$.bt.print[":%dataDir%/%env%/%proc%/staging/%date%/%tname%"] a,.self.proc,.bt.md[`tname] t;
  {[t;cl;file] .[file;();,;t cl] }'[t;cls;staging .Q.dd/:cls];
  if[() ~ key .Q.dd[staging;`.d];.Q.dd[staging;`.d] set cls; ];
  ![t;();0b;0#`]; 
  }[allData]@'key .tick.t;	
 }

.bt.addIff[`.tick.eod]{[payload]payload:raze payload ;max .tick.con[`uid] = payload`uid }

.bt.add[`;`.tick.eod]{[payload]
 payload:raze payload ;
 .tick.eod:0#.tick.eod;
 t:update date:payload`d from ([]file:payload`logFiles);
 t:update num:{"J"$last "." vs x}@'string file,replay:0b from t;
 t:`date`num xasc  0!(2!t) uj 2!select from .tick.files where file in t`file;
 delete from `.tick.files where file in t`file; 
 .bt.action[`.tick.replay.logFile]@'{select from x where not replay}t;
 / hdbpath:`$.bt.print[":%data%/hdb"] .self.proc;
 s:([]date:payload`d;staging:enlist `$.bt.print[":%dataDir%/%env%/%proc%/staging/%d%"] payload,.self.proc);
 s:ungroup update tname: key@'staging from s;
 s:update staging:staging .Q.dd'tname  from s;
 s:ungroup update column:key@'staging from s;
 s:select from s where not column like "*#"; 
 s:update staging:staging .Q.dd'column from s;
 s:s lj .tick.tipe;
 s:s lj .tick.hattr;
 / {([]k:key x;v:value x)}.self.proc
 s:update hdb:{`$.bt.print[":%dataDir%/%env%/cdb/%date%/%tname%/%column%"] x,.self.proc}@'s from s;
 symFile:`$.bt.print[":%dataDir%/%env%/cdb/%symFile%"] .tick,.self.proc;
 (.tick`symFile`osymFile) set\: $[symFile~key symFile;get symFile; ()];
 {x set .tick.symFile?get x}@'exec staging from s where tipe="s";
 {x set {.tick.symFile?x}@'get x}@'exec staging from s where tipe="S";
 (`$.bt.print[":%dataDir%/%env%/archive/%d%/%symFile%"] .tick,payload,.self.proc) set get .tick.symFile;
 symFile set get .tick.symFile;
 .tick.eod:update saved:0b from s; 
 / {[s;t] .bt.md[`data] select from s where tname = t}[s]@'key .tick.t
 }



/ select from .bt.history where action like ".tick.stream*"

.bt.addDelay[`.tick.saveTbl]{`tipe`time!(`in;00:00:01)}

.bt.addIff[`.tick.saveTbl]{not 0=count select from .tick.eod where not saved}

.bt.add[`.tick.eod`.tick.saveTbl;`.tick.saveTbl]{
 t:first exec tname from .tick.eod where not saved;
 update saved:1b from `.tick.eod where tname = t;
 s:select from .tick.eod where tname=t;
 if[not 1=count a:select from s where hattr="p";{'`$"missing_p_",x}[t]];
 a:get first[ a]`staging;
 b:$[1=count b:select from s where hattr="S";get first[b]`staging;a];
 iorder:{exec ind from x} `a`b xasc update ind:i from ([]a;b);
 {[iorder;o]
 	data:get[o`staging] iorder;
 	if[o[`hattr] in "pg";data:(`$o[`hattr])#data];
 	(o[`hdb],.tick.zd) set data;
  }[iorder]@'s;

 dpath:.Q.dd[;`.d] -1_` vs s[ 0]`hdb;
 dpath set .tick.c t;
 / save down tbl
 }

.bt.addIff[`.tick.send.replay.eod]{0=count select from .tick.eod where not saved}
.bt.add[`.tick.saveTbl;`.tick.send.replay.eod]{
 `topic`payload!(`.replay.eod;.self.proc,.bt.md[`eod] .tick.eod)
 }

.bt.addOnlyBehaviour[`.tick.send.replay.eod]`.bus.sendTweet

upd:{[tname;data] 
 tname:.tick.t tname;
 data:.tick.addCols[tname;data];
 tname insert .tick.u[ tname ] data;
 }

/ 

select from .bt.history where not null error