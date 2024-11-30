/ default.futubull.qdata.admin.rdb:localhost:32005::


d)lib qtick.tick.sub 
 Library for working with the lib tick
 q).import.module`tick.sub 
 q).import.module`qtick.tick.sub
 q).import.module"%qtick%/qlib/tick/sub.q"


upd:{[tname;data]
 tname:.tick.t tname;
 data:.tick.addCols[tname;data];
 tname insert `date xcols update date:.z.d from .tick.u[ tname ] data;
 }

.bt.add[`.action.init;`.tick.init.schemas]{[proc0;schema;process]
 s0:select from schema where (.Q.dd . proc0`env`proc) in/:rdb;
 s1:select env,tname,tick from s0;
 s2:update tick:{[env0;x] first (x where .Q.dd[env0;`tick] = x),x }[proc0`env]@'tick from s1;
 .tick.con:select uid,luid,env,proc,host:host,user:proc0`uid,port,passwd:count[i]#enlist"",hdl:0ni,mode:`init,sub:0b from process where luid in distinct raze exec tick from s2;
 .tick.schemas:select from s0;
 .tick.process:process;
 .tick.c:exec tname!column from .tick.schemas;
 .tick.t:exec tname!tname from .tick.schemas; 
 .tick.u: (enlist[`]!enlist {[x;y]}), exec tname!upd from .tick.schemas;
 .tick.oc: exec tname!ocolumn from .tick.schemas;   
 .tick.a:exec tname!rattr from .tick.schemas;
 .bt.execute[{[tname;column;tipe] tname set `date xcols update date:.z.D from flip column!tipe$\:()}]@'.tick.schemas;  
 .bt.action[`.hopen.add] @'`uid`host`port`user`passwd#.tick.con;
 }

.bt.add[`;`.tick.add.schema]{[allData]
 a:cols [.tick.schemas]#enlist allData;
 delete from `.tick.schemas where env=allData`env,tname=allData`tname;
 `.tick.schemas insert a;
 if[not (allData`tname) in tables[] ;.bt.execute[{[tname;column;tipe] tname set `date xcols update date:.z.D from flip column!tipe$\:()}]@'a;];
 tick0:first (tick0 where .Q.dd[allData`env;`tick] = tick0),tick0:allData`tick;
 t:first select uid,luid,env,proc,host:host,user:uid,port,passwd:count[i]#enlist"",hdl:0ni,mode:`add,sub:1b from .tick.process where luid = tick0;
 if[ t[`luid] in .tick.con`luid;
  o:first select from .tick.con where uid = t`uid;
  con:select env,proc:.self.proc`proc,tname from .tick.schemas where tname=allData`tname;
  neg[o`hdl] (`.bt.action;`.tick.sub;`uid`con!(o`uid;con));
  :()
  ];
 `.tick.con insert enlist t;
 .bt.action[`.hopen.add] @'enlist`uid`host`port`user`passwd#t; 
 }

.bt.addIff[`.tick.success]{[result] 0< count select from result where uid in .tick.con`uid  }
.bt.add[`.hopen.success;`.tick.success]{[result] 
 result:select from result where uid in .tick.con`uid;
 .tick.con:.tick.con lj 1!result:select uid,hdl from result;
 .bt.md[`result] result lj 1!select uid,mode from .tick.con
 }

.bt.addIff[`.tick.sub.add]{[result] 0 = count select from result where mode=`init,null hdl  }
.bt.add[`.tick.success;`.tick.sub.add]{[result]
  o:first result;
  con:select env,proc:o[`uid],tname from .tick.schemas;
  neg[o`hdl] (`.bt.action;`.tick.sub;`uid`con!(o`uid;con));
 }


.bt.addIff[`.tick.init.logFiles]{[result] 0 = count select from .tick.con where mode=`init,null hdl  }
.bt.add[`.tick.success;`.tick.init.logFiles]{[result]
 logFiles:([]file:1#`dontcare;hdl:0ni;replayed:1b),raze{([]file:x ".tick.logFiles";hdl:x;replayed:0b)}@'exec hdl from .tick.con where mode=`init;
 / logFiles:ungroup update file: {`dontcare,x ".tick.logFiles"}@' hdl,replayed:0b from result;
 / logFiles:update replayed:1b from logFiles where file = `dontcare;
 hdls:select from logFiles where ({min x};replayed) fby hdl;
 logFiles:delete from logFiles where ({min x};replayed) fby hdl; 
 `logFiles`result`hdls!(logFiles;result;hdls)   
 }


.bt.addIff[`.tick.replay.logFiles]{[logFiles] 1 <= count select from logFiles where not replayed }
.bt.add[`.tick.init.logFiles`.tick.replay.logFiles;`.tick.replay.logFiles]{[proc0;logFiles;result] 
 {@[-11!;x;()]}@'exec file from logFiles where not replayed;
 logFiles:update replayed:1b from logFiles;
 nlogFiles:([]file:1#`dontcare;hdl:0ni;replayed:1b),raze{([]file:x ".tick.logFiles";hdl:x;replayed:0b)}@'exec hdl from .tick.con where mode=`init;
 logFiles:logFiles,select from nlogFiles where not file in logFiles`file; 
 hdls:select from logFiles where ({min x};replayed) fby hdl;
 logFiles:delete from logFiles where ({min x};replayed) fby hdl; 
 `logFiles`hdls!(logFiles;hdls)
 }

.bt.addIff[`.tick.sub]{[logFiles] (0=count logFiles) or not 1 <= count select from logFiles where not replayed }
.bt.add[`.tick.replay.logFiles`.tick.init.logFiles;`.tick.sub]{[proc0;hdls;logFiles]
 / hdls:exec distinct hdl from hdls;
 {-11!x`j`L;}@'{[proc0;x]
   luid0:first exec luid from .tick.con where hdl = x;
   con:select env,proc:proc0`proc,tname from .tick.schemas where luid0 in\:tick ;
   r:x (`.bt.action;`.tick.sub;`uid`con!(proc0`uid;con));
   r
   }[proc0]@'hdls:exec hdl from .tick.con where mode=`init,not sub,not null hdl; 
 update sub:1b from `.tick.con where hdl in hdls;
 }

.bt.add[`.hopen.pc;`.tick.pc]{[zw] update hdl:0ni,sub:0b from `.tick.con where zw = hdl;  }

.bt.addIff[`.tick.eod]{[payload]payload:raze payload;payload[`uid] in .tick.con`uid }
.bt.add[`;`.tick.eod]{[payload]payload:raze payload;
 tnames:exec tname from .tick.schemas where payload[`luid] in/:tick;
 {delete from x}@'tnames;
 }

/