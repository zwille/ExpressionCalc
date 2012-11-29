//
//  XCNum.h
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCLiteral.h"
@interface XCNum : XCLiteral {
    NSMutableString * str;
}
+(XCNum*) numWithFirstChar:(char)c;


@end
