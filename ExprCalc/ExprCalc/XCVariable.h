//
//  XCVariable.h
//  ExprCalc
//
//  Created by Christoph Cwelich on 23.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCLiteral.h"
#import "XCNumber.h"
#import "XCHasValue.h"

@interface XCVariable : XCLiteral<XCElementParser, XCHasValue> {
    NSString * _name;
    XCNumber * _value;
}
@property (strong, readonly) NSString * name;

+(XCVariable*) variableByName: (NSString*) name;
+(NSArray*) variableNames;

@end
