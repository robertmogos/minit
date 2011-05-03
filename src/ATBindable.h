/*
 * This file is part of the minit project.
 *
 * (c) Adrian Tofan http://di-objective-c.blogspot.com/
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */

#import <UIKit/UIKit.h>

// Something that can bind a class to it's implementation. 
//
@protocol ATBindable
-(id<ATBindable>) bind:(Class) cls toImplementation:(Class) impl;
@end
