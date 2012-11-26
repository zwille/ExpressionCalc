//
//  XCInvert.h
//  ExprCalc
//
//  Created by Christoph Cwelich on 25.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCElement.h"
#import "XCHasValue.h"
#import "XCElementParser.h"
#import "XCNumber.h"
@interface XCInvert : XCElement<XCHasValue> {
    id<XCHasValue> _value;
}
+(id)invertValue: (id) value;

@end
