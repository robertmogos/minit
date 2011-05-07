/*
 * This file is part of the minit project.
 *
 * (c) Adrian Tofan http://di-objective-c.blogspot.com/
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */


#import <Foundation/Foundation.h>
#import "ATScope.h"

// Provides the same instances of objects in the context of the injector. 
// 
@interface ATSingletonScope : NSObject <ATScope> {
  @protected
  // holds already created instances
  NSMutableDictionary* instances_;
}

@end
