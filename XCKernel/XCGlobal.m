//
//  XCGlobal.m
//  XCCalc
//
//  Created by Christoph Cwelich on 07.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCGlobal.h"
NSString
    * XC_HTML_FOCUS_FORMAT = @"<b>%@</b>",
    * XC_HTML_ERROR_FORMAT = @"<font color=\"red\">%@</font>",
    * XC_SQRT = @"√";
char XC_PT = '.'; // overridden by XCNumString
const NSUInteger XC_ANS_IDX = 10;

static XCGlobal * _instance;
@implementation XCGlobal
@synthesize angleAsDegree = _angleAsDegree;
+(void)initialize {
    _instance = [[XCGlobal alloc] init];
}
-(id)init {
    self = [super init];
    _angleAsDegree = YES;
    return self;
}
+(id)instance {
    return _instance;
}


@end
