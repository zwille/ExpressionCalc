//
//  XCIdentifier.m
//  TestHTML
//
//  Created by Christoph Cwelich on 07.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCIdentifier.h"
#import "XCConstant.h"
#import "XCVariable.h"

@implementation XCIdentifier
-(id)initWithRoot:(XCElement *)root andStorage: (XCStorage*) store {
    self = [super initWithRoot:root];
    _store = store;
    return self;
}
+(id)identifierWithConstantId:(XCConstants)cid andRoot: (XCElement*) root; {
    return [[XCIdentifier alloc] initWithRoot:root
                                   andStorage:
            [XCConstant constantForID:cid]];
    
}
+(id)identifierWithVariableIndex:(NSUInteger)idx andRoot:(XCElement *)root {
    return [[XCIdentifier alloc] initWithRoot:root
                                   andStorage:
            [XCVariable variableForIndex:idx]];
}
-(NSNumber *)eval {
    return [_store value];
}
-(NSString *)toHTMLfromChild {
    return [_store toHTML];
}
-(NSString *)description {
    return [NSString stringWithFormat:@"%@[%@]",[super description],_store];
}

@end
