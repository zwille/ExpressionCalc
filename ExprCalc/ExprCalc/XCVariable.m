//
//  XCVariable.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 23.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCVariable.h"
static NSMutableDictionary * variables = nil;

@implementation XCVariable
@synthesize name = _name;
@synthesize value = _value;
-(id)initWithName:(NSString *)name{
    self = [super init];
    _name = name;
    _value = [[XCNumber alloc] initWithDouble:0.0];
    return self;
}
+(XCVariable *)variableByName:(NSString *)name{
    return [variables objectForKey:name];
}
+(void)initialize{
    NSArray * names = [NSArray arrayWithObjects:@"a",@"b",@"c",@"d",@"p",@"q",@"r",@"s",@"t", nil];
    variables = [[NSMutableDictionary alloc] initWithCapacity:9];
    for (NSString* name in names) {
        [variables setObject:[[XCVariable alloc] initWithName: name ]
                      forKey:name];
    }
}
+(id)parseWithTokenizer:(XCTokenizer *)tok andArg:(id)arg {
    return [XCVariable variableByName:[arg content]];
}
@end
