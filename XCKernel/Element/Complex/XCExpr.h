//
//  XCExpr.h
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCComplexElement.h"

@interface XCExpr : XCComplexElement
+(XCExpr*) emptyExpressionWithRoot: (XCElement*) root;
+(XCExpr*) expressionWithElement: (XCElement*) first
                         andRoot: (XCElement*) root;

@end