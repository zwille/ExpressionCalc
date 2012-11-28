//
//  XCConstant.h
//  ExprCalc
//
//  Created by Christoph Cwelich on 23.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCLiteral.h"
#import "XCNumber.h"
#import "XCHasValue.h"

@interface XCConstant : XCLiteral<XCElementParser, XCHasValue> {
    XCNumber * _value;
    NSString * _name;
}
@property (strong) NSString * name;


@end

