//
//  XCNegate.h
//  ExprCalc
//
//  Created by Christoph Cwelich on 25.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCElement.h"
#import "XCHasValue.h"
#import "XCElementParser.h"

@interface XCNegate : XCElement<XCHasValue>{
    id<XCHasValue> _value;
}
+(id)negateValue: (id) value;

@end