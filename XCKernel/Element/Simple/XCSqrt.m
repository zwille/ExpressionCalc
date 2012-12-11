//
//  XCSqrt.m
//  XCCalc
//
//  Created by Christoph Cwelich on 11.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCSqrt.h"

@implementation XCSqrt
-(NSString *)toHTML {
    return [super wrapHTML: [NSString stringWithFormat:
            @"<msqrt>%@</msqrt> %@",_name, [[self content] toHTML]]];
}
@end
