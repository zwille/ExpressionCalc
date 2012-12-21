//
//  XCHasTriggers.h
//  XCCalc
//
//  Created by Christoph Cwelich on 04.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCGlobal.h"

@protocol XCHasTriggers <NSObject>
-(id<XCHasTriggers>)triggerNum:(char) c;
-(id<XCHasTriggers>)triggerOperator: (XCOperator) op;
-(id<XCHasTriggers>)triggerEnter;
-(id<XCHasTriggers>)triggerNext;
-(id<XCHasTriggers>)triggerPrevious;
-(id<XCHasTriggers>)triggerDel;
-(id<XCHasTriggers>)triggerExpression;
-(id<XCHasTriggers>)triggerFunction: (NSString*) functionName;
-(id<XCHasTriggers>)triggerConstant: (XCConstants) cid;
-(id<XCHasTriggers>)triggerVariable: (NSUInteger) idx;

@end
