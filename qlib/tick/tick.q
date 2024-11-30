
d)lib qtick.tick 
 Library for working with the lib tick
 q).import.module`tick 
 q).import.module`qtick.tick
 q).import.module"%qtick%/qlib/tick/tick.q"

.tick.summary:{} 

d)fnc tick.tick.summary 
 Give a summary of this function
 q) tick.summary[] 


.tick.addTime0:()!()
.tick.addTime0[0h]:{[data] enlist[.z.p],data }
.tick.addTime0[98h]:{[data] `time xcols update time:.z.p from data } / table
.tick.addTime0[99h]:{[data] (`time,key[data])# @[;`time;:;.z.p] (.bt.md[`]{}), data  } /dictionary
.tick.addTime:{[data] .tick.addTime0[ $[type[data] in 0 98 99h;type data;0h] ] data }

.tick.addDate0:()!()
.tick.addDate0[0h]:{[data] enlist[.z.d],data }
.tick.addDate0[98h]:{[data] `date xcols update date:.z.d from data } / table
.tick.addDate0[99h]:{[data] @[data;`date;:;.z.d]  } /dictionary
.tick.addDate:{[data] .tick.addDate0[ $[type[data] in 0 98 99h;type data;0h] ] data }

.tick.addCols0:()!()
.tick.addCols0[0h]:{[tname;data] m:(10b!flip,enlist) max 0h=type@'data ;m .tick.oc[tname]!data }
.tick.addCols0[98h]:{[tname;data] data }
.tick.addCols0[99h]:{[tname;data] enlist data }
.tick.addCols:{[tname;data] .tick.addCols0[type data][tname;data] }