
d)lib bus_test.bus_test1 
 Library for working with the lib bus_test1
 q).import.module`bus_test1 
 q).import.module`bus_test.bus_test1
 q).import.module"bus_test/qlib/bus_test1/bus_test1.q"

.bus_test1.summary:{} 

d)fnc bus_test1.bus_test1.summary 
 Give a summary of this function
 q) bus_test1.summary[] 

.bus_test1.tmp:()

.bt.add[`;`.bus_test1.receive]{[payload] .bus_test1.tmp:.bus_test1.tmp,enlist payload }