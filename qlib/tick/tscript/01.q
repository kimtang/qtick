args:.Q.def[`name`port!("tick/tscript/01.q";9083);].Q.opt .z.x

/ remove this line when using in production
/ tscript/01.q:localhost:9083::
/ admin.bus:localhost:30021::
/ admin.cdb:localhost:30024::
/ admin.gw:localhost:30027::
/ admin.rdb:localhost:30025::
/ admin.replay:localhost:30026::
/ admin.tick:localhost:30023::


{ if[not x=0; @[x;"exit 0";()]]; ;@[value;"\\p 9083";()];;@[value;"\\p 9083";()] } @[hopen;`:localhost:9083;0];

.self.mode:`proc
.import.json:`tick_test
`btick2Home setenv "./btick2Home"
\l qlib.q

.import.require`plant`pm2`qtx`remote`repository
.import.init[]
.bt.action[`.import.init]()!()

/ b) mkdir plant
/ b) touch plant/tick_test.json
/ .repository.createLib[`tick_test;`tick_test1]

select by repo from .import.summary[] / ensure that all repo are present

(::).self.arg:(.pm2.config`default),``env`cmd`proc!({};`;`info;`all)
(::).self.arg:update jfile:`$.bt.print[":%",string[ .self.arg`repo],"%/plant/%plant%.json"] (.self.arg,.import.repository.con) from .self.arg
(::).self.arg[`jobj]: .j.k "c"$read1 .self.arg`jfile
(::).self.arg[`root]:`$.import.repository.con .self.arg`repo
(::).self.process:.plant.process .self.arg
(::).self.schema:.plant.schema .self.arg


(::)r:.bt.action[`.pm2.action] .self.arg
(::)r:.bt.action[`.pm2.action] update cmd:`sbl from .self.arg
(::)process:r`process 

.remote.add allProc:select uid:luid,host,port,user:`,passwd:count[i]#enlist"" from process

/ .plant.cFile .self.arg

(::)r:.bt.action[`.pm2.action] update cmd:`stop from .self.arg
(::)r:.bt.action[`.pm2.action] update proc:`bus,cmd:`start from .self.arg
(::)r:.bt.action[`.pm2.action] update proc:`tick, cmd:`start from .self.arg

(::)r:.bt.action[`.pm2.action] update proc:`tick, cmd:`stop from .self.arg

b) rm -rf data

.f.proc:`admin.tick

/ check for logFiles
f) count select from .bt.history where (not null error) or mode=`catch 
f) count select from .import.module0.con where not null error
f) .tick.schemas
f) .tick.nLogFile
f) .tick.logFiles
f) .tick.con
f) .tick.L
(::)L:"f" ".tick.L"
get L
.remote.fduplicate[`admin.tick]"upd"
upd[`trade] (.z.P;`hsi;19000f;200i)
get L
f) .tick.i
f) .tick.j

upd[`trade] `time`sym`prx`qty!(.z.P;`hsi;19000f;200i)
get L
f) .tick.i
f) .tick.j

upd[`trade] enlist `time`sym`prx`qty!(.z.P;`hsi;19000f;200i)
get L
f) .tick.i
f) .tick.j


(::)r:.bt.action[`.pm2.action] update proc:`rdb, cmd:`start from .self.arg
(::)r:.bt.action[`.pm2.action] update proc:`rdb, cmd:`stop from .self.arg

.f.proc:`admin.tick
f).tick.con


.f.proc:`admin.rdb
f) count select from .bt.history where (not null error) or mode=`catch 
f) count select from .import.module0.con where not null error
f) tables[]!{count get x}@'tables[]
f) trade
f) select by sym from heartbeat


(::)r:.bt.action[`.pm2.action] update proc:`rdb,cmd:`stop from .self.arg

.f.proc:`admin.tick
f).tick.con

(::)r:.bt.action[`.pm2.action] update proc:`rdb,cmd:`start from .self.arg

.f.proc:`admin.tick
f).tick.con


.f.proc:`admin.rdb
f) tables[]!{count get x}@'tables[]

