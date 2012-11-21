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
    STAssertTrue([[t content] isEqualToString: assertedContent],@"asserted %@, but was %@",assertedContent,[t content]);
    STAssertTrue([t tokenType]==assertedType,@"asserted %@, but was %@",assertedType,[t tokenType]);
    t = [tok nextToken];
    STAssertTrue([[t content] isEqualToString: assertedContent],@"asserted %@, but was %@",assertedContent,[t content]);
    STAssertTrue([t tokenType]==assertedType,@"asserted %@, but was %@",assertedType,[t tokenType]);
}
-(void) assertFinishedWithTokenizer: (XCTokenizer*) tok andAssertedIndex: (NSUInteger) assertedIndex {
    NSUInteger index = [tok index];
    STAssertTrue(index == assertedIndex,@"asserted %d, but was %d",assertedIndex,index);
    XCToken * t = [tok previewToken];
    //  NSLog(@">>> %@",t);
    STAssertNil([t content], @"asserted nil, but was %@",[t content]);
    STAssertTrue([t tokenType]==END_OF_STATEMENT,nil);
    t = [tok nextToken];
    STAssertNil([t content], @"asserted nil, but was %@",[t content]);
    STAssertTrue([t tokenType]==END_OF_STATEMENT,nil);
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
    STAssertTrue([t tokenType]==NUMBER,nil);
    t = [tok nextToken];
    num = [t content];
    STAssertEqualObjects(num, assertedNumber, @"asserted %@, but was %@",assertedNumber,num);
    STAssertTrue([t tokenType]==NUMBER,nil);
    index = [tok index];
    STAssertTrue(index == [str length], @"asserted %d, but was %d",[str length],index);
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
    [self fullCheckWithTokenizer: tok andAssertedIndex: 0 andContent: @"(" andType: OPERATOR];
    [self fullCheckWithTokenizer: tok andAssertedIndex: 1 andContent: @")" andType: OPERATOR];
    [self assertFinishedWithTokenizer: tok andAssertedIndex: 2];

}
-(void)testWhitespace {
    XCTokenizer * tok = XCTokFromString(@" ");
    [self fullCheckWithTokenizer: tok andAssertedIndex: 0 andContent: @" " andType: OPERATOR];
    [self assertFinishedWithTokenizer: tok andAssertedIndex: 1];

}
-(void)testNumber {
    [self checkNumberWithNumberString: @"5" andAssertedValue: 5];
   [self checkNumberWithNumberString: @".5" andAssertedValue: .5];
    /* [self checkNumberWithNumberString: @"1." andAssertedValue: 1.];
    [self checkNumberWithNumberString: @"1.5" andAssertedValue: 1.5];
    [self checkNumberWithNumberString: @"1.5E2" andAssertedValue: 1.5e2];
    [self checkNumberWithNumberString: @"20.505E20" andAssertedValue: 20.505e20];*/
    
}
@end
