//
//  XCStorage.m
//  TestHTML
//
//  Created by Christoph Cwelich on 07.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCStorage.h"

@implementation XCStorage

-(id)initWithValue:(NSNumber *)value {
    self = [super init];
    _value = value;
    return self;
}
-(NSNumber *)value {
    return _value;
}
-(NSString *)toHTML {
    assert(false);
    return nil;
}
-(NSString *)toHTMLFenced {
    return [NSString stringWithFormat:@"<mfenced separators=\" \">%@</mfenced>",[self toHTML]];
}


@end
