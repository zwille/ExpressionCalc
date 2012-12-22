//
//  XCValModifier.m
//  XCCalc
//
//  Created by Christoph Cwelich on 21.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCValModifier.h"

@implementation XCValModifier

-(void)setContent:(XCElement *)c {
    if ([c isKindOfClass:[self class]]) {
        XCElement * cc = [c content];
        assert(cc);
        id p = [self parent];
        assert(p);
        [p replaceContentWithElement:cc];
    } else {
        [super setContent:c];
    }
}
-(void)normalize {
    [super normalize];
    assert(![[self content] isKindOfClass:[self class]]);
}

@end
