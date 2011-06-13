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
#import "ATModule.h"

@interface A : NSObject{
}
@end

@implementation A
+(id)class_builder:(id<ATInject>)inject{
  return [[[self alloc] init] autorelease];
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
  A* aa_;
  A* aaa_;
}
-(id)init:(A*) a seccond:(A*)aa third:(A*) aaa;
@end

@implementation B
+(id)class_builder:(id<ATInject>)inject{
  A* a = [inject instanceOf:[A class]];    
  A* aa = [inject instanceOf:[AA class]]; 
  A* aaa = [inject instanceOf:[AA class] named:@"3A"];
  return [[[self alloc] init:a seccond:aa third:aaa] autorelease];
}
-(id)init:(A*) a seccond:(A*)aa third:(A*) aaa{
  if (self = [super init]){
    a_ = [a retain];
    aa_ = [aa retain];
    aaa_ = [aaa retain];
  }
  return self;
}

-(void) dealloc{
  [a_ release];
  [aa_ release];
  [aaa_ release];
  [super dealloc];
}
@end


@interface S : NSObject{
}
@end

@implementation S
+(id)class_builder:(id<ATInject>)inject{
  return [[[self alloc] init] autorelease];
}
@end

@interface Si : NSObject{
}
@end
@implementation Si
// no class_builder method because it is bound to instance
@end

//
@interface TestModule : ATModule
@end
@implementation TestModule
-(void) configure{
  [self bind:[A class] toImplementation:[AA class]];
  [self bind:[AA class] named:@"3A"  toImplementation:[AAA class]];
  [self bind:[AA class] named:@"AASingleton" toImplementation:[AA class] inScope:[ATSingletonScope class]];
  [self bind:[S class] toImplementation:[S class] inScope:[ATSingletonScope class]];
  Si * si = [[[Si alloc] init] autorelease];
  [self bind:[Si class] toInstance:si];
  [self bind:[S class] named:@"SuperS" toInstance:si];
}
@end




@interface ATInjectorTest : GTMTestCase {
}
@end


@implementation ATInjectorTest

-(void) testThatDependenciesAreInjected{
  ATInjector *i = 
    [ATInjector injectorWithModules:[NSArray arrayWithObject:[TestModule class]]];
  B* b = [i instanceOf:[B class]];
  STAssertTrue([b->a_ isKindOfClass:[AA class]],@"Direct binding - should return a AA instance");
  STAssertTrue([b->aa_ isKindOfClass:[AA class]],@"No binding - should return a AA instance"); 
  STAssertTrue([b->aaa_ isKindOfClass:[AAA class]],@"Named binding - return a AAA instance");
  Si *si_1 = [i instanceOf:[Si class]]; // instance bound
  Si *si_2 = [i instanceOf:[Si class]]; // instance bound
  STAssertTrue([si_1 isKindOfClass:[Si class]],@"Si instance should be returned");
  STAssertEquals(si_1,si_2,@"The same instance should be returned");
  si_1 = [i instanceOf:[S class] named:@"SuperS"]; // instance bound
  si_2 = [i instanceOf:[S class] named:@"SuperS"]; // instance bound
  STAssertTrue([si_1 isKindOfClass:[Si class]],@"Si instance should be returned");
  STAssertEquals(si_1,si_2,@"The same instance should be returned");
  
}


-(void) testSingletons{
  ATInjector *i = 
    [ATInjector injectorWithModules:[NSArray arrayWithObject:[TestModule class]]];
  id first = [i instanceOf:[AA class] named:@"AASingleton"];
  id seccond  = [i instanceOf:[AA class] named:@"AASingleton"];
  STAssertEquals(first,seccond,@"the same instance should be injected when singleton bound");
  STAssertTrue([seccond isKindOfClass:[AA class]],@"AASingleton should have AA type");
  first = [i instanceOf:[S class]];
  seccond = [i instanceOf:[S class]];
  STAssertEquals(first,seccond,@"the same instance should be injected when singleton bound");
  STAssertTrue([seccond isKindOfClass:[S class]],@"S class instance expected");
}


-(void) testFailures{
  ATInjector *i = [[[ATInjector alloc] init] autorelease];
  A* inejected = [i instanceOf:[A class] named:@"UNBOUND"];
  STAssertNil(inejected,@"If there is no binding named UNBOUND it should return nil");
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
