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
#import "ATSingletonScope.h"

@interface A : NSObject{
@public BOOL initialized_; 
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
    initialized_ = TRUE;
  }
  return self;
}
@end

@interface AA : A{
}
@end
@implementation AA
@end

@interface AAA : AA{
}
@end
@implementation AAA
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
  STAssertTrue(a->initialized_,@"Should be true after init");
}
-(void) testInjctionNoBinding{
  ATInjector *i = [[[ATInjector alloc] init] autorelease];
  B* b = [i instanceOf:[B class]];
  A* injectedA= b->a_;
  STAssertNotNil(injectedA,@"Should be true after init");
  STAssertTrue([injectedA isKindOfClass:[A class]],@"Should retourn a A instance");
}
-(void) testInjctionWithSimpleClassBinding{
  ATInjector *i = [[[ATInjector alloc] init] autorelease];
  [i bind:[A class] toImplementation:[AA class]];
  id inejected = [i instanceOf:[A class]];
  STAssertTrue([inejected isKindOfClass:[AA class]],@"retruned AA instance instead of A");
}

-(void) testInjctionWithNamedClassBinding{
  ATInjector *i = [[[ATInjector alloc] init] autorelease];
  [i bind:[A class] named:@"MARKER" toImplementation:[AA class]];
  id inejected = [i instanceOf:[A class]];
  STAssertTrue([inejected isKindOfClass:[A class]],@"retruned AA instance instead of A");
  inejected = [i instanceOf:[A class] named:@"MARKER"];
  STAssertTrue([inejected isKindOfClass:[AA class]],@"retruned AA instance instead of A");
  inejected = [i instanceOf:[A class] named:@"UNBOUND"];
  STAssertNil(inejected,@"If there is no binding named UNBOUND it should return nil");
}

-(void) testSingletonBindings{
  ATInjector *i = [[[ATInjector alloc] init] autorelease];
  [i bind:[A class] named:@"MARKER" toImplementation:[AA class] inScope:[ATSingletonScope class]];
  id inejected = [i instanceOf:[A class]];
  STAssertTrue([inejected isKindOfClass:[A class]],@"retruned AA instance instead of A");
  id first = [i instanceOf:[A class] named:@"MARKER"];
  STAssertTrue([first isKindOfClass:[AA class]],@"retruned AA instance instead of A");
  id seccond  = [i instanceOf:[A class] named:@"MARKER"];
  STAssertTrue([seccond isKindOfClass:[AA class]],@"If there is no binding named UNBOUND it should return nil");
  STAssertEquals(first,seccond,@"the same instance should be injected when singleton bound");
}
-(void) testProviderInjection{
  ATInjector *i = [[[ATInjector alloc] init] autorelease];
  ATProviderBlock p = [i providerOf:[A class]];
  A * a1 = p();
  A * a2 = p();
  STAssertTrue([a1 isKindOfClass:[A class]],@"should provide a instance of A");
  STAssertTrue([a2 isKindOfClass:[A class]],@"should provide a instance of A");
  STAssertNotEquals(a1,a2,@"should provide a instance of A");
  [i bind:[A class] toImplementation:[AA class]];
  a1 = p();
  STAssertTrue([a1 isKindOfClass:[AA class]],@"should provide a instance of AA");
  [i bind:[A class] named:@"MARKER" toImplementation:[AAA class]];
  ATProviderBlock pp = [i providerOf:[A class] named:@"MARKER"];
  a1 = pp();
  a2 = p();
  STAssertTrue([a2 isKindOfClass:[AA class]],@"should provide a instance of AA");
  STAssertTrue([a1 isKindOfClass:[AAA class]],@"should provide a instance of AAA");

}
@end
