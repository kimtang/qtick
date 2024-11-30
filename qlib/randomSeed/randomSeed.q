
d)lib qtick.randomSeed 
 Library for working with the lib randomSeed
 q).import.module`randomSeed 
 q).import.module`qtick.randomSeed
 q).import.module"qtick/qlib/randomSeed/randomSeed.q"

.randomSeed.summary:{} 

d)fnc randomSeed.randomSeed.summary 
 Give a summary of this function
 q) randomSeed.summary[] 


.bt.addIff[`.randomSeed.init.random]{[allData] not `randomSeed in key allData }
.bt.add[`.action.init;`.randomSeed.init.random]{[allData] / don't need any configuration
 seed:(1#`seed)!enlist sum "J"$9 cut reverse string .z.i + "j"$.z.P;
 system .bt.print["S %seed%"] seed; 
 seed
 }

.bt.addIff[`.randomSeed.init.static]{[allData] `randomSeed in key allData }
.bt.add[`.action.init;`.randomSeed.init.static]{[randomSeed] 
 system .bt.print["S %seed%"] randomSeed;
 randomSeed  
 } 