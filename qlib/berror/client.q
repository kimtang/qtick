d)lib qtick.berror.client 
 Library for working with the lib berror
 q).import.module`qtick.berror.client
 q).import.module"qtick/qlib/berror/client.q"


.berror.sendTime:`second$2
.berror.seq:-1

.bt.add[`.bus.client.init`.bus.server.init;`.berror.init]{} / nothing to init

.bt.addDelay[`.berror.bcheckError]{`tipe`time!(`in;.berror.sendTime)}

.bt.add[`.berror.init`.berror.bcheckError;`.berror.bcheckError]{[allData]
 oseq:.berror.seq;
 .berror.seq:max exec seq from .bt.history where seq > oseq;
 berror:select from .bt.history where seq > oseq,not null error;
 :.bt.md[`berror] berror
 }


.bt.addIff[`.berror.tweet]{[berror] 0 < count berror}
.bt.add[`.berror.bcheckError;`.berror.tweet]{[berror]
 `topic`payload!enlist[`.berror.receiveError;] `uid xcols update uid:.self.proc`uid from berror	
 }

.bt.addOnlyBehaviour[`.berror.tweet]`.bus.sendTweet
