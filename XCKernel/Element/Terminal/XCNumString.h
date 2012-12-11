//
//  XCNum.h
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCTerminalElement.h"

@interface XCNumString : XCTerminalElement {
    NSMutableString * _buf;
}
+(XCNumString*) numWithFirstChar:(char)c;
+(XCNumString*) numWithString:(NSString*) str;


@end
