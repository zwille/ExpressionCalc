//
//  XCNumberTest.m
//  XCCalc
//
//  Created by Christoph Cwelich on 12.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCNumberTest.h"

@implementation XCNumberTest
-(void)setUp {
    [super setUp];
    nan = [NSNumber nan];
    imin = [NSNumber numberWithLong:LONG_MIN];
    imax = [NSNumber numberWithLong:LONG_MAX];
    //nums = @[@-1.5,@-1,@0,@1,@1.5, [NSNumber numberWithDouble:NAN]];
   // NSLog(@">>> XCNumberTest::setUp nums=%@",nums);
}
-(void)testSetUp {
    NSNumber * num = @-1.5;
    [self checkStateWithNumber:num asInteger:NO ifNan:NO ifZero:NO];
    STAssertTrue([num doubleValue]==-1.5, nil);
    num = @-1;
    [self checkStateWithNumber:num asInteger:YES ifNan:NO ifZero:NO];
    STAssertTrue([num longValue]==-1, nil);
    num = @0;
    [self checkStateWithNumber:num asInteger:YES ifNan:NO ifZero:YES];
    STAssertTrue([num longValue]==0, nil);
    num = @0.0;
    [self checkStateWithNumber:num asInteger:NO ifNan:NO ifZero:YES];
    STAssertTrue([num doubleValue]==0.0, nil);

    num = @1;
    [self checkStateWithNumber:num asInteger:YES ifNan:NO ifZero:NO];
    STAssertTrue([num longValue]==1, nil);
    num = @1.5;
    [self checkStateWithNumber:num asInteger:NO ifNan:NO ifZero:NO];
    STAssertTrue([num doubleValue]==1.5, nil);
    num = imin;
    [self checkStateWithNumber:num asInteger:YES ifNan:NO ifZero:NO];
    STAssertTrue([num longValue]==LONG_MIN, nil);
    num = imax;
    [self checkStateWithNumber:num asInteger:YES ifNan:NO ifZero:NO];
    STAssertTrue([num longValue]==LONG_MAX, nil);
    num = nan;
    [self checkStateWithNumber:num asInteger:NO ifNan:YES ifZero:NO];
    STAssertTrue(isnan([num doubleValue]), nil);
    
}
-(void)checkStateWithNumber: (NSNumber*) num
                  asInteger:(BOOL) isInt
                      ifNan: (BOOL) isNaN
                     ifZero: (BOOL) isZero{
    STAssertTrue([num isInteger]==isInt, @"%@ isInteger asserted %d",num,isInt);
    STAssertTrue([num isNaN]==isNaN, @"%@ isNaN asserted %d",num,isNaN);
    STAssertTrue([num isZero]==isZero, @"%@ isZero asserted %d",num,isZero);
}
-(void)testNegate {
    NSNumber * num = [@-1.5 negate];
    [self checkStateWithNumber:num asInteger:NO ifNan:NO ifZero:NO];
    STAssertTrue([num doubleValue]==1.5, nil);
    
    num = [@-1 negate];
    [self checkStateWithNumber:num asInteger:YES ifNan:NO ifZero:NO];
    STAssertTrue([num longValue]==1, nil);
    
    num = [@0 negate];
    [self checkStateWithNumber:num asInteger:YES ifNan:NO ifZero:YES];
    STAssertTrue([num longValue]==0, nil);
    
    num = [@1 negate];
    [self checkStateWithNumber:num asInteger:YES ifNan:NO ifZero:NO];
    STAssertTrue([num longValue]==-1, nil);
    
    num = [@1.5 negate];
    [self checkStateWithNumber:num asInteger:NO ifNan:NO ifZero:NO];
    STAssertTrue([num doubleValue]==-1.5, nil);
    
    num = [imin negate];
    [self checkStateWithNumber:num asInteger:NO ifNan:NO ifZero:NO];
    STAssertTrue([num doubleValue]==1.0+LONG_MAX, nil);
    
    num = [imax negate];
    [self checkStateWithNumber:num asInteger:YES ifNan:NO ifZero:NO];
    STAssertTrue([num longValue]==LONG_MIN+1, nil);

    num = [nan negate];
    [self checkStateWithNumber:num asInteger:NO ifNan:YES ifZero:NO];
    STAssertTrue(isnan([num doubleValue]), nil);
}
-(void)addNum: (NSNumber*) num1
      withNum: (NSNumber*) num2
 assertResult: (NSNumber*) asserted
    asInteger:(BOOL) isInt
        ifNan: (BOOL) isNaN
       ifZero: (BOOL) isZero{
    NSNumber * result = [num1 addNum:num2];
    //NSLog(@">>> add %@ with %@: %@",num1,num2,result);
    [self checkStateWithNumber:result asInteger:isInt ifNan:isNaN ifZero:isZero];
    STAssertEqualObjects(result, asserted, nil);
}
-(void)testAdd {
    [self addNum: @-1.5 withNum:@-1 assertResult:@-2.5 asInteger:NO ifNan:NO ifZero:NO];
    [self addNum: @-1 withNum:@1 assertResult:@0 asInteger:YES ifNan:NO ifZero:YES];
    [self addNum: @-1.5 withNum:@1.5 assertResult:@0.0 asInteger:NO ifNan:NO ifZero:YES];
    
    [self addNum: imin withNum:imax assertResult:@-1 asInteger:YES ifNan:NO ifZero:NO];
    [self addNum: imin withNum:@0 assertResult:imin asInteger:YES ifNan:NO ifZero:NO];
    [self addNum: imin withNum:@-1 assertResult:[NSNumber numberWithDouble: LONG_MIN-1.0] asInteger:NO ifNan:NO ifZero:NO];
    [self addNum: imin withNum:@1 assertResult:[NSNumber numberWithLong: LONG_MIN+1] asInteger:YES ifNan:NO ifZero:NO];
    [self addNum: imin withNum:imin assertResult:[NSNumber numberWithDouble:2.0* LONG_MIN] asInteger:NO ifNan:NO ifZero:NO];
    
    [self addNum: imax withNum:imin assertResult:@-1 asInteger:YES ifNan:NO ifZero:NO];
    [self addNum: imax withNum:@-1 assertResult:[NSNumber numberWithLong: LONG_MAX-1] asInteger:YES ifNan:NO ifZero:NO];
    [self addNum: imax withNum:@1 assertResult:[NSNumber numberWithDouble: LONG_MAX+1.0] asInteger:NO ifNan:NO ifZero:NO];
    [self addNum: imax withNum:imax assertResult:[NSNumber numberWithDouble:2.0* LONG_MAX] asInteger:NO ifNan:NO ifZero:NO];
  
    [self addNum: @-1.5 withNum:nan assertResult:nan asInteger:NO ifNan:YES ifZero:NO];
    [self addNum: @-1 withNum:nan assertResult:nan asInteger:NO ifNan:YES ifZero:NO];
  
}
-(void)multNum: (NSNumber*) num1
      withNum: (NSNumber*) num2
 assertResult: (NSNumber*) asserted
    asInteger:(BOOL) isInt
        ifNan: (BOOL) isNaN
       ifZero: (BOOL) isZero{
    NSNumber * result = [num1 multNum:num2];
    //NSLog(@">>> mult %@ with %@: %@",num1,num2,result);
    [self checkStateWithNumber:result asInteger:isInt ifNan:isNaN ifZero:isZero];
    STAssertEqualObjects(result, asserted, nil);
}
-(void)testMult {
    [self multNum:@-1.5 withNum:@-1 assertResult:@1.5 asInteger:NO ifNan:NO ifZero:NO];
    [self multNum:@1 withNum:@-1 assertResult:@-1 asInteger:YES ifNan:NO ifZero:NO];
    [self multNum:@3 withNum:@5 assertResult:@15 asInteger:YES ifNan:NO ifZero:NO];
    [self multNum:@-1 withNum:@0.0 assertResult:@0.0 asInteger:NO ifNan:NO ifZero:YES];
    [self multNum:@-1.5 withNum:@1.5 assertResult:@-2.25 asInteger:NO ifNan:NO ifZero:NO];
    
    //blackbox overflow check
    long a = (LONG_MIN>>1)&LONG_MAX, b= a+1;
    [self multNum: [NSNumber numberWithLong: a]
          withNum: [NSNumber numberWithLong: b]
     assertResult:[NSNumber numberWithDouble:(double) a * b] asInteger:NO ifNan:NO ifZero:NO];
    
    [self multNum:imin withNum:@0 assertResult:@0 asInteger:YES ifNan:NO ifZero:YES];
    [self multNum:imin withNum:@1 assertResult:imin asInteger:YES ifNan:NO ifZero:NO];
    [self multNum:imin withNum:@-1 assertResult:[NSNumber numberWithDouble:-1.0*LONG_MIN] asInteger:NO ifNan:NO ifZero:NO];
    [self multNum:imin withNum:@2 assertResult:[NSNumber numberWithDouble:2.0*LONG_MIN] asInteger:NO ifNan:NO ifZero:NO];
    [self multNum:imin withNum:imin assertResult:[NSNumber numberWithDouble:(double)LONG_MIN*LONG_MIN] asInteger:NO ifNan:NO ifZero:NO];
    [self multNum:imin withNum:imax assertResult:[NSNumber numberWithDouble:(double)LONG_MIN*LONG_MAX] asInteger:NO ifNan:NO ifZero:NO];

    [self multNum:imax withNum:@0 assertResult:@0 asInteger:YES ifNan:NO ifZero:YES];
    [self multNum:imax withNum:@1 assertResult:imax asInteger:YES ifNan:NO ifZero:NO];
    [self multNum:imax withNum:@2 assertResult:[NSNumber numberWithDouble:2.0*LONG_MAX]
        asInteger:NO ifNan:NO ifZero:NO];
    [self multNum:imax withNum:imax assertResult:[NSNumber numberWithDouble:(double)LONG_MAX*LONG_MAX]
        asInteger:NO ifNan:NO ifZero:NO];
    [self multNum:imax withNum:@0 assertResult:@0 asInteger:YES ifNan:NO ifZero:YES];
    
    [self multNum:@-1.5 withNum:nan assertResult:nan asInteger:NO ifNan:YES ifZero:NO];
    [self multNum:@-1 withNum:nan assertResult:nan asInteger:NO ifNan:YES ifZero:NO];
}
-(void)base: (NSNumber*) num1
       powExp: (NSNumber*) num2
  assertResult: (NSNumber*) asserted
     asInteger:(BOOL) isInt{
    NSNumber * result = [num1 powExp: num2];
    //NSLog(@">>> pow base %@ exp %@: %@",num1,num2,result);
    [self checkStateWithNumber:result asInteger:isInt ifNan:NO ifZero:NO];
    STAssertEqualObjects(result, asserted, nil);
}
-(void)testPow {
    [self base:@2 powExp:@0 assertResult:@1 asInteger:YES];
    [self base:@2 powExp:@1 assertResult:@2 asInteger:YES];
    [self base:@2 powExp:@2 assertResult:@4 asInteger:YES];
    [self base:@2 powExp:@3 assertResult:@8 asInteger:YES];
    // 32 bit long asserted
    [self base:@4 powExp:@10 assertResult:[NSNumber numberWithLong:(long)pow(4,10)] asInteger:YES];
    [self base:@4 powExp:@15 assertResult:[NSNumber numberWithDouble:pow(4,15)] asInteger:NO];
    [self base:@63 powExp:@5 assertResult:[NSNumber numberWithLong:(long)pow(63, 5)] asInteger:YES];
    [self base:@63 powExp:@6 assertResult:[NSNumber numberWithDouble:pow(63,6)] asInteger:NO];
    //
    [self base:imin powExp:@0 assertResult:@1 asInteger:YES];
    [self base:imin powExp:@1 assertResult:imin asInteger:YES];
    [self base:imin powExp:@2 assertResult:
     [NSNumber numberWithDouble:(double)LONG_MIN * LONG_MIN]asInteger:NO];
    
    [self base:@1.5 powExp:@2 assertResult:[NSNumber numberWithDouble:pow(1.5, 2)] asInteger:NO];
    [self base:@2 powExp:@0.5 assertResult:[NSNumber numberWithDouble:pow(2,0.5)] asInteger:NO];
    [self base:@2 powExp:@0.0 assertResult:@1.0 asInteger:NO];
    [self base:@2 powExp:@-2 assertResult:@.25 asInteger:NO];



}
-(void)invertNum: (NSNumber*) num
  assertResult: (NSNumber*) asserted
        ifNan: (BOOL) isNaN {
    NSNumber * result = [num invert];
  //  NSLog(@">>> invert %@: %@",num,result);
    [self checkStateWithNumber:result asInteger:NO ifNan:isNaN ifZero:NO];
    STAssertEqualObjects(result, asserted, nil);
}
-(void)testInvert {
    [self invertNum:@-2 assertResult:@-.5 ifNan:NO];
    [self invertNum:@-1 assertResult:@-1 ifNan:NO];
    [self invertNum:@-.5 assertResult:@-2.0 ifNan:NO];
    [self invertNum:@0 assertResult:nan ifNan:YES];
    [self invertNum:@0.0 assertResult:nan ifNan:YES];
    [self invertNum:@.5 assertResult:@2.0 ifNan:NO];
    [self invertNum:@1 assertResult:@1 ifNan:NO];
    [self invertNum:@2 assertResult:@.5 ifNan:NO];
    [self invertNum:imin assertResult:[NSNumber numberWithDouble:1.0/LONG_MIN] ifNan:NO];
    [self invertNum:imax assertResult:[NSNumber numberWithDouble:1.0/LONG_MAX] ifNan:NO];
}
@end
