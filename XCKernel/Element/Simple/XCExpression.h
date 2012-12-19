//
//  XCExpression.h
//  XCCalc
//
//  Created by Christoph Cwelich on 19.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCSimpleElement.h"

@interface XCExpression : XCSimpleElement
+(id) expressionWithElement:(XCElement*) element
               andParent:(XCElement*) parent;
@end
