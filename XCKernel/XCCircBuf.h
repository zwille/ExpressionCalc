//
//  XCCircBuf.h
//  XCCalc
//
//  Created by Christoph Cwelich on 10.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCCircBuf : NSObject {
    NSMutableArray * _data;
    NSUInteger _head, _tail, _size, _maxSize;
}
@property NSUInteger maxSize;
@property NSUInteger size;

-(id) initWithMaxSize: (NSUInteger) ms;
-(BOOL) isEmpty;
-(BOOL) isFull;
-(id) elementAtIndex: (NSUInteger) index;
-(id) head;
-(id) tail;
-(BOOL) push: (id) element;
-(id) pop;
//-(BOOL) queue;
-(id) dequeue;

@end
