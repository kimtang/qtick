
d)lib berror_test.berror_test1 
 Library for working with the lib berror_test1
 q).import.module`berror_test1 
 q).import.module`berror_test.berror_test1
 q).import.module"berror_test/qlib/berror_test1/berror_test1.q"

.berror_test1.summary:{} 

d)fnc berror_test1.berror_test1.summary 
 Give a summary of this function
 q) berror_test1.summary[] 


.bt.addDelay[`.berror_test.loop]{`tipe`time!(`in;00:00:01)}
.bt.add[`.bus.client.con.success`.bus.server.init`.berror_test.loop;`.berror_test.loop]{}

.bt.add[`.berror_test.loop;`.berror_test.send]{'`.berror_test.error}



/


select from .bt.history where action like ".berror_test.loop"