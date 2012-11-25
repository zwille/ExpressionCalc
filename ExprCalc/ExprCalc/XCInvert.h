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
@interface XCInvert : XCElement {
    id<XCHasValue> _value;
}
+(id)invertValue: (id<XCHasValue>) value;
-(id)initWithValue: (id<XCHasValue>) value;
@end
