//
//  XCError.h
//  ExprCalc
//
//  Created by Christoph Cwelich on 21.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCToken.h"

@interface XCErrorToken : XCToken {
    NSUInteger _index;
}
@property (readonly) NSUInteger index;
-initWithMessage: (NSString*) msg andIndex: (NSUInteger) index;
@end
