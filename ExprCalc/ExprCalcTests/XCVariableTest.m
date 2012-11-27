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
    XCNumber * one = [XCNumber numberFromDouble:1];
    [a setValue:one];
    STAssertTrue([[a name] isEqualToString:@"a" ],  nil);
    STAssertEqualObjects([a value], one, nil);
   
    
}
@end
