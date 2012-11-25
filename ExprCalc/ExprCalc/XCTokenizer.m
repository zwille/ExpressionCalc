//
//  XCTokenizer.m
//  ExpressionCalc
//
//  Created by Christoph Cwelich on 19.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCTokenizer.h"
#import "XCNumber.h"
#import "XCErrorToken.h"
bool isIdChar(unichar c) {
    switch (c) {
        case PI:
        case EULER:
        case SQRT:
            return true;
        default:
            return false;
    }
}
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

-(id)initWithStatement: (id<XCCharIterator>) statement {
    self = [super init];
    chars = statement;
    numformat = [[NSNumberFormatter alloc] init];
    [self nextToken];
    return self;
}
-(id)previewToken{
    return _token;
}
-(id)nextToken{
    id rc = _token;
    _index = [chars index];
    unichar c = -1;
    if ([chars hasNextChar]) {
        c = [chars nextChar];
        if(isOperator(c)) {
            _token = [[XCToken alloc] initWithContent:
                    [NSString stringWithFormat: @"%C",c]
                                       andType: OPERATOR];
        } else if (isdigit(c) || c==PUNCT) {
            XCNumber* num = [self parseNumberWithFirstChar: c];
            _token = (num==nil) ?
            [[XCErrorToken alloc] initWithMessage:@"malformed number" andIndex: _index] :
            [[XCToken alloc] initWithContent:num andType: NUMBER];
        } else if (isWhitespace(c)) {
            _token =  [[XCToken alloc] initWithContent:
                    [NSString stringWithFormat: @"%C",c]
                                       andType: WHITESPACE];
        } else if (isSpecial(c)) {
            _token =  [[XCToken alloc] initWithContent:
                    [NSString stringWithFormat: @"%C",c]
                                       andType: SPECIAL];
        } else if (isupper(c) || islower(c)) {
            _token = [[XCToken alloc] initWithContent:
                [self parseWordWithFirstChar: c ]
                andType:WORD];
        } else if (isIdChar(c)) {
            _token = [[XCToken alloc] initWithContent:
                      [NSString stringWithFormat:@"%C",c]
                                              andType:WORD];
        }
        else {
            assert(false);
        }
    } else {
        _token = [[XCToken alloc] initWithContent: nil
                                   andType: END_OF_STATEMENT];
    }
    return rc;
}
-(XCNumber*) parseNumberWithFirstChar: (unichar) c {
    NSMutableString * buf = [[NSMutableString alloc] init];
    while (true) {
        if(isdigit(c)) { 
            [buf appendFormat:@"%C",c];
        } else if(c==PUNCT) {
            [buf appendString:@"."];
        } else if (c==EXP_BASE10) {
            [buf appendString:@"E"];
        } else {
            [chars back];
            break;
        }
        if ([chars hasNextChar]) {
            c = [chars nextChar];
        } else {
            break;
        }
    }
    return [XCNumber numberFromString:buf];
}
-(NSString*) parseWordWithFirstChar: (unichar) c {
    NSMutableString * buf = [[NSMutableString alloc] init];
    while(isupper(c) || islower(c)) {
        [buf appendFormat:@"%C",c];
        if ([chars hasNextChar]) {
            c = [chars nextChar];
        } else {
            break;
        }
    }
    [chars back];
    return buf;
}


@end
