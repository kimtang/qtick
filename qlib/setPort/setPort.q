
d)lib qtick.setPort 
 Library for working with the lib setPort
 q).import.module`setPort 
 q).import.module`qtick.setPort
 q).import.module"qtick/qlib/setPort/setPort.q"

.setPort.summary:{} 

d)fnc setPort.setPort.summary 
 Give a summary of this function
 q) setPort.summary[] 


.bt.addIff[`.setPort.init.random]{[allData] not `setPort in key allData }
.bt.add[`.action.init;`.setPort.init.random]{[allData] / don't need any configuration
 setPort:(1#`port)!10000+1?10000;
 system .bt.print["p %port%"] setPort;
 setPort
 }

.bt.addIff[`.setPort.init.static]{[allData] `setPort in key allData }
.bt.add[`.action.init;`.setPort.init.static]{[setPort] 
 system .bt.print["p %port%"] setPort;
 setPort
 } 