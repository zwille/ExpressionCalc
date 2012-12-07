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

// override element
-(NSString *)htmlFromElement:(XCElement *)el atIndex:(NSUInteger)i andContentLength:(NSUInteger)len {
    if (i==0) {
        return [el toHTML];
    } else {
        return ([el isKindOfClass:[XCInvert class]]) ?
        [NSString stringWithFormat:@" / %@",[[el content] toHTML]] :
        [NSString stringWithFormat:@" &#8901; %@",[el toHTML]];
    }
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
