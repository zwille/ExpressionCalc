//
//  XCConstant.h
//  TestHTML
//
//  Created by Christoph Cwelich on 07.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCStorage.h"

@interface XCConstant : XCStorage {
     NSString * _name;
}
-(id)initWithName:(NSString *)name
         andValue:(NSNumber *)value;

+(id) constantForID: (XCConstants) cid;
@end
extern XCConstant * XC_EULER, * XC_PI;