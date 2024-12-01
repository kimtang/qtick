args:.Q.def[`name`port!("tscript/01_test.q";9082);].Q.opt .z.x

/ remove this line when using in production
/ tscript/01_test.q:localhost:9082::
{ if[not x=0; @[x;"exit 0";()]]; ;@[value;"\\p 9082";()];;@[value;"\\p 9082";()] } @[hopen;`:localhost:9082;0];


.self.mode:`proc
.import.json:`bus_test
`btick2Home setenv "./btick2Home"
\l qlib.q

.import.require`plant`pm2`qtx`remote`repository
.import.init[]
.bt.action[`.import.init]()!()

/ .repository.createLib[`bus_test;`bus_test1]


(::).self.arg:(.pm2.config`default),``env`cmd`proc!({};`;`info;`all)
(::).self.arg:update jfile:`$.bt.print[":%",string[ .self.arg`repo],"%/plant/%plant%.json"] (.self.arg,.import.repository.con) from .self.arg
(::).self.arg[`jobj]: .j.k "c"$read1 .self.arg`jfile
(::).self.arg[`root]:`$.import.repository.con .self.arg`repo
(::).self.process:.plant.process .self.arg
(::).self.schema:.plant.schema .self.arg


(::)r:.bt.action[`.pm2.action] .self.arg
(::)process:r`process 

.remote.add allProc:select uid:luid,host,port,user:`,passwd:count[i]#enlist"" from process

(::)r:.bt.action[`.pm2.action] update cmd:`start from .self.arg


.f.proc:(0!allProc)`uid
f) count select from .bt.history where (not null error) or mode=`catch 
f) count select from .import.module0.con where not null error

if[any .f.r`result;]; / generate result

(::).f.proc:`admin.bus
f) select by action from .bt.history where action like ".bus*",mode=`behaviour
f) reverse select from .bt.history where action = `.bus.receiveBulk.client 

.f.proc:`qdata.bus
f) select by action from .bt.history where action like ".bus*",mode=`behaviour

(::).f.proc:`admin.proc1
f)select from .bt.history where action like ".bus.client.con.success*"
f)select from .bt.history where action like ".bus_test.send"


(::).f.proc:`admin.proc2
f) select cnt:count i by env,proc from raze .bus_test1.tmp

.f.proc:`qdata.proc2
f) select by action from .bt.history where action like ".bus*"
f) select cnt:count i by env,proc from raze .bus_test1.tmp

(::)r:.bt.action[`.pm2.action] update cmd:`stop from .self.arg

b) rm -rf data
b) rm btick2home/default.json
