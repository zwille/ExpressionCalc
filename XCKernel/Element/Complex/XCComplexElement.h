//
//  XCComplexElement.h
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCElement.h"
#import "XCComplexElementContent.h"

@interface XCComplexElement : XCElement {
    @protected
    XCComplexElementContent * _content;
}
-(void) insertElement:(XCElement*) element;
-(id)initWithRoot:(XCElement *)root
  andFirstElement: (XCElement*) e0;
-(id)initWithRoot:(XCElement *)root
  andFirstElement: (XCElement*) e0
 andSecondElement: (XCElement*) e1;
@end
