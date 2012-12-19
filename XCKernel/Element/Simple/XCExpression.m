//
//  XCExpression.m
//  XCCalc
//
//  Created by Christoph Cwelich on 19.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCExpression.h"

@implementation XCExpression
+(id)expressionWithElement:(XCElement *)element andRoot:(XCElement *)root {
    return [[XCExpression alloc] initWithContent:element andRoot:root];
}
-(NSString *)description {
    return [NSString stringWithFormat:@"[ %@ ]",
            [self content]];
}
-(NSString *)toHTML {
    return [[self content] toHTMLFenced];
}

@end
