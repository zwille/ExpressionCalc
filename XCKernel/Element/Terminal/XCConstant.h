//
//  XCConstant.h
//  XCCalc
//
//  Created by Christoph Cwelich on 07.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCStorage.h"

@interface XCConstant : XCStorage {
     NSString * _name;
    NSString * _html;
}
-(id)initWithName:(NSString *)name
          andHTML: (NSString*) html
         andValue:(NSNumber *)value;

+(id) constantForID: (XCConstants) cid;
@end
