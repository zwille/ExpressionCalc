//
//  XCProd.h
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCComplexElement.h"

@interface XCProd : XCComplexElement
+(XCProd*) prodWithFirstElement: (XCElement*) arg0
              multSecondElement: (XCElement*) arg1
                        andRoot: (XCElement*) root;
+(XCProd*) prodWithFirstElement: (XCElement*) arg0
               divSecondElement: (XCElement*) arg1
                        andRoot: (XCElement*) root;
@end
