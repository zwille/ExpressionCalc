//
//  XCExponentiation.h
//  XCCalc
//
//  Created by Christoph Cwelich on 19.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCTupleElement.h"

@interface XCExponentiation : XCTupleElement
+(id) exponentiationWithBase: (XCElement*) base
              andExponent: (XCElement*) exp
                  andParent: (XCElement*) parent;
@end
