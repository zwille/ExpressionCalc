//
//  XCProduct.h
//  XCCalc
//
//  Created by Christoph Cwelich on 19.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCTupleElement.h"

@interface XCProduct : XCTupleElement
+(id) productWithElement0: (XCElement*) e0
              andElement1: (XCElement*) e1
                  andParent: (XCElement*) parent;
@end
