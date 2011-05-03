/*
 * This file is part of the minit project.
 *
 * (c) Adrian Tofan http://di-objective-c.blogspot.com/
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */


#import "ATModule.h"


@implementation ATModule

-(id) initWithInjector:(id <ATInject>) injector{
  if (self = [super init]){
    injector_ = [(NSObject*)injector retain];
  }
  return self;
}


-(void) dealloc{
  [(NSObject*) injector_ release];
  [super dealloc];
}

@end
