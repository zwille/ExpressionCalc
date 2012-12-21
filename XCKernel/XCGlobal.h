//
//  XCGlobal.h
//  XCCalc
//
//  Created by Christoph Cwelich on 07.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//


#import <Foundation/Foundation.h>
#ifndef DLOG
#ifdef DEBUG
#   define DLOG(...) NSLog(__VA_ARGS__)
#else
#   define DLOG(...) /* */
#endif
#endif

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

extern NSString
    * XC_HTML_FOCUS_FORMAT,
    * XC_HTML_ERROR_FORMAT,
    * XC_SQRT;

extern char XC_PT; 
extern const NSUInteger XC_ANS_IDX;

@interface XCGlobal : NSObject {
    BOOL _angleAsDegree; // else rad
}
@property (readwrite) BOOL angleAsDegree;
+(id) instance;

@end
