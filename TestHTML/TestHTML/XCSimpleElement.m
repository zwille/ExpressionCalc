//
//  XCSimpleElement.m
//  TestHTML
//
//  Created by Christoph Cwelich on 04.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCSimpleElement.h"

@implementation XCSimpleElement
-(id)initWithContent:(XCElement *)content
             andRoot:(XCElement *)root {
    self = [super initWithRoot:root];
    _content = content;
    [_content setRoot:self];
    return self;
}
-(void)replaceWithElement:(XCElement *)element {
    [element setRoot:self];
    _content = element;
}

@end
