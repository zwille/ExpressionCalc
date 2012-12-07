//
//  NSNumber+XCNumber.h
//  TestHTML
//
//  Created by Christoph Cwelich on 07.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCFuncAlg.h"
/**
 * returns YES if overflows
 */
BOOL mulOverflows(long * result,long a, long b);
/**
 * returns YES if overflows
 */
BOOL addOverflows(long * result, long a, long b);
BOOL isInteger(NSNumber * val);
BOOL bothInteger(NSNumber * a, NSNumber * b);
@interface NSNumber (XCNumber)
-(NSNumber*) addNum: (NSNumber*) rhs;
-(NSNumber*) multNum: (NSNumber*) rhs;
-(NSNumber*) powExp: (NSNumber*) exp;
-(NSNumber*) invert;
-(NSNumber*) negate;

-(BOOL) isInteger;
-(BOOL) isReal;
-(BOOL) isNaN;
-(BOOL) isZero;

@end
