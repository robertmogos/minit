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



@interface ATModule : NSObject <ATBinder>{
  id <ATBinder> injector_;
}
-(id) initWithInjector:(id <ATBinder>) injector;
@end
