//
//  XCStringIteratorTest.m
//  ExpressionCalc
//
//  Created by Christoph Cwelich on 20.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCStringIteratorTest.h"

@implementation XCStringIteratorTest
-(void)setUp{
    inst1 = [[XCStringIterator alloc] initWithString:@""];
    inst2 = [[XCStringIterator alloc] initWithString:@"A"];
    inst3 = [[XCStringIterator alloc] initWithString:@"Abc"];
}
-(void)testIterator{
    STAssertTrue([inst1 index]==0,nil);
    STAssertTrue([inst1 currentChar]==0,nil);
    STAssertFalse([inst1 hasNextChar],nil);
    STAssertTrue([inst1 nextChar]==0,nil);
    STAssertTrue([inst1 index]==0,nil);
    
    STAssertTrue([inst2 index]==0,nil);
    STAssertTrue([inst2 currentChar]==0,nil);
    STAssertTrue([inst2 hasNextChar],nil);
    STAssertTrue([inst2 nextChar]=='A',nil);
    
    STAssertTrue([inst2 index]==1,nil);
    STAssertTrue([inst2 currentChar]=='A',nil);
    STAssertFalse([inst2 hasNextChar],nil);
    STAssertTrue([inst2 nextChar]==0, nil);
    STAssertTrue([inst2 index]==1,nil);
    
    STAssertTrue([inst3 index]==0,nil);
    STAssertTrue([inst3 currentChar]==0,nil);
    STAssertTrue([inst3 hasNextChar],nil);
    STAssertTrue([inst3 nextChar]=='A',nil);
    
    STAssertTrue([inst3 index]==1,nil);
    STAssertTrue([inst3 currentChar]=='A',nil);
    STAssertTrue([inst3 hasNextChar],nil);
    STAssertTrue([inst3 nextChar]=='b', nil);
    
    STAssertTrue([inst3 index]==2,nil);
    STAssertTrue([inst3 currentChar]=='b',nil);
    STAssertTrue([inst3 hasNextChar],nil);
    STAssertTrue([inst3 nextChar]=='c', nil);
    
    STAssertTrue([inst3 index]==3,nil);
    STAssertTrue([inst3 currentChar]=='c',nil);
    STAssertFalse([inst3 hasNextChar],nil);
    STAssertTrue([inst3 nextChar]==0, nil);
    STAssertTrue([inst3 index]==3,nil);


}
@end
