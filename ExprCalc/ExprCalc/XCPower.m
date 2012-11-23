//
//  XCPower.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 21.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCPower.h"
#import "XCLiteral.h"

@implementation XCPower
+(id)parseWithTokenizer:(XCTokenizer *)tok {
    id parsed = [XCLiteral parseWithTokenizer:tok];
    if ([parsed tokenType]==PARSE_ERROR) {
        return parsed;
    }
    XCLiteral * base = token;
    XCToken * token = [tok previewToken];
    NSMutableArray literals
    while ([token tokenType]==OPERATOR &&
           [[token content] characterAtIndex:0]==OP_EXP) {
        [tok nextToken];
        parsed = [XCLiteral parseWithTokenizer:tok];
        if ([parsed tokenType]==PARSE_ERROR) {
            return parsed;
        }
        
    }
}
@end
