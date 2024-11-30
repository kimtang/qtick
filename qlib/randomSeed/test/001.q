
.qtx.testSuite[`test.qtick.randomSeed;"test randomSeed"]
  .qtx.repo[`qtick]
  .qtx.lib[`randomSeed]
  .qtx.testCase[`arg.injection1;"argument injection"][
    .qtx.shouldEq["description";0;{[a]a}]
    .qtx.should["description";{.qtx.out[`c`d!3 4;1b]}]
    .qtx.shouldEq["description";4;{[d]d}]    
    .qtx.shouldFail["description";`ifail;{'`ifail}]
    .qtx.nil
    ]
  .qtx.addArg[`a`b`c!0 1 2]
  .qtx.testCase[`test.randomSeed.1;"test randomSeed"][
    .qtx.before[{`a`b`c`d!3 4 5 6}]
    .qtx.shouldEq["description";3;{[a]a}]
    .qtx.shouldEq["description";6;{[d]d}]    
    .qtx.nil
    ]    
  .qtx.nil;