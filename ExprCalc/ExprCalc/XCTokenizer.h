//
//  XCTokenizer.h
//  ExpressionCalc
//
//  Created by Christoph Cwelich on 19.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Symbols.h"
#import "XCCharIterator.h"
#import "XCToken.h"

@interface XCTokenizer : NSObject {
    XCToken * _token;
    NSUInteger _index;
    id<XCCharIterator> chars;
    NSNumberFormatter * numformat;
}
/*
 * points to the start of the token
 */
@property (readonly) NSUInteger index;
+(id) tokenizerWithString: (NSString*) str;
-(id) initWithStatement: (id<XCCharIterator>) statement;
-(XCToken*) previewToken;
-(XCToken*) nextToken;
-(NSUInteger) index;


@end
