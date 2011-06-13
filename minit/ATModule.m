/*
 * This file is part of the minit project.
 *
 * (c) Adrian Tofan http://di-objective-c.blogspot.com/
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */


#import "ATModule.h"
#import "ATInject.h"

@implementation ATModule

-(void) configureWithBinder:(id <ATBinder>) binder{
  binder_ = binder;
  [self configure];
  binder_ = nil;
}

// This should be implemented by subclasses
-(void) configure{
  [NSException raise:NSInternalInconsistencyException 
              format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];

}

-(id) configureWithInjector:(id <ATBinder>) injector{
  if (self = [super init]){
    binder_ = [(NSObject*)injector retain];
  }
  return self;
}

-(id<ATBinder>) bind:(Class) cls toInstance:(id) obj{
  [binder_ bind:cls toInstance:obj];
  return self;
}

-(id<ATBinder>) bind:(Class) cls 
               named:(NSString*) name 
          toInstance:(id) obj{
  [binder_ bind:cls named:name toInstance:obj];
  return self;
}

-(id<ATBinder>) bind:(Class) cls toImplementation:(Class) impl{
  [binder_ bind:cls toImplementation:impl];
  return self;
}

-(id<ATBinder>) bind:(Class) cls 
    toImplementation:(Class) impl 
             inScope:(Class) scope{
  [binder_ bind:cls toImplementation:impl inScope:scope];
  return self;
}

-(id<ATBinder>) bind:(Class) cls 
       annotatedWith:(Class) annotation 
    toImplementation:(Class) impl{
  [binder_ bind:cls annotatedWith:annotation toImplementation:impl];
  return self; 
}


// Binds |cls| annotated with |annotation| to it's implementation |impl| 
// in scope |scope|. |annotation| should be a kind of ATAnnotation
-(id<ATBinder>) bind:(Class) cls 
       annotatedWith:(Class) annotation 
    toImplementation:(Class) impl
             inScope:(Class) scope{
  [binder_ bind:cls annotatedWith:annotation toImplementation:impl inScope:scope];
  return self;
}


// Binds |cls| named |name| to it's implementation |impl|
-(id<ATBinder>) bind:(Class) cls 
               named:(NSString*) name 
    toImplementation:(Class) impl{
  [binder_ bind:cls named:name toImplementation:impl];
  return self;
}

// Binds |cls| named |name| to it's implementation |impl| in scope |scope|
-(id<ATBinder>) bind:(Class) cls 
               named:(NSString*) name 
    toImplementation:(Class) impl
             inScope:(Class) scope{
  [binder_ bind:cls named:name toImplementation:impl inScope:scope];
  return self;
}

-(void) dealloc{
  [super dealloc];
}

@end
