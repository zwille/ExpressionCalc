//
//  XCTokenizer.m
//  ExpressionCalc
//
//  Created by Christoph Cwelich on 19.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCTokenizer.h"
bool isOperator(unichar c) {
    switch (c) {
        case OP_ADD:
        case OP_SUB:
        case OP_MULT:
        case OP_DIV:
        case OP_EXP:
            return true;
        default:
            return false;
    }
}
bool isWhitespace(unichar c) {
    return c==' ';
}
bool isSpecial(unichar c) {
    switch (c) {
        case LEFT_BRACE:
        case RIGHT_BRACE:
            return true;
        default:
            return false;
    }
}
@implementation XCTokenizer
@synthesize index = _index;
@synthesize tokenType = _tokenType;
-(id)initWithStatement:(NSString *)statement {
    self = [super init];
    _statement = statement;
    _index = 0;
    return self;
}
-(id)previewToken{
    return _token;
}
-(id)nextToken{
    id rc = _token;
    unichar c = [self readNextChar];
    if(c==-1) {
        _tokenType = END_OF_STATEMENT;
        _token = nil;
    } else if(isOperator(c)) {
        _tokenType = OPERATOR;
        _token = [[NSString alloc] initWithCharacters:&c  length:1];
    } else if (isdigit(c) || ispunct(c)) {
        [self parseNumber: c];
    } else if (isWhitespace(c)) {
        _tokenType = WHITESPACE;
        _token = [[NSString alloc] initWithCharacters:&c  length:1];
    } else if (isSpecial(c)) {
        _tokenType = WHITESPACE;
        _token = [[NSString alloc] initWithCharacters:&c  length:1];
    } else {
        //[self parseIdentifier(c)];
    }
    return rc;
}
-(unichar) readNextChar {
    if(_index<[_statement length]) {
        return [_statement characterAtIndex:_index];
        _index++;
    }
    return -1;
}
-(void) parseNumber: (unichar) c {
    //<Decimal> [ 'E' ( <Digit> )+ ]
    //<Decimal>  		::= ( ( <Digit> )+ [ '.' ( <Digit> )* ] ) | ( ( <Digit> )* '.' ( <Digit> )+ )
    //<Digit> ::= '0' | '1'| '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9'
    NSMutableString * numberStr = [[NSMutableString alloc] init];
    //parse decimal
    bool hasPrefix=NO;
    while(isdigit(c)) {
        hasPrefix=YES;
        [numberStr appendFormat:@"%c",c];
        c = [self readNextChar];
    }
if(ispunct(c)) {
    
}
}

@end
