//
//  XCInvert.m
//  XCCalc
//
//  Created by Christoph Cwelich on 25.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCInvert.h"
#import "XCSpacer.h"
#import "XCExpression.h"
#import "XCNegate.h"
@implementation XCInvert

//invert
+(id)invertValue:(XCElement*)value  withParent:(XCElement *)parent{
    assert(![value isKindOfClass:[self class]]);
    return [[XCInvert alloc] initWithContent:value andParent:parent];
}

-(NSString *)description {
    return [NSString stringWithFormat:@"/(%@)",
            [self content]];
}

-(void)normalize {
    [super normalize];
    XCElement * c = [self content];
    if ([c isKindOfClass:[XCNegate class]]) {
        XCElement * p = [self parent];
        assert(p);
        [self setContent:[c content]];
        [p replaceContentWithElement: c];
        [c replaceContentWithElement: self];
    }
}

//HTML
-(NSString *)toHTML {
    return [super wrapHTML:
            [NSString stringWithFormat:@"<mfrac> <mn>1</mn> <mrow>%@</mrow> </mfrac>", [[self content] toHTML]]];
}
//trigger
-(id<XCHasTriggers>)triggerOperator:(XCOperator)op {
    if(op==XC_OP_DIV && [[self content] isKindOfClass:[XCSpacer class]]) {
        XCElement* element = [self content];
        id parent = [self parent];
        [parent replaceContentWithElement:element];
        return element;
    } else {
        return [super triggerOperator:op];
    }
}

//evaluate
-(NSNumber *)eval {
    NSNumber * rc = [[[self content] eval] invert];
    return [super checkErrorOn:rc];
}


@end
