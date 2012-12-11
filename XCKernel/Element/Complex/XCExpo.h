//
//  XCExpo.h
//  TestHTML
//
//  Created by Christoph Cwelich on 05.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//


#import "XCComplexElement.h"
@interface XCExpo : XCComplexElement
+(XCExpo*) expoWithFirstElement: (XCElement*) arg0
               andSecondElement: (XCElement*) arg1
                        andRoot: (XCElement*) root;
@end
