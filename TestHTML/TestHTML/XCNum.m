//
//  XCNum.m
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCNum.h"

@implementation XCNum
-(id)init{
    self = [super init];
    str = [NSMutableString stringWithCapacity:4];
    return self;
}
+(XCNum*) numWithFirstChar: (char) c {
    XCNum * rc = [[XCNum alloc] init];
    return (XCNum*)[rc triggerNum:c];
}
-(XCElement *)triggerNum:(char)c {
    [str appendFormat: @"%c",c];
    return self;
}
-(XCElement *)triggerDel {
    NSUInteger len = [str length];
    if (len < 2) {
        return [_root triggerDel];
    } else {
        NSRange last = {len-1,1};
        [str deleteCharactersInRange:last];
        return self;
    }
}
-(NSString *)description{
    return str;
}
-(NSString *)toHTML {
    return str;
}


@end
