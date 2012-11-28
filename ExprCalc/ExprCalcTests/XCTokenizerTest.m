//
//  XCTokenizerTest.m
//  ExpressionCalc
//
//  Created by Christoph Cwelich on 20.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCTokenizerTest.h"
#import "XCTokenizer.h"
#import "XCStringIterator.h"
#import "XCToken.h"
#import "XCNumber.h"
#import "XCErrorToken.h"

XCTokenizer * XCTokFromString(NSString* str) {
    XCStringIterator * it = [[XCStringIterator alloc] initWithString:str];
    return [[XCTokenizer alloc] initWithStatement:it];
}

@implementation XCTokenizerTest
-(void) fullCheckWithTokenizer:(XCTokenizer *) tok
              andAssertedIndex: (NSUInteger) assertedIndex
                    andContent: (NSString *) assertedContent
                       andType: (XCTokenType) assertedType {
    NSUInteger index = [tok index];
    STAssertTrue(index == assertedIndex,@"asserted %d, but was %d",assertedIndex,index);
    XCToken * t = [tok previewToken];
    STAssertTrue([[t content] isEqualToString: assertedContent],
                 @"asserted %@, but was %@",assertedContent,[t content]);
    STAssertTrue([t tokenType]==assertedType,
                 @"asserted %@, but was %@",
                 [XCToken stringOfType: assertedType],[XCToken stringOfType:[t tokenType]]);
    t = [tok nextToken];
    STAssertTrue([[t content] isEqualToString: assertedContent],@"asserted %@, but was %@",assertedContent,[t content]);
    STAssertTrue([t tokenType]==assertedType,
                 @"asserted %@, but was %@",
                 [XCToken stringOfType: assertedType],[XCToken stringOfType:[t tokenType]]);
}
-(void) assertFinishedWithTokenizer: (XCTokenizer*) tok andAssertedIndex: (NSUInteger) assertedIndex {
    NSUInteger index = [tok index];
    STAssertTrue(index == assertedIndex,@"asserted %d, but was %d",assertedIndex,index);
    XCToken * t = [tok previewToken];
    //  NSLog(@">>> %@",t);
    STAssertNil([t content], @"asserted nil, but was %@",[t content]);
    STAssertTrue([t tokenType]==END_OF_STATEMENT,@"asserted end of statement, but was %@",[XCToken stringOfType:[t tokenType]]);
    t = [tok nextToken];
    STAssertNil([t content], @"asserted nil, but was %@",[t content]);
    STAssertTrue([t tokenType]==END_OF_STATEMENT,@"asserted end of statement, but was %@",[XCToken stringOfType:[t tokenType]]);
}
-(void) checkNumberWithNumberString: (NSString*) str
    andAssertedValue: (double) assertedValue{
    XCNumber * assertedNumber = [XCNumber numberFromDouble:assertedValue];
    XCTokenizer * tok = XCTokFromString(str);
    NSUInteger index = [tok index];
    STAssertTrue(index == 0, @"asserted %d, but was %d",0,index);
    XCToken * t = [tok previewToken];
    NSNumber * num = [t content];
    STAssertEqualObjects(num, assertedNumber, @"asserted %@, but was %@",assertedNumber,num);
    STAssertTrue([t tokenType]==NUMBER,@"asserted number, but was %@",[XCToken stringOfType:[t tokenType]]);
    t = [tok nextToken];
    num = [t content];
    STAssertEqualObjects(num, assertedNumber, @"asserted %@, but was %@",assertedNumber,num);
    STAssertTrue([t tokenType]==NUMBER,@"asserted number, but was %@",[XCToken stringOfType:[t tokenType]]);
    index = [tok index];
    STAssertTrue(index == [str length], @"asserted %d, but was %d",[str length],index);
}
-(void) checkNumberAssertError: (NSString*) str {
    XCTokenizer * tok = XCTokFromString(str);
    NSUInteger index = [tok index];
    STAssertTrue(index == 0, @"asserted %d, but was %d",0,index);
    XCToken * t = [tok previewToken];
    STAssertTrue([t tokenType]==PARSE_ERROR,@"asserted parse error, but was %@",[XCToken stringOfType:[t tokenType]]);
}
-(void) checkNumberWithTokenizer:(XCTokenizer*) tok andAssertedValue:(double) assertedValue andIndex: (NSUInteger) assertedIndex {
    XCNumber * assertedNumber = [XCNumber numberFromDouble:assertedValue];
    NSUInteger index = [tok index];
    STAssertTrue(index == assertedIndex, @"asserted %d, but was %d",assertedIndex,index);
    XCToken * t = [tok previewToken];
    NSNumber * num = [t content];
    STAssertEqualObjects(num, assertedNumber, @"asserted %@, but was %@",assertedNumber,num);
    STAssertTrue([t tokenType]==NUMBER,@"asserted number, but was %@",[XCToken stringOfType:[t tokenType]]);
    t = [tok nextToken];
    num = [t content];
    STAssertEqualObjects(num, assertedNumber, @"asserted %@, but was %@",assertedNumber,num);
    STAssertTrue([t tokenType]==NUMBER,@"asserted number, but was %@",[XCToken stringOfType:[t tokenType]]);
}
-(void)testOperator{
    XCTokenizer * tok = XCTokFromString(@"+-*/^");
    [self fullCheckWithTokenizer: tok andAssertedIndex: 0 andContent: @"+" andType: OPERATOR];
    [self fullCheckWithTokenizer: tok andAssertedIndex: 1 andContent: @"-" andType: OPERATOR];
    [self fullCheckWithTokenizer: tok andAssertedIndex: 2 andContent: @"*" andType: OPERATOR];
    [self fullCheckWithTokenizer: tok andAssertedIndex: 3 andContent: @"/" andType: OPERATOR];
    [self fullCheckWithTokenizer: tok andAssertedIndex: 4 andContent: @"^" andType: OPERATOR];
    [self assertFinishedWithTokenizer: tok andAssertedIndex: 5];
    [self assertFinishedWithTokenizer: tok andAssertedIndex: 5];
}
-(void)testSpecial {
    XCTokenizer * tok = XCTokFromString(@"()");
    [self fullCheckWithTokenizer: tok andAssertedIndex: 0 andContent: @"(" andType: SPECIAL];
    [self fullCheckWithTokenizer: tok andAssertedIndex: 1 andContent: @")" andType: SPECIAL];
    [self assertFinishedWithTokenizer: tok andAssertedIndex: 2];

}
-(void)testWhitespace {
    XCTokenizer * tok = XCTokFromString(@" ");
    [self fullCheckWithTokenizer: tok andAssertedIndex: 0 andContent: @" " andType: WHITESPACE];
    [self assertFinishedWithTokenizer: tok andAssertedIndex: 1];

}
-(void)testNumber {
    [self checkNumberWithNumberString: @"5" andAssertedValue: 5];
    [self checkNumberWithNumberString: @".5" andAssertedValue: .5];
    [self checkNumberWithNumberString: @"1." andAssertedValue: 1.];
    [self checkNumberWithNumberString: @"1.5" andAssertedValue: 1.5];
    [self checkNumberWithNumberString: @"1.5E2" andAssertedValue: 1.5e2];
    [self checkNumberWithNumberString: @"20.505E20" andAssertedValue: 20.505e20];
    [self checkNumberAssertError: @"."];
   [self checkNumberAssertError: @".E"];
    [self checkNumberAssertError: @"1EE2"];

}
-(void)testWord {
    XCTokenizer * tok = XCTokFromString(@"A Ab Abc a aB abc √ ℯ π");
    [self fullCheckWithTokenizer:tok andAssertedIndex:0 andContent:@"A" andType:WORD];
    [self fullCheckWithTokenizer: tok andAssertedIndex: 1 andContent: @" " andType: WHITESPACE];
    [self fullCheckWithTokenizer:tok andAssertedIndex:2 andContent:@"Ab" andType:WORD];
    [self fullCheckWithTokenizer: tok andAssertedIndex: 4 andContent: @" " andType: WHITESPACE];
    [self fullCheckWithTokenizer:tok andAssertedIndex:5 andContent:@"Abc" andType:WORD];
    [self fullCheckWithTokenizer: tok andAssertedIndex: 8 andContent: @" " andType: WHITESPACE];
    [self fullCheckWithTokenizer:tok andAssertedIndex:9 andContent:@"a" andType:WORD];
    [self fullCheckWithTokenizer: tok andAssertedIndex: 10 andContent: @" " andType: WHITESPACE];
    [self fullCheckWithTokenizer:tok andAssertedIndex:11 andContent:@"aB" andType:WORD];
    [self fullCheckWithTokenizer: tok andAssertedIndex: 13 andContent: @" " andType: WHITESPACE];
    [self fullCheckWithTokenizer:tok andAssertedIndex:14 andContent:@"abc" andType:WORD];
    [self fullCheckWithTokenizer: tok andAssertedIndex: 17 andContent: @" " andType: WHITESPACE];
    [self fullCheckWithTokenizer:tok andAssertedIndex:18 andContent:@"√" andType:WORD];
     [self fullCheckWithTokenizer: tok andAssertedIndex: 19 andContent: @" " andType: WHITESPACE];
     [self fullCheckWithTokenizer:tok andAssertedIndex:20 andContent:@"ℯ" andType:WORD];
     [self fullCheckWithTokenizer: tok andAssertedIndex: 21 andContent: @" " andType: WHITESPACE];
     [self fullCheckWithTokenizer:tok andAssertedIndex:22 andContent:@"π" andType:WORD];
    [self assertFinishedWithTokenizer: tok andAssertedIndex: 23];
}
-(void)testMixed {
    XCTokenizer * tok = XCTokFromString(@"-2E3 * (.5+1.5) cos");
    [self fullCheckWithTokenizer:tok andAssertedIndex:0 andContent:@"-" andType:OPERATOR];
    [self checkNumberWithTokenizer:tok andAssertedValue:2e3 andIndex: 1];
    [self fullCheckWithTokenizer:tok andAssertedIndex:4 andContent:@" " andType:WHITESPACE];
    [self fullCheckWithTokenizer:tok andAssertedIndex:5 andContent:@"*" andType:OPERATOR];
    [self fullCheckWithTokenizer:tok andAssertedIndex:6 andContent:@" " andType:WHITESPACE];
    [self fullCheckWithTokenizer:tok andAssertedIndex:7 andContent:@"(" andType:SPECIAL];
    [self checkNumberWithTokenizer:tok andAssertedValue:.5 andIndex:8];
    [self fullCheckWithTokenizer:tok andAssertedIndex:10 andContent:@"+" andType:OPERATOR];
    [self checkNumberWithTokenizer:tok andAssertedValue:1.5 andIndex:11];
    [self fullCheckWithTokenizer:tok andAssertedIndex:14 andContent:@")" andType:SPECIAL];
    [self fullCheckWithTokenizer:tok andAssertedIndex:15 andContent:@" " andType:WHITESPACE];
    [self fullCheckWithTokenizer:tok andAssertedIndex:16 andContent:@"cos" andType:WORD];
    [self assertFinishedWithTokenizer: tok andAssertedIndex: 19];
    
}

@end
