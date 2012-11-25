//
//  XCVariable.m
//  ExprCalc
//
//  Created by Christoph Cwelich on 23.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCVariable.h"
static NSMutableDictionary * variables = nil;
static NSArray * names = nil;

@implementation XCVariable
@synthesize name = _name;
-(XCNumber *)value{
    return _value;
}
-(id)initWithName:(NSString *)name{
    self = [super init];
    _name = name;
    _value = [[XCNumber alloc] initWithDouble:0.0];
    return self;
}
+(XCVariable *)variableByName:(NSString *)name{
    return [variables objectForKey:name];
}
+(NSArray *)variableNames{
    return names;
}
+(void)initialize{
    names = [NSArray arrayWithObjects:@"a",@"b",@"c",@"d", nil];
    variables = [[NSMutableDictionary alloc] initWithCapacity:9];
    for (NSString* name in names) {
        [variables setObject:[[XCVariable alloc] initWithName: name ]
                      forKey:name];
    }
}
+(id)parseWithTokenizer:(XCTokenizer *)tok andArg:(id)arg {
    assert(arg!=nil);
    return [XCVariable variableByName:[arg content]];
}
@end
