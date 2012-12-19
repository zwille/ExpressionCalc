//
//  XCProduct.m
//  XCCalc
//
//  Created by Christoph Cwelich on 19.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCProduct.h"
#import "XCInvert.h"

@implementation XCProduct
+(id)productWithElement0:(XCElement *)e0 andElement1:(XCElement *)e1 andParent:(XCElement *)parent {
    return [[XCProduct alloc] initWithParent:parent
            andFirstElement:e0 andSecondElement:e1];
}
-(NSString *)description {
    return [NSString stringWithFormat:@"*(%@, %@)",
            _content[0],_content[1]];
}
-(void) swapElements {
    XCElement * t = [self element1];
    [self setElement:[self element0] at:1];
    [self setElement:t at:0];
}
-(void)normalize {
    // normalize to (element, element) or (element, product)
    if ([_content[0] isKindOfClass:[XCProduct class]]) {
        if ([_content[1] isKindOfClass:[XCProduct class]]) { // both products
            XCProduct * p1, *p2, * p3;
            p3 = (XCProduct *) [self element1];
            p1 = (XCProduct *) [self element0];
            p2 = [XCProduct productWithElement0:[p1 element1] andElement1:p3 andParent:self];
            [p1 setElement:p2 at:1];
        } else {
            [self swapElements];
        }
    }
    [super normalize];
    // assert element1 is normalized
    
   // if ([[self parent] isKindOfClass:[XCProduct class]]) {
   //     [((XCProduct) [self parent]) shiftInvert];
   // }
    
    // normalize division
    if ([_content[0] isKindOfClass:[XCInvert class]]) {
        if ([_content[1] isKindOfClass:[XCInvert class]]) {
            // rebuild *(/,/) to /(*,*)
            [self setElement:[[self element0] content] at: 0];
            [self setElement:[[self element1] content] at: 1];
            XCElement * parent = [self parent];
            [parent replaceContentWithElement:
             [XCInvert invertValue:self withParent:parent]];
        } else if ([_content[1] isKindOfClass:[XCProduct class]]) {
            //shift invert right
            XCProduct * p = (XCProduct*) [self element1];
            assert( ![[p element0] isKindOfClass: [XCInvert class]]);
            XCElement * t = [p element0];
            [p setElement:[self element0] at:0];
            [self setElement:t at:0];
            [[self element1] normalize];
        } else {
            [self swapElements];
        }
    }
    
    // normalize sign
    // in depth
    
    
    
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
    if (isInvert[0] || isInvert[1]) {
        if (isInvert[0] && isInvert[1]) {
            NSString * tmp = [NSString stringWithFormat:mulFormat,
                    [[_content[0] content] toHTML],
                    [[_content[1] content] toHTML]];
            html = [NSString stringWithFormat:divFormat,@"1",tmp];
        }
        BOOL divIdx =  isInvert[1];
        html = [NSString stringWithFormat:
                    divFormat,
                    [_content[!divIdx] toHTML],
                    [[_content[divIdx] content] toHTML]];
    } else {
        return [NSString stringWithFormat:
                mulFormat,
                [_content[0] toHTML],
                [_content[1] toHTML]];
    }
    return [super wrapHTML: html];
    
}

//evaluate
-(NSNumber *)eval {
    return [[_content[0] eval] multNum: [_content[1] eval]];
}
@end
