//
//  XCIdentifierTest.m
//  XCCalc
//
//  Created by Christoph Cwelich on 16.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCIdentifierTest.h"
#import "XCIdentifier.h"
#import "XCVariable.h"
#import "XCConstant.h"

@implementation XCIdentifierTest
-(void)testSimple {
    XCElement * idf = [XCIdentifier identifierWithConstantId:XC_EULER_ID andRoot:nil];
    STAssertEqualObjects([idf eval],@(M_E), nil);
    idf = [XCIdentifier identifierWithConstantId:XC_PI_ID andRoot:nil];
    STAssertEqualObjects([idf eval],@(M_PI), nil);
    XCVariable * v0 = [XCVariable variableForIndex:0];
    [v0 setNumericValue:@1.5];
    idf = [XCIdentifier identifierWithVariableIndex:0 andRoot:nil];
    STAssertEqualObjects([idf eval],@1.5, nil);
    idf = [XCIdentifier identifierWithVariableIndex:9 andRoot:nil];
    STAssertEqualObjects([idf eval],@0, nil);
    [v0 setNumericValue:@0];
    
}
-(void)testCopy {
    XCElement * idf = [XCIdentifier identifierWithConstantId:XC_EULER_ID andRoot:nil];
    XCElement * idfcp = [idf copy];
    STAssertEqualObjects([idfcp eval],@(M_E), nil);
    XCVariable * v0 = [XCVariable variableForIndex:0];
    [v0 setNumericValue:@1.5];
    idf = [XCIdentifier identifierWithVariableIndex:0 andRoot:nil];
    idfcp = [idf copy];
    STAssertEqualObjects([idfcp eval],@1.5, nil);
    [v0 setNumericValue:@2.5];
    STAssertEqualObjects([idfcp eval],@2.5, nil);
    [v0 setNumericValue:@0];
}
@end
