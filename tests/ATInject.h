/*
 * This file is part of the minit project.
 *
 * (c) Adrian Tofan http://di-objective-c.blogspot.com/
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */


#import <UIKit/UIKit.h>

/**
 * Something which can inject instances 
 */
@protocol ATInject

// Builds and returns a wired instance of |cls| kind of object
-(id) instanceOf:(Class) cls;

// Builds and returns a wired instance of |cls| kind of object named |name|
-(id) instanceOf:(Class) cls named:(NSString*)name; 

// Builds and returns a wired instance of |cls| kind of object annotated with
// |annotation|
-(id) instanceOf:(Class) cls annotated:(Class) annotation;

-(id) providerOf:(Class) cls;

-(id) providerOf:(Class) cls named:(NSString*)name;

-(id) providerOf:(Class) cls annotated:(Class) annotation;

@end
