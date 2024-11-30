
d)lib qtick.tick.hft 
 Library for working with the lib tick
 q).import.module`tick.hft 
 q).import.module`qtick.tick.hft
 q).import.module"%qtick%/qlib/tick/hft.q"


.bt.add[`;`.tick.upd]{[allData;tname;data]
 data:$[.tick.a tname;.tick.addTime;(::)]data;
 .tick.l enlist d:(`upd;tname;data);
 .tick.i:.tick.i + 1;
 hdls:exec hdl from .tick.con where tname = allData`tname,not null hdl;
 / hdls@\:d;
 -25!(hdls;d);
 .tick.j:.tick.j + 1;
 }