//
//  XCElement.m
//  ExpressionCalc
//
//  Created by Christoph Cwelich on 21.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCElement.h"
#import "XCErrorToken.h"
#import "Symbols.h"
bool isError(id parsed) {
    return [parsed isKindOfClass:[XCErrorToken class]];
}

@implementation XCElement

@end
