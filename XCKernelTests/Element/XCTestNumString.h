//
//  XCTestNumString.h
//  XCCalc
//
//  Created by Christoph Cwelich on 16.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "XCStatement.h"

@interface XCTestNumString : SenTestCase {
    XCStatement * s;
}
-(void) testSimple;
-(void) testCopy;
@end
