//
//  XCLiteral.m
//  ExpressionCalc
//
//  Created by Christoph Cwelich on 21.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCLiteral.h"
#import "XCIdentifier.h"

@implementation XCLiteral
+(id)parseWithTokenizer:(XCTokenizer *)tok{
    XCToken * token = [tok previewToken];
    XCTokenType tokenType = [token tokenType];
    //TODO parse Expression
    switch (tokenType) {
        case PARSE_ERROR:
            [tok nextToken];
            return token;
        case NUMBER:
            [tok nextToken];
            return [token content];
        default:
            return [XCIdentifier parseWithTokenizer: tok];
    }
}
@end
