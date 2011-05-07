/*
 * This file is part of the minit project.
 *
 * (c) Adrian Tofan http://di-objective-c.blogspot.com/
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */


#import <Foundation/Foundation.h>
#import "ATInject.h"
#import "ATBinder.h"
@class ATSingletonScope;

@interface ATInjector : NSObject <ATInject,ATBinder> {
 @protected
  // Holds all bidings 
  NSMutableDictionary* bindings_;
  // The singleton scope
  ATSingletonScope* singletonScope_;
}

@end
