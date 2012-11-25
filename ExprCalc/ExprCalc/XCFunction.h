//
//  XCFunction.h
//  ExprCalc
//
//  Created by Christoph Cwelich on 23.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCLiteral.h"
#import "XCFunctionPrototype.h"
#import "XCHasValue.h"

@interface XCFunction : XCLiteral<XCElementParser, XCHasValue> {
    XCFunctionPrototype * _prototype;
    id<XCHasValue> _arg;
}


@end
