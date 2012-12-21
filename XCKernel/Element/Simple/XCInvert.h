//
//  XCInvert.h
//  XCCalc
//
//  Created by Christoph Cwelich on 25.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCValModifier.h"

@interface XCInvert : XCValModifier
+(id)invertValue: (XCElement*) value withParent: (XCElement*) parent;

@end
