args:.Q.def[`name`port!("01_test_ftnn.q";9085);].Q.opt .z.x

/ remove this line when using in production
/ develop_ftnn.q:localhost:9085::
{ if[not x=0; @[x;"\\\\";()]]; value"\\p 9085"; } @[hopen;`:localhost:9085;0];

.self.mode:`proc
.import.json:`bus_test
`btick2Home setenv "./btick2Home"
\l qlib.q

.import.require`pm2`qtx`plant
.bt.action[`.import.init]()!();

(::)allFiles:.qtx.summary filter:"repo=`qtick,lib=`bus,file=`002"
(::).qtx.main[filter]()!()

(::).qtx.result`5a580fb6


/ 