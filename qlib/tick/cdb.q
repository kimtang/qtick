
d)lib qtick.tick.cdb 
 Library for working with the lib tick
 q).import.module`tick.cdb 
 q).import.module`qtick.tick.cdb
 q).import.module"%qtick%/qlib/tick/cdb.q"

.bt.add[`.action.init;`.tick.cdb.init]{[process;proc0;schema]
 .tick.cdb:.bt.print["%dataDir%/%env%/cdb"] proc0;
 .tick.cwd:"";
 .tick.replay:exec luid from process where `tick.replay in/:lib,env=proc0`env;
 }


.bt.addIff[`.tick.loadHdb]{ not ()~key hsym `$ $[.tick.cwd~"";.tick.cdb;"."] }

.bt.add[`.tick.cdb.init`.replay.eod;`.tick.loadHdb]{
 dbpath:$[.tick.cwd~"";.tick.cdb;"."];
 system "l ",dbpath;
 .tick.cwd:.tick.cdb;
 }


.bt.addIff[`.replay.eod]{[payload]payload:raze payload ;max .tick.replay in payload`luid  }
.bt.add[`;`.replay.eod]{[allData]}


/

tables[]!{count select from x}@'tables[]