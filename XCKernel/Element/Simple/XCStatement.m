//
//  XCStatement.m
//  XCCalc
//
//  Created by Christoph Cwelich on 07.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCStatement.h"
#import "XCExpression.h"
#import "XCSpacer.h"

@implementation XCStatement
@synthesize store;
//init
-(id)init {
    self = [super initWithContent:nil andParent:nil];
    [self reset];
    return self;
}
+(id)emptyStatement {
    return [[XCStatement alloc] init];
}
//methods setter getter
-(void)reset {
    [self setContent: [XCSpacer spacerWithParent:self]];
    _store = nil;
}
-(BOOL)isEmpty {
    return [[self content] isEmpty];
}

-(NSString *)description {
    return [NSString stringWithFormat:@"%@ <= %@",
            (_store) ? _store : @"ANS",[self content]];
}

-(void)assignToVar: (NSUInteger)varIdx {
    _store = [XCVariable variableForIndex: varIdx ];
}

//HTML
-toHTML {
    XCElement * c = [self content];
    NSString * html = ([c isKindOfClass:[XCExpression class]]) ?
    [c toHTMLFenced] : [c toHTML];
    return (_store) ?
    [NSString stringWithFormat:@"%@<mo>&larr;</mo>%@",[_store toHTML],html]: html;
    
}
//trigger

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

//evaluate
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
//copy
-(id)copyWithZone:(NSZone *)zone {
    XCStatement * rc = [super copyWithZone:zone];
    rc->_store = _store;
    return rc;
}
@end
