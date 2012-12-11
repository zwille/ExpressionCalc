//
//  XCNegate.h
//  ExprCalc
//
//  Created by Christoph Cwelich on 25.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCSimpleElement.h"

@interface XCNegate : XCSimpleElement {
    XCElement * _value;
}
+(id)negateValue: (XCElement*) value
        withRoot: (XCElement*) root;

@end