//
//  XCLiteral.m
//  ExpressionCalc
//
//  Created by Christoph Cwelich on 21.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCLiteral.h"
#import "XCIdentifier.h"
#import "XCErrorToken.h"
#import "XCExpression.h"

@implementation XCLiteral
+(id)parseWithTokenizer:(XCTokenizer *)tok andArg:(id)arg {
    assert(arg==nil);
    NSUInteger index = [tok index];
    XCToken * token = [tok nextToken];
    XCTokenType tokenType = [token tokenType];
    
    switch (tokenType) {
        case PARSE_ERROR:
            return token;
        case NUMBER:
            return [token content];
        case SPECIAL:
            return [self parseExpressionWithTokenizer:tok
                                           firstToken: token
                                             andIndex:index];
        default:
            return [self parseIdentifierWithTokenizer:tok
                                           firstToken: token
                                             andIndex:index];
    }
}
+(id) parseIdentifierWithTokenizer: (XCTokenizer*) tok
                        firstToken: (XCToken*) token
                          andIndex: (NSUInteger) index {
    id rc = [XCIdentifier parseWithTokenizer: tok andArg:token];
    if (rc==nil) {
        return [[XCErrorToken alloc] initWithMessage:
            [NSString stringWithFormat:@"could not find identifier: %@",[token content]]
                                            andIndex:index];
    } else {
        return rc;
    }
}
+(id) parseExpressionWithTokenizer: (XCTokenizer*) tok
                        firstToken: (XCToken*) token
                          andIndex: (NSUInteger) index {
    if ([[token content] characterAtIndex:0]!=LEFT_BRACE) {
        return [[XCErrorToken alloc] initWithMessage:
                [NSString stringWithFormat:@"asserted %c",LEFT_BRACE]
                                            andIndex:index];
    }
    id rc = [XCExpression parseWithTokenizer:tok andArg:nil];
    if([rc isKindOfClass:[XCErrorToken class]]) {
        return rc;
    }
    
    index = [tok index];
    token = [tok nextToken];
    if([token tokenType]==SPECIAL
       && [[token content]characterAtIndex:0]==RIGHT_BRACE) {
        return rc;
    } else {
        return [[XCErrorToken alloc] initWithMessage:
                [NSString stringWithFormat:@"asserted %c",RIGHT_BRACE]
                                            andIndex:index];
    }

}
-(XCNumber *)value {
    return [XCNumber numberFromDouble:0];
}

@end
