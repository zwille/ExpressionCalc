//
//  XCProd.m
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCProd.h"
#import "XCInvert.h"
#import "XCSpacer.h"
#import "XCExpo.h"
#import "XCExpr.h"

@implementation XCProd
-(id)initWithRoot:(XCElement *)root
  andFirstElement: (XCElement*) e0
 andSecondElement: (XCElement*) e1
 isMultiplication: (BOOL) isMult {
    self = [super initWithRoot:root];
    [_content insertElement:e0];
    [e0 setRoot:self];
    [_content nextIndex];
    if(isMult) {
        [_content insertElement:e1];
        [e1 setRoot:self];
        [_content nextIndex];
    } else {
        XCInvert * inv = [XCInvert invertValue:e1 withRoot:self];
        [_content insertElement:inv];
        [_content nextIndex];
    }
    return self;
}
+(XCProd *)prodWithFirstElement:(XCElement *)arg0
               divSecondElement:(XCElement *)arg1
                        andRoot:(XCElement *)root {
    return [[XCProd alloc] initWithRoot: root andFirstElement:arg0 andSecondElement:arg1 isMultiplication:NO];
    
}
+(XCProd *)prodWithFirstElement:(XCElement *)arg0
               multSecondElement:(XCElement *)arg1
                        andRoot:(XCElement *)root {
    return [[XCProd alloc] initWithRoot: root andFirstElement:arg0 andSecondElement:arg1 isMultiplication:YES];
    
}
-(void) appendElement: (XCElement*) el
             toBuffer: (NSMutableString*) buf
           withFormat: (NSString*)format{
    NSString * html = nil;
    if([el isKindOfClass:[XCInvert class]]) {
        XCElement * content = [el content];
        html = [el wrapHTML:
                ([content isKindOfClass:[XCExpr class]]) ?
                [content toHTMLFenced] :
                [content toHTML]];
    } else {
        html = ([el isKindOfClass:[XCExpr class]]) ?
         [el toHTMLFenced] :
         [el toHTML];
    }
    [buf appendString: [NSString stringWithFormat:format, html]];
}
-(NSString*) buildRowWithArray: (NSArray*) a {
    NSUInteger len = [a count];
    assert(len>0);
    if (len > 1) {
        NSMutableString * buf = [[NSMutableString alloc] init];
        [self appendElement:a[0] toBuffer:buf withFormat:@"%@"];
        for (int i=1; i<len; i++) {
            [self appendElement:a[i] toBuffer:buf withFormat:@"<mo>&#8901;</mo>%@"];
        }
        return buf;
    } else {
        XCElement * el = a[0];
        return ([el isKindOfClass:[XCInvert class]]) ?
        [el wrapHTML: [[el content] toHTML]] :
        [el toHTML];
    }
}
-(NSString *)toHTML {
    NSMutableArray * num, * denom;
    num = [[NSMutableArray alloc] init];
    denom = [[NSMutableArray alloc] init];
    for (XCElement * el in _content) {
        if ([el isKindOfClass:[XCInvert class]]) {
            [denom addObject: el];
        } else {
            [num addObject:el];
        }
    }
    NSUInteger numlen = [num count], denomlen = [denom count];
    NSString * bufNum, * bufDenom;
    if (numlen) {
        bufNum = [self buildRowWithArray: num];
    } else {
        bufNum = @"<mn>1</mn>";
    }
    if (denomlen) {
        bufDenom = [self buildRowWithArray: denom];
    } else {
        return [super wrapHTML:bufNum];
    }
    return [super wrapHTML: [NSString stringWithFormat:
            @"<mfrac> <mrow>%@</mrow> <mrow>%@</mrow> </mfrac>",
            bufNum, bufDenom]];

}

// override trigger
-(id<XCHasTriggers>)triggerOperator:(XCOperator)op {
    if (op==XC_OP_PLUS || op==XC_OP_MINUS) {
        return [super triggerOperator:op];
    }
    XCElement * spacer = [XCSpacer spacerWithRoot:self];
    XCElement * newEl = spacer;
    if(op==XC_OP_MULT || op==XC_OP_DIV) {
        if (op==XC_OP_DIV) {
            newEl = [XCInvert invertValue:spacer withRoot:self];
        }
        [_content insertElement:newEl];
        [_content nextIndex];
        return spacer;
    }
    assert(op==XC_OP_EXP);
    XCElement * e0 = [_content currentElement];
    XCElement * target = self;
    //pull out XCInvert
    if ([e0 isKindOfClass:[XCInvert class]]) {
        target = e0;
        e0 = [e0 content];
    }
    newEl = [XCExpo expoWithFirstElement:e0
                        andSecondElement:spacer
                                 andRoot:self];
    [target replaceContentWithElement:newEl];
    return spacer;
}

//evaluate
-(NSNumber *)eval {
    NSNumber * prod = @1;
    for (XCElement * e in _content) {
        prod = [prod multNum:[e eval]];
    }
    return prod;
}
@end
