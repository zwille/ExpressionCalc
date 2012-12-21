//
//  XCExpression.m
//  XCCalc
//
//  Created by Christoph Cwelich on 19.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCExpression.h"

@implementation XCExpression
+(id)expressionWithElement:(XCElement *)element andParent:(XCElement *)parent {
    return [[XCExpression alloc] initWithContent:element andParent:parent];
}
-(NSString *)description {
    return [NSString stringWithFormat:@"[ %@ ]",
            [self content]];
}
-(NSString *)toHTML {
    XCElement * c = [self content];
    NSString * html = ([c isKindOfClass:[self class]]) ?
    [c toHTMLFenced] : [c toHTML];
    return [super wrapHTML:html];
}

@end
