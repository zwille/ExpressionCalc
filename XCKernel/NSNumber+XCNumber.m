//
//  NSNumber+XCNumber.m
//  XCCalc
//
//  Created by Christoph Cwelich on 07.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "NSNumber+XCNumber.h"
#define EPS  1e-15

//used by mulOverflows
//returns 0xfffffff for negative values else 0
//neg ^ neg = pos
//neg ^ pos = neg
//pos ^ neg = neg
//pos ^ pos = pos
int msgn(long a) {
    return (a<0) ? -1 : 0;
}
// return YES if a*b overflows
BOOL mulOverflows(long * result, long a, long b) {
    if (a && b) { //both not zero
        *result = a*b;
        return (msgn(a)^msgn(b)) != msgn(*result)
            || a != *result / b;
        //sgn check due to EXC_ARITHMETIC: a=LONG_MIN, b=-1
    }
    *result = 0;
    return NO;
}

// return YES if a+b overflows
BOOL addOverflows(long * result, long a, long b) {
    if ((b > 0 && a > LONG_MAX - b) 
        || (b < 0 && a < LONG_MIN - b)) {
            *result = -1;
            return YES;
        }
    *result = a + b;
    return NO;
}
// return the position of the leftmost bit
// = ceil( log(x) / log(2) )
unsigned int lbit(long x) {
    unsigned int rc = 0;
    if (x<0) {
        if (x==LONG_MIN) {
            return sizeof(long)*8;
        }
        x=-x;
    }
    while (x) {
        x >>=1;
        ++rc;
    }
    return rc;
}
/*
 guessed the max left bit of the result of lpow and rejects higher base & exp values
 examples:
 base   exp lbit(base)*exp lb(base^exp) error
 4      10  30             20           10
 4      15  45             30           15
 7      11  28             30.88        <3
 7      12  36             33.68        <3
 15     7   28             27.35        <1
 15     8   32             31.25        <1
 63     5   30             29.89        <1
 63     6   36             35.86        <1
 */
BOOL isLPowNoOverflowGuessed(long base, unsigned int exp) {
    return lbit(base) * exp < sizeof(long)*8-1;
}

long lpow(long x, unsigned int exp) {
    long rc = 1;
    int odd;
    while(exp) {
        odd = exp&1;
        exp >>=1;
        if(odd) rc*=x;
        x*=x;
    }
    return rc;
}

BOOL isObjcTypeInteger(NSNumber * val) {
    const char * t = [val objCType];
    return 
    !strcmp(t, @encode(int)) ||
    !strcmp(t, @encode(long));
}

BOOL bothInteger(NSNumber * a, NSNumber * b) {
    return [a isInteger] && [b isInteger];
}

@implementation NSNumber (XCNumber)
+(NSNumber *)nan {
    return [NSNumber numberWithDouble:NAN];
}

-(NSNumber *)addNum:(NSNumber *)rhs {
    if(bothInteger(self, rhs)) {
        // try int
        long a = [self longValue];
        long b = [rhs longValue];
        long result = 0;
        if (! addOverflows(&result, a, b)) {
            return [NSNumber numberWithLong: result];
        }
        // here overflow continue with double
    }
    return [NSNumber numberWithDouble: [self doubleValue] + [rhs doubleValue]];
}
-(NSNumber *)multNum:(NSNumber *)rhs {
    if(bothInteger(self, rhs)) {
        //try int
        long a = [self longValue];
        long b = [rhs longValue];
        long result = 0;
        if (! mulOverflows(&result, a, b)) {
            return [NSNumber numberWithLong: result];
        }
        // here overflow continue with double
    }
    return [NSNumber numberWithDouble: [self doubleValue] * [rhs doubleValue]];
}
-(NSNumber *)powExp:(NSNumber *)exp {
    if(bothInteger(self, exp)) {
        //try int
        long b = [self longValue];
        long e = [exp longValue];
        if (e>=0 // neg exp leads to results <1
            && (e<2 // exponents <2 okay
            || (e<sizeof(long)*8 // exponent in range of long
                && isLPowNoOverflowGuessed(b, (unsigned int)e) //guessing
            ))) {
            long result = lpow(b, e);
            return [NSNumber numberWithLong: result];
        }
        // here overflow continue with double
    }
    return [NSNumber numberWithDouble:
            pow([self doubleValue], [exp doubleValue])];
}
-(NSNumber *)invert {
    return [NSNumber numberWithDouble: ([self isZero]) ?
    NAN :
    1.0 / [self doubleValue]];
}
-(NSNumber *)negate {
    if(isObjcTypeInteger(self)) {
        long rc = [self longValue];
        if (rc!=LONG_MIN) {
            return [NSNumber numberWithLong:-rc];
        }
    }
    return [NSNumber numberWithDouble: -[self doubleValue]];
}

-(BOOL)isInteger {
    double d = [self doubleValue];
    return isObjcTypeInteger(self) || (fabs(d - (long)d) < EPS);
}

-(BOOL)isNaN {
    return !isObjcTypeInteger(self) && isnan([self doubleValue]);
}

-(BOOL)isZero {
    if (isObjcTypeInteger(self)) {
        return [self longValue] == 0;
    } else {
        double d = [self doubleValue];
        return (isnan(d)) ?
        NO :
        fabs([self doubleValue]) < EPS;
    }
}


@end
