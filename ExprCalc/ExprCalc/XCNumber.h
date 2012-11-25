//
//  XCNumber.h
//  ExpressionCalc
//
//  Created by Christoph Cwelich on 21.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCLiteral.h"
#import "XCFunctionPrototype.h"
#import "XCHasValue.h"

@interface XCNumber : XCLiteral<XCHasValue> {
    double val;
}
-(id) initWithDouble: (double) value;
+(XCNumber*) numberFromDouble: (double) value;
+(XCNumber*) numberFromString: (NSString *) numStr;
-(XCNumber*) execFunc: (XCFunctionPrototype*) f;
-(XCNumber*) negate;
-(XCNumber*) invert;
-(XCNumber*) add: (XCNumber*) rhs;
-(XCNumber*) mult: (XCNumber*) rhs;
-(XCNumber*) pow: (XCNumber*) exp;

@end
