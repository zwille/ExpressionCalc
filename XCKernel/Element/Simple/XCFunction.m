//
//  XCFunction.m
//  TestHTML
//
//  Created by Christoph Cwelich on 05.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCFunction.h"
#import "XCFuncAlg.h"
#import "XCTrigoFuncAlg.h"
#import "XCSqrt.h"
#import "XCExpr.h"
#import "XCTerminalElement.h"

static const NSDictionary * functions; 

@implementation XCFunction
+(void)initialize{
    functions = @{
    XC_SQRT:[XCFuncAlg with: sqrt],
    @"ln":[XCFuncAlg with: log],
    @"exp":[XCFuncAlg with: exp],
    
    @"cos":[XCTrigoFuncAlg with: cos],
    @"sin":[XCTrigoFuncAlg with: sin],
    @"tan":[XCTrigoFuncAlg with: tan],
    
    @"acos":[XCTrigoFuncAlg with: acos],
    @"asin":[XCTrigoFuncAlg with: asin],
    @"atan":[XCTrigoFuncAlg with: atan]
    };
}
- (id)initWithRoot:(XCElement*)root
           andName: (NSString*) name
        andElement:(XCElement*)element {
    self = [super initWithRoot:root];
    if (self) {
        _name = name;
        [self setContent:element];
    }
    return self;
}
-(NSString *)toHTML {
    XCElement * content = [self content];
    return [super wrapHTML: [NSString stringWithFormat:
            @"<csymbol>%@ </csymbol> %@",_name,
            ([[self content] isKindOfClass:[XCTerminalElement class]]) ?
                             [content toHTML] : [content toHTMLFenced]]];
}
+(XCFunction *)functionWithName:(NSString *)name
                    withElement:(XCElement *)element
                        andRoot:(XCElement *)root {
    Class c = [XCFunction class];
    element = [XCExpr expressionWithElement:element
                                    andRoot:nil];
    if([name isEqualToString:XC_SQRT]) {
        c = [XCSqrt class];
           }
    return [[c alloc] initWithRoot: root
                                    andName:name
                                 andElement: element];
}
-(NSNumber *)eval {
    
    XCFuncAlg * algo = [functions objectForKey:_name];
    //NSLog(@"XCFunction::eval %@",_name);
    return [super checkErrorOn:[algo evaluateArgument:[[self content] eval]]];
}
-(id)copyWithZone:(NSZone *)zone {
    XCFunction * rc = [super copyWithZone:zone];
    rc -> _name = _name;
    return rc;
}

@end
