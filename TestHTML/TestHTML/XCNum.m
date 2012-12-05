//
//  XCNum.m
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCNum.h"
#import "XCHasTriggers.h"
static NSNumberFormatter * formatter;
@implementation XCNum
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
+(XCNum*) numWithFirstChar: (char) c {
    XCNum * rc = [[XCNum alloc] init];
    return (XCNum*)[rc triggerNum:c];
}
+(XCNum *)numWithString:(NSString *)str {
    return [[XCNum alloc] initWithString:str];
}
-(NSString *)description{
    return _buf;
}
-(NSString *)toHTMLfromChild {
    return ([self hasFocus]) ?
    [NSString stringWithFormat:@"%@_",_buf] :
    _buf;
}
-(NSNumber *)numericValue {
    return [formatter numberFromString:_buf];
}
//trigger
-(id<XCHasTriggers>)triggerNum:(char)c {
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
        return [[self numericValue] isEqual:[object numericValue]];
    }
    return false;
}



@end
