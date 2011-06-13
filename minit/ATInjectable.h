/*
 * This file is part of the minit project.
 *
 * (c) Adrian Tofan http://di-objective-c.blogspot.com/
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */

#import <UIKit/UIKit.h>

@protocol ATInject;

/*
 * Something which can build himself assisted by a injector
 */
@protocol ATInjectable
// Uses injector to build an instance of self and returns it
+(id)class_builder:(id<ATInject>)inject;
@end
