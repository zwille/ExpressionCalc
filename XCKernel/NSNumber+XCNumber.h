//
//  NSNumber+XCNumber.h
//  XCCalc
//
//  Created by Christoph Cwelich on 07.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCFuncAlg.h"

@interface NSNumber (XCNumber)
+(NSNumber*) nan;
-(NSNumber*) addNum: (NSNumber*) rhs;
-(NSNumber*) multNum: (NSNumber*) rhs;
-(NSNumber*) powExp: (NSNumber*) exp;
-(NSNumber*) invert;
-(NSNumber*) negate;

-(BOOL) isInteger;
-(BOOL) isNaN;
-(BOOL) isZero;

@end
