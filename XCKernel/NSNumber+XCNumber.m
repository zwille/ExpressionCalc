//
//  NSNumber+XCNumber.m
//  TestHTML
//
//  Created by Christoph Cwelich on 07.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "NSNumber+XCNumber.h"


int sgn(long a) {
    return (a<0) ? -1 : (a>0) ? 1 : 0;
}

BOOL mulOverflows(long * result, long a, long b) {
    if (a && b) { //both not nor
        *result = a*b;
        return a == *result / b;
    }
    *result = 0;
    return NO;
}
BOOL addOverflows(long * result, long a, long b) {
    if ((b > 0 && a > LONG_MAX - b) 
        || (b < 0 && a < LONG_MIN - b)) {
            *result = -1;
            return YES;
        }
    *result = a + b;
    return NO;
}

long lpow(long x, unsigned int exp) {
    long rc = 1;
    int odd;
    while(exp>0) {
        odd = exp&1;
        exp >>=1;
        if(odd && mulOverflows(&rc, x, rc)) {
            return -1;
        }
        if(mulOverflows(&x, x, x)) {
            return -1;
        }
    }
    return rc;
}
BOOL isInteger(NSNumber * val) {
    const char * t = [val objCType];
    return 
    !strcmp(t, @encode(int)) ||
    !strcmp(t, @encode(long));
}
BOOL bothInteger(NSNumber * a, NSNumber * b) {
    return isInteger(a) && isInteger(b);
}

@implementation NSNumber (XCNumber)
-(NSNumber *)addNum:(NSNumber *)rhs {
    if(bothInteger(self, rhs)) {
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
        long b = [self longValue];
        long e = [exp longValue];
        long c = -1;
        if ((e < sizeof(long)*8-1) // max value for base == 2
            && (c = lpow(b, e)) > -1) {
            return [NSNumber numberWithLong: c];
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
    if(isInteger(self)) {
        long rc = [self longValue];
        if (rc!=LONG_MIN) {
            return [NSNumber numberWithLong:-rc];
        }
    }
    return [NSNumber numberWithDouble: -[self doubleValue]];
}

-(BOOL)isInteger {
    return isInteger(self);
}

-(BOOL)isNaN {
    return !isInteger(self) && [self doubleValue] == NAN;
}

-(BOOL)isZero {
    if (isInteger(self)) {
        return [self longValue] == 0;
    } else {
        return abs([self doubleValue]) < 1e-15;
    }
}

@end
