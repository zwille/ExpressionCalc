//
//  XCNegate.h
//  ExprCalc
//
//  Created by Christoph Cwelich on 25.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCSimpleElement.h"

@interface XCNegate : XCSimpleElement
+(id)negateValue: (XCElement*) value
        withParent: (XCElement*) parent;

@end