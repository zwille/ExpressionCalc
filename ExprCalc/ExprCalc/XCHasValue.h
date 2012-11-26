//
//  XCHasValue.h
//  ExprCalc
//
//  Created by Christoph Cwelich on 25.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCNumber.h"


@protocol XCHasValue <NSObject>
-(XCNumber*) value;
@end
