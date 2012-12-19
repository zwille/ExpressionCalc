//
//  XCIdentifier.h
//  TestHTML
//
//  Created by Christoph Cwelich on 07.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCTerminalElement.h"
#import "XCStorage.h"
#import "XCConstant.h"
#import "XCVariable.h"

@interface XCIdentifier : XCTerminalElement  {
    XCStorage * _store;
}
+(id) ansWithParent: (XCElement*) parent;
+(id) identifierWithVariableIndex: (NSUInteger) idx
                          andRoot: (XCElement*) root;
+(id) identifierWithConstantId: (XCConstants) cid
                       andRoot: (XCElement*) root;
@end
