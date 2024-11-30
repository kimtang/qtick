d)lib qtick.berror.server 
 Library for working with the lib berror
 q).import.module`qtick.berror.server
 q).import.module"qtick/qlib/berror/server.q"


.berror.sendTime:`second$1
.berror.seq:-1

.bt.add[`.library.init;`.berror.init]{}

.bt.addDelay[`.berror.checkError]{`tipe`time!(`in;.berror.sendTime)}

.bt.add[`.berror.init`.berror.checkError;`.berror.checkError]{[allData]
 oseq:.berror.seq;
 .berror.seq:max exec seq from .bt.history where seq > oseq;
 berror:select from .bt.history where seq > oseq,not null error;
 :.bt.md[`berror] berror
 }

.bt.addIff[`.berror.upd]{[berror] 0 < count berror}
.bt.add[`.berror.checkError;`.berror.upd]{[berror]
 `topic`payload!enlist[`.berror.receiveError;] enlist `uid xcols update uid:.self.proc`uid from berror	
 }

.bt.add[`.berror.upd;`.berror.receiveError]{[payload] upd[`berror] raze payload }