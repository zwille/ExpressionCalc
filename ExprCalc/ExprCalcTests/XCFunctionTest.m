//
//  XCFunctionTest.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 26.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCFunctionTest.h"
#import "XCTokenizer.h"
#import "XCFunction.h"

@implementation XCFunctionTest
-(void)parseWithString: (NSString*) str andAssertedVal: (double) asserted {
    XCTokenizer *tok = [XCTokenizer tokenizerWithString:str];
    XCToken * token = [tok nextToken];
    XCFunction *f =[XCFunction parseWithTokenizer:tok andArg: token];
    XCNumber * actual = [f value];
    XCNumber * expected = [XCNumber numberFromDouble:asserted];
    STAssertEqualObjects(actual, expected, @"expected %@ but was %@",expected,actual);
}
-(void)testParse {
    [self parseWithString:@"cos 0" andAssertedVal:1];
  //  [self parseWithString:@"cos(1-1)"andAssertedVal:1];
}

@end
