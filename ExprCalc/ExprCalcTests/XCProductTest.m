//
//  XCProductTest.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 28.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCProductTest.h"
#import "XCProduct.h"
#import "XCPower.h"
#import "XCErrorToken.h"

@implementation XCProductTest
-(void)testParse {
    [self parseString:@"2*3" andAssertValue:6];
    [self parseString:@"π*2" andAssertValue:M_PI*2];
    [self parseString:@"2*cos0" andAssertValue:2];
    [self parseString:@"2*0" andAssertValue:0];
    [self parseString:@"2*3*2" andAssertValue:12];
    //[self parseString:@"2*(1+2)" andAssertValue:8];
    [self parseString:@"2" andAssertValue:2];
    [self parseString:@"2/3" andAssertValue:2/3];
    [self parseString:@"π/2" andAssertValue:M_PI/2];
    [self parseString:@"2/cos0" andAssertValue:2];
    [self parseString:@"2/0" andAssertValue:NAN];
    [self parseString:@"2/3*2" andAssertValue:4/3];
    //[self parseString:@"2/(1+2)" andAssertValue:8];
    [self parseString:@"2" andAssertValue:2];
}
-(void)testMalformed {
    [self parseMalformedWithString:@"*2*3"];
    [self parseMalformedWithString:@"2*E"];
    [self parseMalformedWithString:@"2* 5"];
    [self parseMalformedWithString:@"cos*5"];
    [self parseMalformedWithString:@"2**4"];
}
-(void) parseString: (NSString*) str andAssertValue: (double) asserted {
    XCTokenizer * tok = [XCTokenizer tokenizerWithString:str];
    id<XCHasValue> rc = [XCProduct parseWithTokenizer:tok andArg:nil];
    XCNumber * actual = [rc value];
    XCNumber * expected = [XCNumber numberFromDouble:asserted];
    STAssertEqualObjects(actual, expected, @"expected %@ but was %@",expected,actual);
}
-(void)parseMalformedWithString: (NSString*) str {
    XCTokenizer *tok = [XCTokenizer tokenizerWithString:str];
    id f =[XCProduct parseWithTokenizer:tok andArg: nil];
    STAssertTrue([f isKindOfClass:[XCErrorToken class]], @">>> asserted error, but was %@ for input %@",f,str);
}
@end
