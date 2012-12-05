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
-(NSString*) htmlFromElement: (XCElement*) el atIndex: (NSUInteger) i andContentLength: (NSUInteger)len;

@end
