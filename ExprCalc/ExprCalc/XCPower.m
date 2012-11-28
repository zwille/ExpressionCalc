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
    assert([operands count] > 1);
    XCNumber * base = [operands objectAtIndex:0];
    for (NSUInteger i=1;i<[operands count];i++) {
        id<XCHasValue> exp = [operands objectAtIndex:i];
        NSLog(@">>> XCPower value base = %@, exp = %@",base,exp);
        base = [[base value] pow: [exp value]];
    }
    NSLog(@">>> XCPower value base = %@",base);
    return base;
}

-(id) initWithOperands: (NSMutableArray*) ops {
    self = [super init];
    operands = ops;
    return self;
}

+(id) parseOperandWithTokenizer: (XCTokenizer *)tok addTo: (NSMutableArray*) operands   {
    uint index = [tok index];
    id parsed = [XCLiteral parseWithTokenizer:tok andArg:nil];
    if (isError(parsed)) {
        return parsed;
    }
    if ([parsed isKindOfClass:[XCLiteral class]]) {
        [operands addObject:parsed];
        return nil;
    } else {
        return [[XCErrorToken alloc] initWithMessage:@"asserted literal" andIndex:index];
    }
}
+(id)parseWithTokenizer:(XCTokenizer *)tok andArg:(id)arg{
    assert(arg==nil);
    NSMutableArray * operands = [[NSMutableArray alloc]init];
    id state=[self parseOperandWithTokenizer:tok addTo:operands];
    if(state!=nil) {
        return state;
    }
    XCToken * token = [tok previewToken];
    while (isExpOp(token)){
        [tok nextToken];
        state=[self parseOperandWithTokenizer:tok addTo:operands];
        if(state!=nil) {
            return state;
        }
        token = [tok previewToken];
    }
    return ([operands count]>1) ?
    [[XCPower alloc] initWithOperands:operands] :
    [operands objectAtIndex:0];
}
@end
