//
//  XCNum.h
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCTerminalElement.h"
@interface XCNum : XCTerminalElement {
    NSMutableString * _buf;
}
+(XCNum*) numWithFirstChar:(char)c;
+(XCNum*) numWithString:(NSString*) str;
-(NSNumber*) numericValue;

@end
