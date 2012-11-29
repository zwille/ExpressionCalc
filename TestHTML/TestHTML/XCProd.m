//
//  XCProd.m
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCProd.h"

@implementation XCProd
+(XCProd *)prodWithElement:(XCElement *)element{
    XCProd * p = [[XCProd alloc] init];
    [p setCurrentWithElement: element];
    [p shiftRight];
    p->_waitingForLiteral=YES;
    return p;
}
-(XCElement *)triggerMult{
    if (_waitingForLiteral) {
        [self shiftRight];
    }
    return self;
}
-(NSString *)htmlLastOp {
    return @"*";
}
-(NSString *)htmlFromElement:(XCElement *) e isFirstElement :(bool)isFirst {
    NSString * format = (isFirst) ? @"%@" : @" * %@";
    return [NSString stringWithFormat:format,[e toHTML]];
}
@end
