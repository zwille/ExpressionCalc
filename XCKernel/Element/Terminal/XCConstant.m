//
//  XCConstant.m
//  TestHTML
//
//  Created by Christoph Cwelich on 07.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCConstant.h"
XCConstant * XC_EULER, * XC_PI;
@implementation XCConstant
-(id)initWithName:(NSString *)name andHTML: (NSString*) html andValue:(NSNumber *)value {
    self = [super initWithValue:value];
    _name = name;
    _html = html;
    return self;
}
+(id)constantForID:(XCConstants)cid {
    switch (cid) {
        case XC_EULER_ID:
            return XC_EULER;
        case XC_PI_ID:
            return XC_PI;
        default:
            assert(false);
            break;
    }
}
+(void)initialize {
    XC_EULER = [[XCConstant alloc] initWithName:@"ℯ"
                                        andHTML: @"&#x212f"
                                       andValue:@M_E];
    XC_PI = [[XCConstant alloc] initWithName:@"π"
                                     andHTML: @"&pi;"
                                    andValue:@M_PI];
}
-(NSString *)description {
    return _name;
}
-(NSString *)toHTML {
    return [NSString stringWithFormat: @"<csymbol>%@</csymbol>",_name];
}



@end
