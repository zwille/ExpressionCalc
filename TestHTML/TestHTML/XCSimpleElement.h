//
//  XCSimpleElement.h
//  TestHTML
//
//  Created by Christoph Cwelich on 04.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCElement.h"

@interface XCSimpleElement : XCElement {
    XCElement * _content;
}
@property (strong,readonly) XCElement * content;
-(id) initWithContent: (XCElement*) content
              andRoot: (XCElement*) root;


@end
