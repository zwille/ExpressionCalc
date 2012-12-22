//
//  XCStatement.h
//  XCCalc
//
//  Created by Christoph Cwelich on 07.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCSimpleElement.h"
#import "XCVariable.h"

@interface XCStatement : XCSimpleElement {
    XCVariable * _store;
 
}
@property (strong,readwrite) XCVariable * store;
+(id) emptyStatement;
-(void) reset;
-(void)assignToVar: (NSUInteger)varIdx;
@end
