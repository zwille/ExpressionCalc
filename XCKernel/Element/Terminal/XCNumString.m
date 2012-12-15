//
//  XCNum.m
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCNumString.h"
#import "XCHasTriggers.h"


static NSNumberFormatter * formatter;
@implementation XCNumString
+(void)initialize {
    formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    XC_PT = [[formatter decimalSeparator] characterAtIndex:0];
}
-(id)init{
    self = [super init];
    _buf = [NSMutableString stringWithCapacity:4];
    return self;
}
-(id)initWithString:(NSString*)str{
    self = [super init];
    _buf = [NSMutableString stringWithString:str];
    return self;
}
+(XCNumString*) numWithFirstChar: (char) c {
    XCNumString * rc = [[XCNumString alloc] init];
    return (XCNumString*)[rc triggerNum:c];
}
+(XCNumString *)numWithString:(NSString *)str {
    return [[XCNumString alloc] initWithString:str];
}
-(NSString *)description{
    return _buf;
}
-(NSString *)toHTML {
    NSString * rc = [NSString stringWithFormat:@"<mn>%@</mn>",_buf];
    return [super wrapHTML: ([self hasFocus]) ?
    [NSString stringWithFormat:@"%@<mo>_</mo>",rc] :
    rc];
}

//evaluate
-(NSNumber *)eval {
    NSNumber * rc = [formatter numberFromString:_buf];
    [self setError: ([rc isNaN])];
    return rc;
}
//trigger
-(id<XCHasTriggers>)triggerNum:(char)c {
    if (c==XC_PT) {
        // suppress second decimal point
        if (_state.hasDecimalPt) {
            return self;
        }
        _state.hasDecimalPt = YES;
    }
    [_buf appendFormat: @"%c",c];
    return self;
}
-(id<XCHasTriggers>)triggerDel {
    NSUInteger len = [_buf length];
    if (len < 2) {
        return [super triggerDel];
    } else {
        NSUInteger i = len-1;
        NSRange last = {i,1};
        if ([_buf characterAtIndex:i]==XC_PT) {
            _state.hasDecimalPt = NO;
        }
        [_buf deleteCharactersInRange:last];
        return self;
    }
}
-(BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        return [[self eval] isEqual:[object eval]];
    }
    return false;
}
-(id)copyWithZone:(NSZone *)zone {
    XCNumString * rc = [super copyWithZone:zone];
    rc->_buf = [_buf mutableCopy];
    return rc;
}


@end
