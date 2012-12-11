//
//  XCCircBuf.m
//  XCCalc
//
//  Created by Christoph Cwelich on 10.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCCircBuf.h"

@implementation XCCircBuf
@synthesize maxSize = _maxSize;
@synthesize size = _size;

-(id)initWithMaxSize:(NSUInteger)ms {
    self = [super init];
    _data = [NSMutableArray arrayWithCapacity:ms];
    _tail = _size = 0;
    _head = -1;
    _maxSize = ms;
    return self;
}
-(BOOL)isEmpty {
    return !_size;
}
-(BOOL)isFull {
    return _size == _maxSize;
}
-(id)head {
    return (_size) ? _data[_head] : nil;
}
-(id)tail {
    return (_size) ? _data[_tail] : nil;
}
-(id)elementAtIndex:(NSUInteger)index {
    return _data[(_tail + index) % _maxSize];
}

-(BOOL)push:(id)element {
    if([self isFull]) {
        return false;
    } else {
        ++_size;
        ++_head;
        _head %= _maxSize;
        _data[_head]=element;
        return true;
    }
}

-(id)dequeue {
    if(_size) {
        --_size;
        id rc = _data[_tail++];
        _tail %= _maxSize;
        return rc;
    } else {
        return nil;
    }
}



-(NSString *)description {
    if ([self isEmpty]) {
        return @"[]";
    } else {
        assert(_size>0);
        NSMutableString * rc = [NSMutableString stringWithFormat:@"[%@",
                [_data[_tail] description]];
        for (NSUInteger i=1; i<_size; i++) {
            [rc appendFormat:@", %@",
             [[self elementAtIndex:i] description]];
        }
        [rc appendString:@"]"];
        return rc;
    }
}

@end
