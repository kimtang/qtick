
.import.module`bus.client;

.bt.rem[`.action.init]`.hopen.init;
.bt.rem[`.hopen.init]`.bus.server.init;
.bt.rem[`.hopen.success]`.bus.server.con.success;
.bt.rem[`.hopen.pc]`.bus.pc;
.bt.rem[`.bus.server.init]`.bus.server.init.con;
.bt.rem[`.bus.server.con.handshake]`.hopen.handshake;

.qtx.testSuite[`test.qtick.bus.client;"test bus"]
  .qtx.repo[`qtick]
  .qtx.lib[`bus]
  .qtx.file[`002]
  .qtx.testCase[`.bus.server.init;"argument injection"][
    .qtx.before[{
      .bt.action:.bt.actionThrow;
      arg0:(.pm2.config`default),``env`cmd`proc!({};`admin;`info;`bus);
      arg0:update jfile:`$.bt.print[":%",string[ arg0`repo],"%/plant/%plant%.json"] (arg0,.import.repository.con) from arg0;
      arg0[`jobj]: .j.k "c"$read1 arg0`jfile;
      arg0[`root]:`$.import.repository.con arg0`repo;
      process:.plant.process arg0;
      schema:.plant.schema arg0;
      proc:first select from process where env=arg0`env,proc=arg0`proc;   
      `arg`process`schema`proc!(arg0;process;schema;proc)
      }]
    .qtx.shouldData["description";"%qtick%qlib/bus/test/data/001";{[allData]
      .bt.action[`.bus.server.init] allData;
      .bus.con
      }]
    .qtx.should["description";{.qtx.out[`c`d!3 4;1b]}]
    .qtx.shouldEq["description";4;{[d]d}]    
    .qtx.shouldFail["description";`ifail;{'`ifail}]
    .qtx.nil
    ]
  .qtx.addArg[`a`b`c!0 1 2]
  .qtx.testCase[`test.bus.1;"test bus"][
    .qtx.before[{`a`b`c`d!3 4 5 6}]
    .qtx.shouldEq["description";3;{[a]a}]
    .qtx.shouldEq["description";6;{[d]d}]    
    .qtx.nil
    ]    
  .qtx.nil;

/

.bt.repository[`sym`mode!`.bus.client.init`behaviour]

(::).qtx.main[filter]()!()