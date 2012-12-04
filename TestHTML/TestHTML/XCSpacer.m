//
//  XCSpacer.m
//  TestHTML
//
//  Created by Christoph Cwelich on 04.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCSpacer.h"
#import "XCNum.h"
#import "XCNegate.h"
#import "XCInvert.h"
@implementation XCSpacer
+(id)spacerWithRoot: (XCElement*) root {
    return [[XCSpacer alloc] initWithRoot:root];
}
-(NSString *)toHTMLfromChild {
    return @"&#9643";
}
-(BOOL)isEmpty { return YES; }

-(id<XCHasTriggers>)triggerNum:(char) c {
    assert(root);
    XCNum * num = [XCNum numWithFirstChar: c];
    [[self root] replaceWithElement:num];
    return num;
}
-(id<XCHasTriggers>)triggerOperator: (XCOperator) op {
    XCElement * root = [self root];
    switch (op) {
        case XC_OP_MINUS: {
            XCNegate * rc = [XCNegate negateValue: self withRoot:root];
            [root replaceWithElement:rc];
            return rc;
        }
        case XC_OP_DIV: {
            XCInvert * rc = [XCInvert invertValue: self withRoot:root];
            [root replaceWithElement:rc];
            return rc;
        }
        default:
            return [super triggerOperator:op];
    }
    
}

@end
