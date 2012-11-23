//
//  XCNumber.h
//  ExpressionCalc
//
//  Created by Christoph Cwelich on 21.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCLiteral.h"

@interface XCNumber : XCLiteral {
    double val;
}
-(id) initWithDouble: (double) value;
+(XCNumber*) numberFromDouble: (double) value;
+(XCNumber*) numberFromString: (NSString *) numStr;
-(XCNumber*) cos;

@end
