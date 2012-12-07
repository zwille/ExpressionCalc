//
//  XCGlobal.h
//  TestHTML
//
//  Created by Christoph Cwelich on 07.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//


#import <Foundation/Foundation.h>
typedef enum {
    XC_OP_PLUS,
    XC_OP_MINUS,
    XC_OP_MULT,
    XC_OP_DIV,
    XC_OP_EXP} XCOperator;
typedef enum {
    XC_EULER_ID,
    XC_PI_ID
} XCConstants;
 /*typedef enum {
    XC_FN_SQRT, XC_FN_LN, XC_FN_EXP,
    XC_FN_COS, XC_FN_SIN, XC_FN_TAN,
    XC_FN_ACOS, XC_FN_ASIN, XC_FN_ATAN} XCFunctionSymbol;*/
extern NSString
    * XC_HTML_FOCUS_FORMAT,
    * XC_HTML_ERROR_FORMAT,
    * XC_SQRT;
extern const char XC_PT;

@interface XCGlobal : NSObject

@end
