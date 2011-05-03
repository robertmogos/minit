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
-(id) instanceOf:(Class) cls;
-(id) instanceOf:(Class) cls named:(NSString*)name; 
-(id) instanceOf:(Class) cls annotated:(Class) annotation;
-(id) providerOf:(Class) cls;
-(id) providerOf:(Class) cls named:(NSString*)name;
-(id) providerOf:(Class) cls annotated:(Class) annotation;
@end
