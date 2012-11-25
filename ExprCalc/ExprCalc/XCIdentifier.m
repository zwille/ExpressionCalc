//
//  XCIdentifier.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 23.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCIdentifier.h"
#import "XCConstant.h"
#import "XCVariable.h"
#import "XCFunction.h"
#import "XCErrorToken.h"

@implementation XCIdentifier
+(id)parseWithTokenizer:(XCTokenizer *)tok andArg:(id)arg{
    assert(arg!=nil);
    XCToken *token = arg;
    id rc = [XCConstant parseWithTokenizer:tok andArg:token];
    if (rc!=nil) {
        return rc;
    }
    rc = [XCFunction parseWithTokenizer:tok andArg:token];
    if (rc!=nil) {
        return rc;
    }
    return [XCVariable parseWithTokenizer:tok andArg:token];
    
}

@end
