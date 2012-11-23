//
//  XCFunction.h
//  ExprCalc
//
//  Created by Christoph Cwelich on 23.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCLiteral.h"

@interface XCFunction : XCLiteral<XCElementParser> {
    NSString * _name;
    XCElement * _value;
    SEL _call;
}
@property (strong, readonly) NSString * name;


-(id)initWithName:(NSString*) name andCall: (SEL) call;
+(XCVariable*) variableByName: (NSString*) name;
@end
