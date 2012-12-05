//
//  XCExpo.m
//  TestHTML
//
//  Created by Christoph Cwelich on 05.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCExpo.h"
#import "XCSpacer.h"

@implementation XCExpo
-(id)initWithRoot:(XCElement *)root
  andFirstElement: (XCElement*) e0
 andSecondElement: (XCElement*) e1 {
    self = [super initWithRoot:root];
    [_content insertElement:e0];
    [e0 setRoot:self];
    [_content nextIndex];
    
    [_content insertElement:e1];
    [e1 setRoot:self];
    [_content nextIndex];
    
    return self;
}
+(XCExpo *)expoWithFirstElement:(XCElement *)arg0
               andSecondElement:(XCElement *)arg1
                        andRoot:(XCElement *)root {
    return [[XCExpo alloc] initWithRoot: root
                        andFirstElement: arg0
                       andSecondElement: arg1];
    
}

// override element
-(NSString *)htmlFromElement:(XCElement *)el atIndex:(NSUInteger)i andContentLength:(NSUInteger)len {
    return (i==0) ? [el toHTML] : [NSString stringWithFormat:@"<sup>%@</sup>", [el toHTML]];
}
// override trigger
-(id<XCHasTriggers>)triggerOperator:(XCOperator)op {
    switch (op) {
        case XC_OP_PLUS:
        case XC_OP_MINUS:
        case XC_OP_MULT:
        case XC_OP_DIV:
            return [super triggerOperator:op];
        case XC_OP_EXP: {
            XCSpacer * spacer = [XCSpacer spacerWithRoot:self];
            [_content insertElement:spacer];
            [_content nextIndex];
            return spacer;
        }
        default:
            assert(false);
    }
    return nil;
}
@end
