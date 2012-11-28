//
//  XCLiteralTest.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 27.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCLiteralTest.h"
#import "XCTokenizer.h"
#import "XCNumber.h"
#import "XCIdentifier.h"
#import "XCFunction.h"
#import "XCVariable.h"
#import "XCErrorToken.h"
@implementation XCLiteralTest
-(void)testConstant{
    [self parseWithString:@"ℯ" andAssertedVal:M_E];
    [self parseWithString:@"π" andAssertedVal:M_PI];
}
-(void)testVariable{
    XCVariable * a = [XCVariable variableByName:@"a"];
    double expected = 2.5;
    [a setValue:[XCNumber numberFromDouble:expected]];
    [self parseWithString:@"a" andAssertedVal:expected];
}
-(void)testFunction{
    [self parseWithString:@"cos0" andAssertedVal:1];
    [self parseWithString:@"cos(0)" andAssertedVal:1];
    [self parseWithString:@"cos(1-1)" andAssertedVal:1];
}
-(void)testMalformed {
    [self parseMalformedWithString:@"co"];
    [self parseMalformedWithString:@"e"];
    [self parseMalformedWithString:@"cos (0)"];
    [self parseMalformedWithString:@"sin 5"];
    
}
-(void)parseExpression {
    [self parseWithString:@"(1+2)" andAssertedVal:3];
}
-(void)parseWithString: (NSString*) str andAssertedVal: (double) asserted {
    XCTokenizer *tok = [XCTokenizer tokenizerWithString:str];
    XCFunction *f =[XCLiteral parseWithTokenizer:tok andArg: nil];
    XCNumber * actual = [f value];
    XCNumber * expected = [XCNumber numberFromDouble:asserted];
    STAssertEqualObjects(actual, expected, @"expected %@ but was %@",expected,actual);
}
-(void)parseMalformedWithString: (NSString*) str {
    XCTokenizer *tok = [XCTokenizer tokenizerWithString:str];
    id f =[XCLiteral parseWithTokenizer:tok andArg: nil];
    STAssertTrue([f isKindOfClass:[XCErrorToken class]], @"%@", f);
    
}
@end
