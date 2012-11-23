//
//  XCToken.h
//  ExpressionCalc
//
//  Created by Christoph Cwelich on 20.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum  {
    NUMBER,
    WORD,
    OPERATOR,
    IDENTIFIER,
    WHITESPACE,
    SPECIAL,
    END_OF_STATEMENT,
    PARSE_ERROR
} XCTokenType;

@interface XCToken : NSObject {
    id _content;
    XCTokenType _type;
}
@property (readonly,strong) id content;
@property (readonly) XCTokenType tokenType;
-(id) initWithContent:(id) content andType: (XCTokenType) type;
+(NSString*) stringOfType: (XCTokenType) type;
@end
