//
//  XCElementParser.h
//  ExprCalc
//
//  Created by Christoph Cwelich on 21.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCTokenizer.h"

@protocol XCElementParser <NSObject>
+(id) parseWithTokenizer: (XCTokenizer*) tok andArg: (id) arg;
@end
