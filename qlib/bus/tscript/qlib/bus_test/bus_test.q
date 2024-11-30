
d)lib bus_test.bus_test 
 Library for working with the lib bus_test
 q).import.module`bus_test 
 q).import.module`bus_test.bus_test
 q).import.module"bus_test/qlib/bus_test/bus_test.q"

.bus_test.summary:{} 

d)fnc bus_test.bus_test.summary 
 Give a summary of this function
 q) bus_test.summary[] 


.bt.addDelay[`.bus_test.send]{`tipe`time!(`in;00:00:01)}
.bt.add[`.bus.client.con.success`.bus_test.send;`.bus_test.send]{`topic`payload!(`.bus_test1.receive;.self.proc)}

.bt.addOnlyBehaviour[`.bus_test.send;`.bus.sendTweet]