//
//  XCFunctionPrototypeTest.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 26.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCFunctionPrototypeTest.h"
#import "XCFunctionPrototype.h"
#import "Symbols.h"

@implementation XCFunctionPrototypeTest
-(void) testPrototypeBySymbol {
    XCFunctionPrototype * fp = [XCFunctionPrototype prototypeBySymbol:FN_COS];
    NSString * fpname = [fp name];
    STAssertTrue([fpname isEqualToString:@"cos"], nil);
    func_t actualFunc = [fp function];
    STAssertTrue(actualFunc(0)==1, nil);
}
-(void) testPrototypeByName {
    XCFunctionPrototype * fp = [XCFunctionPrototype prototypeByName:@"cos"];
    STAssertTrue([fp function]==cos, nil);

}
@end
