//
//  XCVariable.h
//  XCCalc
//
//  Created by Christoph Cwelich on 07.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCStorage.h"

@interface XCVariable : XCStorage {
    NSUInteger _idx;
}
+(id) variableForIndex:(NSUInteger) idx;
-(void) setNumericValue:(NSNumber*) val;
@end

