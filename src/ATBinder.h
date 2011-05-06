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
@protocol ATBinder

// Binds a |cls| to it's implementation class |immpl|
-(id<ATBinder>) bind:(Class) cls toImplementation:(Class) impl;

// Binds |cls| named |name| to it's implementation |impl|
-(id<ATBinder>) bind:(Class) cls named:(NSString*) name toImplementation:(Class) impl;

@end
