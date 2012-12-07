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
-(NSString *)toHTMLfromChild {
    return ([self hasFocus]) ?
    [NSString stringWithFormat:@"%@_",_buf] :
    _buf;
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
        return [_root triggerDel];
    } else {
        NSRange last = {len-1,1};
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



@end
