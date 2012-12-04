//
//  XCKernel.h
//  TestHTML
//
//  Created by Christoph Cwelich on 04.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCHasTriggers.h"
#import "XCElement.h"

@interface XCKernel : NSObject<XCHasTriggers, XCHasHtmlOutput> {
    XCElement * _root, * _head;
}
-(void) reset;


@end
