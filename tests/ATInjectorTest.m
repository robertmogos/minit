/*
 * This file is part of the minit project.
 *
 * (c) Adrian Tofan http://di-objective-c.blogspot.com/
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */

#import <Foundation/Foundation.h>
#import "GTMSenTestCase.h"
#import "ATInjector.h"
#import "ATInject.h"

@interface A : NSObject{
@public BOOL initialized; 
}
-(id)init;
@end

@implementation A
// Builds with the help of the injector an instance of self and returns it
// |self| here is the class object, allowing to build instances of childs
// without needing to redefine class_builder if init signature is the same
+(id)class_builder:(id<ATInject>)inject{
  return [[[self alloc] init] autorelease];
}
-(id)init{
  if (self = [super init]){
    initialized = TRUE;
  }
  return self;
}
@end

@interface AA : A{
}
@end
@implementation AA
@end


@interface B: NSObject { 
@public
  A* a_;
}
-(id)init:(A*) a;
@end

@implementation B
+(id)class_builder:(id<ATInject>)inject;{
  A* a = [inject instanceOf:[A class]];
  return [[[self alloc] init:a ] autorelease];
}
-(id)init:(A*) a{
  if (self = [super init]){
    a_ = [a retain];
  }
  return self;
}

-(void) dealloc{
  [a_ release];
  [super dealloc];
}
@end



@interface ATInjectorTest : GTMTestCase {
}
@end


@implementation ATInjectorTest
-(void) testAInit{
  A* a = [A class_builder:NULL];
  STAssertTrue(a->initialized,@"Should be true after init");
}
-(void) testInjctionNoBinding{
  ATInjector *i = [[[ATInjector alloc] init] autorelease];
  B* b = [i instanceOf:[B class]];
  A* injectedA= b->a_;
  STAssertNotNil(injectedA,@"Should be true after init");
  STAssertTrue([injectedA isKindOfClass:[A class]],@"Should inject a A instance");
}
-(void) testInjctionWithSimpleClassBinding{
  ATInjector *i = [[[ATInjector alloc] init] autorelease];
  [i bind:[A class] toImplementation:[AA class]];
  id inejected = [i instanceOf:[A class]];
  STAssertTrue([inejected isKindOfClass:[AA class]],@"Should inject a AA instance instead of A");
}

@end
