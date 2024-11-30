args:.Q.def[`name`port!("tscript/01.q";9082);].Q.opt .z.x

/ remove this line when using in production
/ tscript/01.q:localhost:9082::
/ admin.bus:localhost:30011::
/ admin.client1:localhost:30013::
/ admin.server:localhost:30012::
/ qdata.bus:localhost:30112::
/ qdata.client1:localhost:30113::
/ qdata.client2:localhost:30114::

{ if[not x=0; @[x;"exit 0";()]]; ;@[value;"\\p 9082";()];;@[value;"\\p 9082";()] } @[hopen;`:localhost:9082;0];

.self.mode:`proc
.import.json:`berror_test
`btick2Home setenv "./btick2Home"
\l qlib.q

.import.require`plant`pm2`qtx`remote`repository
.import.init[]
.bt.action[`.import.init]()!()

/ b) mkdir plant
/ b) touch plant/berror_test.json

.import.summary[]

/ .repository.createLib[`berror_test;`berror_test]

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

(::)r:.bt.action[`.pm2.action] update cmd:`start from .self.arg

.f.proc:(0!allProc)`uid
/ f) count select from .bt.history where (not null error) or mode=`catch 
f) count select from .import.module0.con where not null error

if[any .f.r`result;]; / generate result

(::).f.proc:`admin.server
f) select cnt:count i by uid from berror


(::)r:.bt.action[`.pm2.action] update cmd:`stop from .self.arg

/

b) rm -rf data
b) rm btick2home/default.json
