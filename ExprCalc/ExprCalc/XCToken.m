//
//  XCToken.m
//  ExpressionCalc
//
//  Created by Christoph Cwelich on 20.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCToken.h"

@implementation XCToken
@synthesize content = _content;
@synthesize tokenType = _type;
-(id)initWithContent:(id)content andType:(XCTokenType)type{
    self = [super init];
    _content = content;
    _type = type;
    return self;
}
-(NSString *)description{
    NSMutableString * buf = [[NSMutableString alloc] init];
    [buf appendFormat:@"XCToken: token=%@ type=%@",_content,[XCToken stringOfType:_type]];
    return buf;
}
+(NSString*)stringOfType:(XCTokenType)type{
    switch (type) {
        case NUMBER: return @"number";
            case OPERATOR: return @"operator";
            case IDENTIFIER: return @"identifier";
            case WHITESPACE: return @"whitespace";
            case SPECIAL: return @"special";
            case WORD: return @"word";
            case END_OF_STATEMENT: return @"end of statement";
        default:
            return nil;
    }
}
@end
