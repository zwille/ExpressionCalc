//
//  XCEvaluable.h
//  XCCalc
//
//  Created by Christoph Cwelich on 07.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSNumber+XCNumber.h"

@protocol XCEvaluable <NSObject>
-(NSNumber*) eval;
@end
