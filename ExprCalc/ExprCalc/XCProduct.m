//
//  XCProduct.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 21.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCProduct.h"
#import "XCPower.h"
#import "XCInvert.h"

int isOpProd(XCToken * token) {
    if ([token tokenType]==OPERATOR) {
        unichar c =[[token content] characterAtIndex:0];
        if (c==OP_MULT) {
            return 1;
        } else if (c==OP_DIV) {
            return -1;
        }
    }
    return 0;
}
@implementation XCProduct
-(XCNumber *)value{
    XCNumber * prod = [XCNumber numberFromDouble:1];
    for (id<XCHasValue> operand in operands) {
        prod = [prod mult: [operand value]];
    }
    return prod;
}
-(id) initWithOperands: (NSMutableArray*) ops {
    self = [super init];
    operands = ops;
    return self;
}

+(id)parseWithTokenizer:(XCTokenizer *)tok andArg:(id)arg {
    id operand = [XCPower parseWithTokenizer:tok andArg:nil];
    if (isError(operand)) {
        return operand;
    }
    XCToken * token = [tok previewToken];
    id rc = operand;
    int op = isOpProd(token);
    if(op) {
        NSMutableArray * operands = [[NSMutableArray alloc]init];
        rc = [[XCProduct alloc] initWithOperands:operands];
        [operands addObject:operand];
        do {
            [tok nextToken];
            operand = [XCPower parseWithTokenizer:tok andArg:nil];
            if (isError(operand)) {
                return operand;
            }
            if (op<0) {
                operand = [XCInvert invertValue:operand];
            }
            [operands addObject:operand];
            token = [tok previewToken];
        } while ((op = isOpProd(token)));
    }
    return rc;
}
    

@end
