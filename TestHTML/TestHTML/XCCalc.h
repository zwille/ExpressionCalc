//
//  XCCalc.h
//  TestHTML
//
//  Created by Christoph Cwelich on 07.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCCalc : NSObject
+(NSNumber*) numberWithNum: (NSNumber*) a addedWith: (NSNumber*) b;
+(NSNumber*) numberWithNum: (NSNumber*) a multipliedWith: (NSNumber*) b;
+(NSNumber*) numberWithBase: (NSNumber*) a toPowerOf: (NSNumber*) b;
+(NSNumber*) negateNum: (NSNumber*) val;
+(NSNumber*) invertNum: (NSNumber*) val;
@end
