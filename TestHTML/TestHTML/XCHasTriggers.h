//
//  XCHasTriggers.h
//  TestHTML
//
//  Created by Christoph Cwelich on 04.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {XC_OP_PLUS, XC_OP_MINUS, XC_OP_MULT, XC_OP_DIV, XC_OP_EXP} XCOperator;
typedef enum {
    XC_FN_SQRT, XC_FN_LN, XC_FN_EXP,
    XC_FN_COS, XC_FN_SIN, XC_FN_TAN,
    XC_FN_ACOS, XC_FN_ASIN, XC_FN_ATAN} XCFunctionSymbol;
@protocol XCHasTriggers <NSObject>
-(id<XCHasTriggers>)triggerNum:(char) c;
-(id<XCHasTriggers>)triggerOperator: (XCOperator) op;
-(id<XCHasTriggers>)triggerEnter;
-(id<XCHasTriggers>)triggerNext;
-(id<XCHasTriggers>)triggerPrevious;
-(id<XCHasTriggers>)triggerDel;
-(id<XCHasTriggers>)triggerExpression;
-(id<XCHasTriggers>)triggerFunction: (XCFunctionSymbol) fn;
@end
