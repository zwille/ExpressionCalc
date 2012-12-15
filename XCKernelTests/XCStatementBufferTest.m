//
//  XCStatementBufferTest.m
//  XCCalc
//
//  Created by Christoph Cwelich on 15.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCStatementBufferTest.h"
#import "XCStatementBuffer.h"
#import "XCStatement.h"

@implementation XCStatementBufferTest

-(void)checkStateOfBuffer: (XCStatementBuffer*) buf
      assertHasNext: (BOOL) hasNext
  assertHasPrevious: (BOOL) hasPrevious
   currentStatement: (XCStatement*) current {
    STAssertEqualObjects(current, [buf current], nil);
    STAssertTrue([buf hasNext]==hasNext, nil);
    STAssertTrue([buf hasPrevious]==hasPrevious, nil);
    
}
-(void)testSimple {
    
    XCStatement * s0, *s1, *s2;
    s0 = [XCStatement emptyStatement];
    s1 = [XCStatement emptyStatement];
    s2 = [XCStatement emptyStatement];
    
    XCStatementBuffer * buf = [[XCStatementBuffer alloc] init];
    [buf pushStatement:s0];
    [self checkStateOfBuffer:buf assertHasNext:NO assertHasPrevious:NO currentStatement:s0];
    [buf pushStatement:s1];
    [self checkStateOfBuffer:buf assertHasNext:NO assertHasPrevious:YES currentStatement:s1];
    [buf pushStatement:s2];
    [self checkStateOfBuffer:buf assertHasNext:NO assertHasPrevious:YES currentStatement:s2];
    STAssertEqualObjects([buf previous], s1, nil);
    [self checkStateOfBuffer:buf assertHasNext:YES assertHasPrevious:YES currentStatement:s1];
    STAssertEqualObjects([buf previous], s0, nil);
    [self checkStateOfBuffer:buf assertHasNext:YES assertHasPrevious:NO currentStatement:s0];
    STAssertEqualObjects([buf next], s1, nil);
    [self checkStateOfBuffer:buf assertHasNext:YES assertHasPrevious:YES currentStatement:s1];
    [buf moveToHead];
    STAssertEqualObjects([buf head], [buf current], nil);
    [self checkStateOfBuffer:buf assertHasNext:NO assertHasPrevious:YES currentStatement:s2];

}
@end
