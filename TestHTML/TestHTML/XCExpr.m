//
//  XCExpr.m
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCExpr.h"
#import "XCProd.h"

@implementation XCExpr
+(XCExpr *)emptyExpression{
    return [[XCExpr alloc] init];
}
-(XCElement *)triggerMult {
    if(!_waitingForLiteral) {
        XCProd * p = [XCProd prodWithElement: [self currentElement]];
        [self setCurrentWithElement:p];
        return p;
    }
    else {
        return self;
    }
}

-(XCElement *)triggerPlus {
    if (!_waitingForLiteral) {
        [self shiftRight];
        _waitingForLiteral = YES;
    }
    return self;
}
-(NSString *)htmlLastOp {
    return @"+";
}
-(NSString *)htmlFromElement:(XCElement *) e isFirstElement :(bool)isFirst {
    NSString * format = (isFirst) ? @"%@" : @" + %@";
    return [NSString stringWithFormat:format,[e toHTML]];
}


@end
