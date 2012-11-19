//
//  XCTokenizer.h
//  ExpressionCalc
//
//  Created by Christoph Cwelich on 19.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Symbols.h"

@interface XCTokenizer : NSObject {
    NSUInteger _index;
    id _token;
    TokenType _tokenType;
    NSString * _statement;
}
@property (readonly) NSUInteger index;
@property (readonly) TokenType tokenType;
-(id) initWithStatement: (NSString*) statement;
-(id) previewToken;
-(id) nextToken;


@end
