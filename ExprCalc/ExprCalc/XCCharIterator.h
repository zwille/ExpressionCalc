//
//  XCCharIterator.h
//  ExpressionCalc
//
//  Created by Christoph Cwelich on 20.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XCCharIterator <NSObject>
-(unichar) nextChar;
-(unichar) currentChar;
-(bool) hasNextChar;
-(NSUInteger) index;
-(void) back;
@end
