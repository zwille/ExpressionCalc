//
//  XCTupleElement.h
//  XCCalc
//
//  Created by Christoph Cwelich on 19.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCElement.h"

@interface XCTupleElement : XCElement {
    XCElement * _content[2];
}

-(id)initWithRoot:(XCElement *)root
  andFirstElement: (XCElement*) e0
 andSecondElement: (XCElement*) e1;

-(void) setElement: (XCElement*) el at: (BOOL) idx;
-(XCElement*) elementAt: (BOOL) idx;
-(XCElement*) element0;
-(XCElement*) element1;
-(BOOL) index;
@end
