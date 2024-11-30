
d)lib heartbeat_test.heartbeat_test 
 Library for working with the lib heartbeat_test
 q).import.module`heartbeat_test 
 q).import.module`heartbeat_test.heartbeat_test
 q).import.module"heartbeat_test/qlib/heartbeat_test/heartbeat_test.q"

.heartbeat_test.summary:{} 

d)fnc heartbeat_test.heartbeat_test.summary 
 Give a summary of this function
 q) heartbeat_test.summary[] 

heartbeat:()

upd:{[t;x]
 if[99h=type x;x:enlist x];
 t insert x
 }