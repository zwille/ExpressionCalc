//
//  XCPower.h
//  ExprCalc
//
//  Created by Christoph Cwelich on 21.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCElement.h"
#import "XCElementParser.h"
#import "XCHasValue.h"

@interface XCPower : XCElement<XCElementParser,XCHasValue> {
    NSMutableArray * operands;
}

@end
