/*
 * This file is part of the minit project.
 *
 * (c) Adrian Tofan http://di-objective-c.blogspot.com/
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */


#import <Foundation/Foundation.h>
#import "ATBinder.h"

// Configuration class for modules 
// Extend this class, implement configure and call the ATBinder protocol methods
// Example:

@interface ATModule : NSObject <ATBinder>{
  id <ATBinder> binder_;
}
// Implement this method
-(void) configure;

// Loads module's configuration using binder
-(void) configureWithBinder:(id <ATBinder>) binder;

@end  