//
//  XCFunction.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 23.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCFunction.h"
#import "XCNumber.h"

@implementation XCFunction
-(id)initWithName:(NSString *)name andCall:(SEL)call {
    self = [super init];
    _name = name;
    _call = call;
}
-(XCNumber*) compute{
    
    
}

@end
