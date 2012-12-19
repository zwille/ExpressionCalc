//
//  XCExponentiation.m
//  XCCalc
//
//  Created by Christoph Cwelich on 19.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCExponentiation.h"
#import "XCTerminalElement.h"

@implementation XCExponentiation
+(id)exponentiationWithBase:(XCElement *)base
                andExponent:(XCElement *)exp
                    andRoot:(XCElement *)root {
    return [[XCExponentiation alloc] initWithRoot:root andFirstElement:base andSecondElement:exp];
}
-(NSString *)description {
    return [NSString stringWithFormat:@"^(%@, %@)",
            _content[0],_content[1]];
}
-(NSString *)toHTML {
    return [super wrapHTML: [NSString stringWithFormat:
            @"<msup> <mrow>%@</mrow> <mrow>%@</mrow> </msup>",
            ([_content[0] isKindOfClass:
              [XCTerminalElement class] ]) ?
                        [_content[0] toHTML] :
                        [_content[0] toHTMLFenced]
            ,[_content[1] toHTML]]];
}
// evaluate
-(NSNumber *)eval {
    return [[_content[0] eval] powExp: [_content[1] eval]];
}
@end
