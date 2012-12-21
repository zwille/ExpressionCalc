//
//  XCStatement.m
//  TestHTML
//
//  Created by Christoph Cwelich on 07.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCStatement.h"
#import "XCExpression.h"
#import "XCSpacer.h"

@implementation XCStatement
@synthesize store;
-(id)init {
    self = [super initWithContent:nil andParent:nil];
    [self reset];
    return self;
}
+(id)emptyStatement {
    return [[XCStatement alloc] init];
}
-(void)reset {
    [self setContent: [XCSpacer spacerWithParent:self]];
    _store = nil;
}
-(BOOL)isEmpty {
    return [[self content] isEmpty];
}

-(NSString *)description {
    return (_store) ?
    [NSString stringWithFormat:@"<%@ := %@>",_store,[self content]] :
    [NSString stringWithFormat:@"<%@>",[self content]];
}
-toHTML {
    XCElement * c = [self content];
    NSString * html = ([c isKindOfClass:[XCExpression class]]) ?
                        [c toHTMLFenced] : [c toHTML];
    return (_store) ?
    [NSString stringWithFormat:@"%@<mo>&larr;</mo>%@",[_store toHTML],html]: html;
   
}
-(NSNumber *)eval {
    XCElement * content = [self content];
    NSNumber * rc = ([content isEmpty]) ? @0 : [content eval];
    if (_store) {
        [_store setNumericValue:rc];
    }
    //always store in ans
    [[XCVariable variableForIndex:XC_ANS_IDX] setNumericValue:rc];
    
    return rc;
}

//trigger
-(id<XCHasTriggers>)triggerAssign: (NSUInteger)varIdx {
    _store = [XCVariable variableForIndex: varIdx ];
    return [self content];
}
-(id<XCHasTriggers>)triggerDel {
    [self reset];
    return [self head];
}

-(id<XCHasTriggers>)triggerNext {
    return _content;
}
-(id<XCHasTriggers>)triggerNextContent {
    return _content;
}
-(id<XCHasTriggers>)triggerPrevious {
    return _content;
}
-(id<XCHasTriggers>)triggerPreviousContent {
    return _content;
}
//copy
-(id)copyWithZone:(NSZone *)zone {
    XCStatement * rc = [super copyWithZone:zone];
    rc->_store = _store;
    return rc;
}
//private


@end
