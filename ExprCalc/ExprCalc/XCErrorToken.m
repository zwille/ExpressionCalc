//
//  XCError.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 21.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCErrorToken.h"

@implementation XCErrorToken
@synthesize index = _index;
-(id)initWithMessage:(NSString *)msg andIndex:(NSUInteger)index {
    self = [super initWithContent:msg andType:PARSE_ERROR];
    _index = index;
    return self;
}

@end
