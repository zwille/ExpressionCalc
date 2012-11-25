//
//  XCLiteral.h
//  ExpressionCalc
//
//  Created by Christoph Cwelich on 21.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCElementParser.h"
#import "XCElement.h"
#import "XCHasValue.h"

@interface XCLiteral : XCElement <XCElementParser, XCHasValue>

@end
