//
//  XCConstant.m
//  TestHTML
//
//  Created by Christoph Cwelich on 07.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCConstant.h"

@implementation XCConstant
-(id)initWithName:(NSString *)name andValue:(NSNumber *)value {
    self = [super initWithValue:value];
    _name = name;
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
    XC_EULER = [[XCConstant alloc] initWithName:@"ℯ" andValue:@M_E];
    XC_PI = [[XCConstant alloc] initWithName:@"π" andValue:@M_PI];
}
-(NSString *)description {
    return _name;
}
-(NSString *)toHTML {
    return _name;
}

@end
