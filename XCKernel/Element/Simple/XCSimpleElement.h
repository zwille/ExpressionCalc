//
//  XCSimpleElement.h
//  XCCalc
//
//  Created by Christoph Cwelich on 04.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCElement.h"

@interface XCSimpleElement : XCElement {
    XCElement * _content;
}

-(id) initWithContent: (XCElement*) content
              andParent: (XCElement*) parent;
-(void) setContent:(XCElement *)content;


@end
