//
//  XCSum.m
//  XCCalc
//
//  Created by Christoph Cwelich on 19.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCSum.h"
#import "XCNegate.h"

@implementation XCSum
+(id)sumWithElement0:(XCElement *)e0
         andElement1:(XCElement *)e1
             andRoot:(XCElement *)root{
    return [[XCSum alloc] initWithRoot:root
                       andFirstElement:e0
                      andSecondElement:e1 ];
}
-(NSString *)description {
    return [NSString stringWithFormat:@"+(%@, %@)",
            _content[0],_content[1]];
}

//HTML
-(NSString *)toHTML {
    XCElement * e1 = [self element1];
    NSString * format =
    ([e1 isKindOfClass:[XCNegate class]]
     || ([e1 isKindOfClass:[XCSum class]]
     && [[((XCSum*)e1) element0] isKindOfClass:[XCNegate class]])) ?
    @"%@ %@" :
    @"%@ <mo>+</mo> %@";
    return [super wrapHTML:
            [NSString stringWithFormat:format,
             [_content[0] toHTML], [_content[1] toHTML]]];
}
//trigger
//evaluate
-(NSNumber *)eval {
    return [[_content[0] eval] addNum: [_content[1] eval]];
}


@end
