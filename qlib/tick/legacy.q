d)lib qtick.tick.legacy 
 Library for working with the lib tick
 q).import.module`tick.legacy 
 q).import.module`qtick.tick.legacy
 q).import.module"%qtick%/qlib/tick/legacy.q"

.u.sub:{[x;y] .bt.action[`.u.sub] `tname`sym!(x;y)}
.bt.add[`.u.sub;`.tick.u.sub]{[tname;sym]
 fnc0:(::);
 fnc1:{[data0;sym] select from data where sym in sym0 };
 if[`sym in .tick.c tname;
 	if[ (sym~`) or sym~`all;sel:fnc0];
 	if[ not (sym~`) or sym~`all;sel:fnc1[;sym]];
 ];
 if[not `sym in .tick.c tname;sel:fnc0];
 `.tick.con insert `env`proc`tname`sel`hdl!(`outer;`outer;tname;{[data;sym0] select from data where sym in sym0; }[;sym];.z.w);
 `L`i`j#.tick
 }

/

select by uid from heartbeat

.tick.con

select from .bt.history where action like ".tick.upd"

.bt.putArg 27635j