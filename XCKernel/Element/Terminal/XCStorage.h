//
//  XCStorage.h
//  XCCalc
//
//  Created by Christoph Cwelich on 07.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCEvaluable.h"
#import "XCElement.h"
#import "XCHasHtmlOutput.h"

@interface XCStorage : NSObject<XCHasHtmlOutput> {
   
    NSNumber * _value;
}

-(id)initWithValue:(NSNumber *)value;
-(NSNumber *)value;

@end
