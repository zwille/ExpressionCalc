//
//  XCSum.h
//  ExprCalc
//
//  Created by Christoph Cwelich on 21.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCElement.h"
#import "XCElementParser.h"

@interface XCSum : XCElement <XCElementParser> {
    NSArray * products;
}

@end
