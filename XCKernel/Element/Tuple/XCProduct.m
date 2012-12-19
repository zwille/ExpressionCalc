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
+(id)productWithElement0:(XCElement *)e0 andElement1:(XCElement *)e1 andRoot:(XCElement *)root {
    return [[XCProduct alloc] initWithRoot:root
            andFirstElement:e0 andSecondElement:e1];
}
-(NSString *)description {
    return [NSString stringWithFormat:@"*(%@, %@)",
            _content[0],_content[1]];
}

-(void)normalize {
    
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
