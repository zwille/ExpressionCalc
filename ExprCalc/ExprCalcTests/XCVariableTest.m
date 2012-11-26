//
//  XCVariableTest.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 26.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCVariableTest.h"
#import "XCVariable.h"

@implementation XCVariableTest
-(void)testVariableByName {
    XCVariable * a = [XCVariable variableByName:@"a"];
    STAssertTrue([[a name] isEqualToString:@"a" ],  nil);
    STAssertEqualObjects([a value], [XCNumber numberFromDouble:0], nil);
    XCNumber * one = [XCNumber numberFromDouble:1];
    STAssertEqualObjects([a value], one, nil);
    
}
@end
