//
//  XCTerminalElement.m
//  TestHTML
//
//  Created by Christoph Cwelich on 04.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCTerminalElement.h"

@implementation XCTerminalElement
//trigger
-(id<XCHasTriggers>)triggerNum:(char)c {
    return self;
}
@end
