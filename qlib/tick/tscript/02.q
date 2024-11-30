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

.import.require`plant`pm2`qtx`remote`repository
.import.init[]
.bt.action[`.import.init]()!()

/ b) mkdir plant
/ b) touch plant/tick_test.json
/ .repository.createLib[`tick_test;`tick_test1]

if[not ()~key `:data1;"b" "rm -rf data1"];
select by repo from .import.summary[] / ensure that all repo are present


(::).self.arg:(.pm2.config`default),``env`cmd`proc!({};`;`info;`all)
(::).self.arg:update jfile:`$.bt.print[":%",string[ .self.arg`repo],"%/plant/%plant%.json"] (.self.arg,.import.repository.con) from .self.arg
(::).self.arg[`jobj]: .j.k "c"$read1 .self.arg`jfile
(::).self.arg[`root]:`$.import.repository.con .self.arg`repo
(::).self.dataDir:.plant.dataDir .self.arg `jobj
(::).self.process:.plant.process .self.arg
(::).self.schema:.plant.schema .self.arg
(::)r:.bt.action[`.pm2.action] .self.arg
(::)r:.bt.action[`.pm2.action] update cmd:`sbl from .self.arg
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

(::)r:.bt.action[`.pm2.action] update proc:`replay,cmd:`start from .self.arg
process


(::).f.proc:`admin.rdb
f) {count get x}@'tables[]

(::).f.proc:`admin.replay
f) 


trade:enlist `time`sym`prx`qty!(.z.P;`hsi;19002f;200i)

(::)trade:.Q.en[`:dontcare]trade

`:dontcare/2021.01.01/trade/ set trade
`:dontcare/2021.01.02/trade/ set trade

`:dontcare/1/trade/ set trade
`:dontcare/2/trade/ set trade

\l .

select from trade where int = 1 