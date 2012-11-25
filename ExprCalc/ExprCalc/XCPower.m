//
//  XCPower.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 21.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCPower.h"
#import "XCLiteral.h"
#import "XCErrorToken.h"
bool isExpOp(XCToken * token) {
    return [token tokenType]==OPERATOR &&
    [[token content] characterAtIndex:0]==OP_EXP;
}

@implementation XCPower
-(XCNumber *)value{
    XCNumber * base = [operands objectAtIndex:0];
    for (NSUInteger i=1;i<[operands count];i++) {
        id<XCHasValue> exp = [operands objectAtIndex:i];
        base = [base pow: [exp value]];
    }
    return base;
}

-(id) initWithOperands: (NSMutableArray*) ops {
    self = [super init];
    operands = ops;
    return self;
}

+(id)parseWithTokenizer:(XCTokenizer *)tok {
    id parsed = [XCLiteral parseWithTokenizer:tok andArg:nil];
    if (isError(parsed)) {
        return parsed;
    }
   // XCLiteral * lit = parsed;
    XCToken * token = [tok previewToken];
    id rc = parsed;
    if(isExpOp(token)) { // has at least one exponent
        NSMutableArray * operands = [[NSMutableArray alloc]init];
        rc = [[XCPower alloc] initWithOperands:operands];
        [operands addObject:parsed];
        do {
            [tok nextToken];
            parsed = [XCLiteral parseWithTokenizer:tok andArg:nil];
            if (isError(parsed)) {
                return parsed;
            }
            [operands addObject:parsed];
            token = [tok previewToken];
        } while (isExpOp(token));
    }
    return rc;
}
@end
