args:.Q.def[`name`port!("tick/tscript/02.q";9084);].Q.opt .z.x

/ remove this line when using in production
/ tscript/02.q:localhost:9084::
/ admin.bus:localhost:30031::
/ admin.rdb:localhost:30035::
/ admin.replay:localhost:30036::
/ admin.tick:localhost:30033::


{ if[not x=0; @[x;"exit 0";()]]; ;@[value;"\\p 9084";()];;@[value;"\\p 9084";()] } @[hopen;`:localhost:9084;0];

.self.mode:`proc
.import.json:`tick_test1
`btick2Home setenv "./btick2Home"
\l qlib.q

.import.require`plant`pm2`qtx`remote`repository`dbmaint
.import.init[]
.bt.action[`.import.init]()!()


/ b) mkdir plant
/ b) touch plant/tick_test.json
/ .repository.createLib[`tick_test;`tick_test1]

.dbmaint.rm"data1"

all `btick2`qtick in distinct exec repo from .import.summary[] / ensure that all repo are present

(::).self.arg:(.pm2.config`default),``env`cmd`proc!({};`;`info;`all)
(::).self.arg:update jfile:`$.bt.print[":%",string[ .self.arg`repo],"%/plant/%plant%.json"] (.self.arg,.import.repository.con) from .self.arg
(::).self.arg[`jobj]: .j.k "c"$read1 .self.arg`jfile
(::).self.arg[`root]:`$.import.repository.con .self.arg`repo
(::).self.dataDir:.plant.dataDir jobj:.self.arg `jobj
(::).self.process:.plant.process .self.arg

(::).self.schema:.plant.schema .self.arg

(::)arg0:.self.arg
.plant.schema:{[arg0]
 global:.json.k (jobj:arg0`jobj)`global;
 env0:raze{[global;x] (1#x`k)!enlist .json.k .j.k .bt.print[ .j.j x`v] global x`k }[global;]@' {([]k:key x;v:value x)} `global _ jobj;
 (::)allEnv:.util.ctablen[3] env0
 schemas:update sym:{ x[0],2_x }@'sym from select from allEnv where sym[;1]=`schema;

schemas

@'[schemas;`v;]{x}
{(),x[`v]}@'schemas

 schemas:`env`tname`col`cval!/:schemas[`sym]{x,enlist y}'schemas[`v];
 schemas:update cval:`${"," vs x}@'cval from schemas where col=`column;
 default:select env,tname,col:`ocolumn,cval:cval from schemas where col=`column;
 default:default,select env,tname,col:`rattr,cval:{count[x]#"*"}@'cval from schemas where col=`column;
 default:default,select env,tname,col:`hattr,cval:{count[x]#"*"}@'cval from schemas where col=`column;
 default:default,select env,tname,col:`upd,cval:count[i]#enlist (::) from schemas where col=`column;
 default:default,select env,tname,col:`addTime,cval:0b from schemas where col=`column;
 default:default,ungroup select env,tname,col:count[i]#enlist `tick`rdb`hdb`replay,cval:count[i]#enlist `default from schemas where col=`column;
 schemas:select from (default,schemas) where ({x=last x};i) fby ([]env;tname;col);
 schemas:.tidyq.dcast[schemas;"env,tname";"%col% ~~ cval"];
 fnc:{[mode;env;x] @[x;;:;.Q.dd[env]mode] where `default=x:(),x};
 update tick:fnc'[`tick;env;tick],rdb:fnc'[`rdb;env;rdb],hdb:fnc'[`hdb;env;hdb],replay:fnc'[`replay;env;replay] from schemas
 }

(::)r:.bt.action[`.pm2.action] .self.arg
/ (::)r:.bt.action[`.pm2.action] update cmd:`sbl from .self.arg
(::)process:r`process 

.remote.add allProc:select uid:luid,host,port,user:`,passwd:count[i]#enlist"" from process

/ .plant.cFile .self.arg

(::)r:.bt.action[`.pm2.action] update cmd:`start from .self.arg
/ (::)r:.bt.action[`.pm2.action] update cmd:`sbl,path:`$"C:\\edev\\private_projects" from .self.arg
(::)r:.bt.action[`.pm2.action] update cmd:`stop from .self.arg

if[not ()~key `:data1;"b" "rm -rf data1"];

(::).f.proc:allProc`uid

/ check for logFiles
f) count select from .bt.history where (not null error) or mode=`catch 
f) count select from .import.module0.con where not null error

(::).f.proc:`admin.tick
(::)get L:"f" ".tick.L"
.remote.fduplicate[`admin.tick]"upd"
upd[`trade] (.z.P;`hsi;19000f;200i)
upd[`trade] `time`sym`prx`qty!(.z.P;`hsi;19001f;200i)
upd[`trade] enlist `time`sym`prx`qty!(.z.P;`hsi;19002f;200i)
get L

(::).f.proc:`admin.rdb
f) tables[]!{count get x}@'tables[]
f) trade
f) select by sym from heartbeat

(::).f.proc:`admin.replay
f) .tick.files

(::).f.proc:`admin.tick
f) system"t 0"
f) .z.ts `.tick.stream.cLogFile
f).z.ts[]
(::)date:"f" ".tick.d"

(::).f.proc:`admin.replay
f) .tick.files

(::)staging:"f" ".tick.staging"

select from .Q.dd[staging;date,`heartbeat]
select from .Q.dd[staging;date,`trade]
select from .Q.dd[staging;date,`berror]

upd[`trade] (.z.P;`hsi;19000f;200i)
upd[`trade] `time`sym`prx`qty!(.z.P;`hsi;19001f;200i)
upd[`trade] enlist `time`sym`prx`qty!(.z.P;`hsi;19002f;200i)
(::).f.proc:`admin.tick
(::)get L:"f" ".tick.L"
f) .z.ts `.tick.stream.cLogFile
f).z.ts[]

(::).f.proc:`admin.replay
f) .tick.files

select from .Q.dd[staging;date,`heartbeat]
select from .Q.dd[staging;date,`trade]
select from .Q.dd[staging;date,`berror]

(::).f.proc:`admin.tick

f) .z.ts `.tick.stream.eod
f) .z.ts[]
f).tick.d
f).tick.logFiles
f).tick.L


(::).f.proc:`admin.cdb
f) tables[]
f) select from trade


/
