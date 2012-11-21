//
//  XCCharIterator.h
//  ExpressionCalc
//
//  Created by Christoph Cwelich on 20.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCCharIterator.h"

@interface XCStringIterator : NSObject<XCCharIterator> {
    NSUInteger idx; // idx points to the next character
    NSString * data; // the data to iterate over
}
-(id) initWithString:(NSString*) str;


@end
