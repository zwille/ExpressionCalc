//
//  XCInvert.h
//  ExprCalc
//
//  Created by Christoph Cwelich on 25.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCSimpleElement.h"

@interface XCInvert : XCSimpleElement 
+(id)invertValue: (XCElement*) value withRoot: (XCElement*) root;

@end
