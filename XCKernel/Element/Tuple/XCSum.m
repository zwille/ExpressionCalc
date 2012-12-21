//
//  XCSum.m
//  XCCalc
//
//  Created by Christoph Cwelich on 19.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCSum.h"
#import "XCNegate.h"
#import "XCExpression.h"
#import "XCSpacer.h"

@implementation XCSum
+(id)sumWithElement0:(XCElement *)e0
         andElement1:(XCElement *)e1
             andParent:(XCElement *)parent{
    return [[XCSum alloc] initWithParent:parent
                       andFirstElement:e0
                      andSecondElement:e1 ];
}
-(NSString *)description {
    return [NSString stringWithFormat:@"+(%@, %@)",
            _content[0],_content[1]];
}
-(void)normalize {
    [super normalize];
    [self normalizeToElementSelf];
    [self normalizeRShiftClass:[XCNegate class]];
}

//HTML
-(NSString *)toHTML {
    XCElement * e0 = [self element0];
    XCElement * e1 = [self element1];
    NSString * format =
    ([e1 isKindOfClass:[XCNegate class]]
     || ([e1 isKindOfClass:[XCSum class]]
     && [[((XCSum*)e1) element0] isKindOfClass:[XCNegate class]])) ?
    @"%@ %@" :
    @"%@ <mo>+</mo> %@";
    NSString * html0, * html1;
    html0 = ([e0 isKindOfClass:[XCExpression class]]) ? [e0 toHTMLFenced] : [e0 toHTML];
    html1 = ([e1 isKindOfClass:[XCExpression class]]) ? [e1 toHTMLFenced] : [e1 toHTML];
    return [super wrapHTML:
            [NSString stringWithFormat:format, html0, html1]];
}
//trigger

-(id<XCHasTriggers>)triggerOperator:(XCOperator)op {
    if (op==XC_OP_PLUS || op==XC_OP_MINUS) {
        XCElement * spacer = [XCSpacer spacerWithParent:nil];
        XCElement * newEl = (op==XC_OP_MINUS) ?
        [XCNegate negateValue:spacer withParent:nil] :
        spacer;
        newEl = [XCSum sumWithElement0:[self element1]
                   andElement1: newEl andParent:self];
        [self setElement:newEl at:1];
        return spacer;
    } else {
        return [super triggerOperator:op];
    }
}
//evaluate
-(NSNumber *)eval {
    return [[_content[0] eval] addNum: [_content[1] eval]];
}


@end
