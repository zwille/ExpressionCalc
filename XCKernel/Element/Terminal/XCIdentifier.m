//
//  XCIdentifier.m
//  XCCalc
//
//  Created by Christoph Cwelich on 07.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCIdentifier.h"


@implementation XCIdentifier
-(id)initWithParent:(XCElement *)parent andStorage: (XCStorage*) store {
    self = [super initWithParent:parent];
    _store = store;
    return self;
}
+(id)ansWithParent: (XCElement*) parent {
    return [[XCIdentifier alloc] initWithParent:parent
                                   andStorage:[XCVariable variableForIndex:0]];
}
+(id)identifierWithConstantId:(XCConstants)cid andParent: (XCElement*) parent; {
    return [[XCIdentifier alloc] initWithParent:parent
                                   andStorage:
            [XCConstant constantForID:cid]];
    
}
+(id)identifierWithVariableIndex:(NSUInteger)idx andParent:(XCElement *)parent {
    return [[XCIdentifier alloc] initWithParent:parent
                                   andStorage:
            [XCVariable variableForIndex:idx]];
}
-(NSNumber *)eval {
    return [_store value];
}
-(NSString *)toHTML {
    return [super wrapHTML: [_store toHTML]];
}
-(NSString *)description {
    return [NSString stringWithFormat:@"%@",_store];
}
-(id)copyWithZone:(NSZone *)zone {
    XCIdentifier * rc = [super copyWithZone:zone];
    rc -> _store = _store; //no copy global object
    return rc;
}

@end
