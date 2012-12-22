//
//  XCExpression.h
//  XCCalc
//
//  Created by Christoph Cwelich on 19.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCValModifier.h"

@interface XCExpression : XCValModifier
+(id) expressionWithElement:(XCElement*) element
               andParent:(XCElement*) parent;
@end
