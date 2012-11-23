//
//  XCVariable.h
//  ExprCalc
//
//  Created by Christoph Cwelich on 23.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCLiteral.h"
#import "XCNumber.h"

@interface XCVariable : XCLiteral<XCElementParser> {
    NSString * _name;
    XCNumber * _value;
}
@property (strong, readonly) NSString * name;
@property (strong) XCNumber * value;
-(id)initWithName:(NSString*) name;
+(XCVariable*) variableByName: (NSString*) name;

@end
