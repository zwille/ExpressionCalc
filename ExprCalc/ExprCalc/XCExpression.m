//
//  XCExpression.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 25.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCExpression.h"
#import "XCProduct.h"
#import "XCNegate.h"

int isOpSum(XCToken * token) {
    if ([token tokenType]==OPERATOR) {
        unichar c =[[token content] characterAtIndex:0];
        if (c==OP_ADD) {
            return 1;
        } else if (c==OP_SUB) {
            return -1;
        }
    }
    return 0;
}
@implementation XCExpression
-(XCNumber *)value{
    XCNumber * sum = [XCNumber numberFromDouble:0];
    for (id<XCHasValue> operand in operands) {
        sum = [sum add: [operand value]];
    }
    return sum;
}
-(id) initWithOperands: (NSMutableArray*) ops {
    self = [super init];
    operands = ops;
    return self;
}

+(id)parseWithTokenizer:(XCTokenizer *)tok andArg:(id)arg {
    id operand = [XCProduct parseWithTokenizer:tok andArg:nil];
    if (isError(operand)) {
        return operand;
    }
    XCToken * token = [tok previewToken];
    id rc = operand;
    int op = isOpSum(token);
    if(op) {
        NSMutableArray * operands = [[NSMutableArray alloc]init];
        rc = [[XCExpression alloc] initWithOperands:operands];
        [operands addObject:operand];
        do {
            [tok nextToken];
            operand = [XCProduct parseWithTokenizer:tok andArg:nil];
            if (isError(operand)) {
                return operand;
            }
            if (op<0) {
                operand = [XCNegate negateValue:operand];
            }
            [operands addObject:operand];
            token = [tok previewToken];
        } while (isOpSum(token));
    }
    return rc;
}
@end
