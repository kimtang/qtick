
/ default.futubull.qdata.admin.tick:localhost:32003::

d)lib qtick.tick.stream 
 Library for working with the lib tick
 q).import.module`tick.stream 
 q).import.module`qtick.tick.stream
 q).import.module"%qtick%/qlib/tick/stream.q"

.bt.add[`.action.init;`.tick.init.schemas]{[proc0;schema]
 .tick.eodTime:23:59:59.999;
 s:select from schema where (.Q.dd . proc0`env`proc) in/:tick;	
 .tick.schemas:s;
 .tick.c:exec tname!column from .tick.schemas;
 .tick.t:exec tname from .tick.schemas;
 .tick.a:exec tname!addTime from .tick.schemas;
 .tick.u: (enlist[`]!enlist {[x;y]}), exec tname!upd from .tick.schemas;
 .tick.oc: exec tname!ocolumn from .tick.schemas;    
 .tick.con:enlist select env:`,proc:`,tname:`,sel:{},hdl:0ni from ([]);
 }

.bt.add[`;`.tick.add.schema]{[allData]
 a:cols [.tick.schemas]#enlist allData;
 delete from `.tick.schemas where env=allData`env,tname=allData`tname;
 `.tick.schemas insert a;
 .tick.c:exec tname!column from .tick.schemas;
 .tick.t:exec tname from .tick.schemas;
 .tick.a:exec tname!addTime from .tick.schemas;
 .tick.u: (enlist[`]!enlist {[x;y]}), exec tname!upd from .tick.schemas;
 .tick.oc: exec tname!ocolumn from .tick.schemas;     
 }


.bt.add[`.tick.init.schemas;`.tick.stream.iLogFile]{[proc0]
 .tick.d:.z.D;
 folder:`$.bt.print[":%dataDir%/%env%/%proc%"] proc0;
 t:([]folder;file:key folder);
 t:update date:"D"$ -2_/:string file from t;
 t:update nLogFile:"J"$ 11_/:string file from t;
 t:update path:.Q.dd'[folder;file] from t ;
 t:select from t where date = .tick.d;
 .tick.nLogFile:$[0=count t;0;1+max t`nLogFile ]; 
 .tick.logFiles:$[0=count t;`$();t`path ];
 .tick.L: `$.bt.print[":%dataDir%/%env%/%proc%/%d%.%nLogFile%"] .tick,proc0;
 .[.tick.L;();:;()];
 .tick.l:hopen .tick.L;
 .tick.i:0;
 .tick.j:0;
 }

.bt.addDelay[`.tick.stream.cLogFile]{`tipe`time!(`in;00:05)}
.bt.add[`.tick.stream.iLogFile`.tick.stream.cLogFile;`.tick.stream.cLogFile]{[proc0]
 hclose .tick.l;
 .tick.nLogFile:.tick.nLogFile + 1;	
 .tick.logFiles:.tick.logFiles,.tick.L;
 .tick.L: `$.bt.print[":%dataDir%/%env%/%proc%/%d%.%nLogFile%"] .tick,proc0;
 .[.tick.L;();:;()];
 .tick.l:hopen .tick.L;
 .tick.i:0;
 .tick.j:0;
 :`topic`payload!(`.tick.logFiles;`uid`logFiles`d # .tick,proc0)
 }

.bt.addOnlyBehaviour[`.tick.stream.cLogFile]`.bus.sendTweet

.bt.addDelay[`.tick.stream.eod]{`tipe`time!(`at;.tick.d + .tick.eodTime )}
.bt.add[`.tick.stream.iLogFile`.tick.stream.eod;`.tick.stream.eod]{[proc0]
 tmp:.tick;
 .tick.d:.tick.d+1;
 hclose .tick.l;
 .tick.nLogFile:0;	
 .tick.logFiles:`$();
 .tick.L: `$.bt.print[":%dataDir%/%env%/%proc%/%d%.%nLogFile%"] .tick,proc0;
 .[.tick.L;();:;()];
 .tick.l:hopen .tick.L;
 .tick.i:0;
 .tick.j:0;
 :`topic`payload!(`.tick.eod; proc0,`d`logFiles#tmp )
 }

.bt.addOnlyBehaviour[`.tick.stream.eod]`.bus.sendTweet

.bt.add[`;`.tick.sub]{[uid;con]
 if[not `sel in cols con;con:update sel:count[i]#enlist (::) from con];
 `.tick.con insert cols[.tick.con]#update hdl:.z.w from con ;
 .tick.con:select from .tick.con where ({x=last x};i) fby ([]tname;hdl);
 `L`i`j#.tick
 }


.bt.add[`.hopen.pc;`.tick.pc]{[zw] delete from `.tick.con where zw = hdl;}

upd:{[tname;data] .bt.action[`.tick.upd] `tname`data!( $[10h = type tname;`$;(::)] tname;data); }


.bt.addIff[`.tick.askForLogs]{[payload] .self.proc[`uid] in (raze payload)`uid}
.bt.add[`;`.tick.askForLogs]{`topic`payload!(`.tick.logFiles;`uid`logFiles`d # .tick,.self.proc)}

.bt.addOnlyBehaviour[`.tick.askForLogs]`.bus.sendTweet

/ 
