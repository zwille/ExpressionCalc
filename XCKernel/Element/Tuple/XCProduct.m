//
//  XCProduct.m
//  XCCalc
//
//  Created by Christoph Cwelich on 19.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCProduct.h"
#import "XCInvert.h"
#import "XCExpression.h"
#import "XCSum.h"
#import "XCSpacer.h"
#import "XCNegate.h"

@implementation XCProduct
+(id)productWithElement0:(XCElement *)e0 andElement1:(XCElement *)e1 andParent:(XCElement *)parent {
    return [[XCProduct alloc] initWithParent:parent
            andFirstElement:e0 andSecondElement:e1];
}
-(NSString *)description {
    return [NSString stringWithFormat:@"*(%@, %@)",
            _content[0],_content[1]];
}
   
-(void)normalize {
    [super normalize];
    // assert element1 is normalized
    [self normalizeToElementSelf];
    [self normalizeRShiftClass:[XCInvert class]];
    // normalize sign
    for (NSUInteger i=0; i<2; i++) {
        if([_content[i] isKindOfClass:[XCNegate class]]) {
            [self setElement:[_content[i] content] at: i];
            XCElement * parent = [self parent];
            assert(parent);
            [parent replaceContentWithElement:
             [XCNegate negateValue:self withParent:parent]];
        }
    }   
}
// trigger
-(id<XCHasTriggers>)triggerOperator:(XCOperator)op {
    if (op==XC_OP_MULT || op==XC_OP_DIV) {
        XCElement * spacer = [XCSpacer spacerWithParent:nil];
        XCElement * newEl = (op==XC_OP_DIV) ?
        [XCInvert invertValue:spacer withParent:nil] :
        spacer;
        newEl = [XCProduct productWithElement0:[self element1]
                           andElement1: newEl andParent:self];
        [self setElement:newEl at:1];
        return spacer;
    } else {
        return [super triggerOperator:op];
    }
}
//HTML

-(NSString *)toHTML {
    BOOL isInvert[2];
    NSString * mulFormat = @"%@ <mo>&#8901;</mo> %@",
    * divFormat = @"<mfrac> <mrow>%@</mrow> <mrow>%@</mrow> </mfrac>";
    NSString * html = nil;
    for (int i=0; i<2; i++) {
        isInvert[i] = [_content[i] isKindOfClass:[XCInvert class]];
    }
    if (isInvert[0] || isInvert[1]) { // div
        if (isInvert[0] && isInvert[1]) {
            NSString * h[2];
            for (int i=0; i<2; i++) {
                XCElement * c = _content[i];
                h[i] = [c wrapHTML: [[c content] toHTML]];
            }
            NSString * tmp = [NSString stringWithFormat:mulFormat,h[0],h[1]];
            html = [NSString stringWithFormat:divFormat,@"<mn>1</mn>",tmp];
        } else {
            BOOL divIdx =  isInvert[1];
            XCElement * num = _content[!divIdx],
                * denom = _content[divIdx];
            html = [NSString stringWithFormat:
                    divFormat,
                    [num toHTML],
                    [denom wrapHTML:[[denom content] toHTML]]];
        }
    } else { // mul
        NSString * h[2];
        for (int i=0; i<2; i++) {
            XCElement * c = _content[i];
            h[i] = ([c isKindOfClass:[XCExpression class]]
                    || [c isKindOfClass:[XCSum class]]
                    || [c isKindOfClass:[XCNegate class]]) ?
            [c toHTMLFenced] : [c toHTML];
        }
        return [super wrapHTML:
                [NSString stringWithFormat:mulFormat, h[0], h[1]]];
    }
    return [super wrapHTML: html];
    
}

//evaluate
-(NSNumber *)eval {
    return [[_content[0] eval] multNum: [_content[1] eval]];
}
@end
