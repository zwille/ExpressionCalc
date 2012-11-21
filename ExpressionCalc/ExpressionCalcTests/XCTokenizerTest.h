//
//  XCTokenizerTest.h
//  ExpressionCalc
//
//  Created by Christoph Cwelich on 20.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface XCTokenizerTest : SenTestCase
-(void)testOperator;
-(void)testNumber;
-(void)testSpecial;
-(void)testWhitespace;
-(void)testMixed;
@end
