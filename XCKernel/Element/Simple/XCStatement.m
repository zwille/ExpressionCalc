//
//  XCStatement.m
//  TestHTML
//
//  Created by Christoph Cwelich on 07.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCStatement.h"
#import "XCExpr.h"


@implementation XCStatement
@synthesize store;
-(id)init {
    self = [super initWithContent:nil andRoot:nil];
    [self reset];
    return self;
}
+(id)emptyStatement {
    return [[XCStatement alloc] init];
}
-(void)reset {
    [self setContent: [XCExpr emptyExpressionWithRoot: self]];
    _store = nil;

}

-(NSString *)description {
    return (_store) ?
    [NSString stringWithFormat:@"<%@ := %@>",_store,[self content]] :
    [NSString stringWithFormat:@"<%@>",[self content]];
}
-toHTML {
    return (_store) ?
    [NSString stringWithFormat:@"%@<mo>&larr;</mo>%@",[_store toHTML],[[self content] toHTML]] :
    [NSString stringWithFormat:@"%@",[[self content] toHTML]];
}
-(NSNumber *)eval {
    XCElement * content = [self content];
    NSNumber * rc = ([content isEmpty]) ? @0 : [content eval];
    if (_store) {
        [_store setNumericValue:rc];
    } else {
        [[XCVariable variableForIndex:0] setNumericValue:rc];
    }
    return rc;
}

//trigger
-(id<XCHasTriggers>)triggerAssign: (NSUInteger)varIdx {
    _store = [XCVariable variableForIndex: varIdx ];
    return [self content];
}

//copy
-(id)copyWithZone:(NSZone *)zone {
    XCStatement * rc = [super copyWithZone:zone];
    rc->_store = _store;
    return rc;
}
//private


@end
