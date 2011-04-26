//
//  ATModuleTest.m
//  minit
//
//  Created by Adrian Tofan on 25/04/11.
//  Copyright 2011 Adrian Tofan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTMSenTestCase.h"
#import "ATInjector.h"
#import "ATModule.h"
#import "ATInject.h"
@interface ATTestModule : ATModule{
}
@end
@implementation ATTestModule
@end

@interface A : NSObject{
  BOOL initialized; 
}
-(id)init;
-(BOOL) getInitialized;
+(id)class_builder:(id<ATInject>)inject;

@end

@implementation A

+(id)class_builder:(id<ATInject>)inject{
  return [[[A alloc] init] autorelease];
}

-(id)init{
  if (self = [super init]){
    initialized = TRUE;
  }
  return self;
}

-(BOOL) getInitialized{
  return initialized;
}
@end

@interface B: NSObject
{
  A* _a;
}
-(id)init:(A*) a;
-(A*) getA;
+(id)class_builder:(id<ATInject>)inject;

@end

@implementation B

+(id)class_builder:(id<ATInject>)inject;{
  return [[[B alloc] init:[inject instanceOf:[A class]]
           ] autorelease];
}

-(id)init:(A*) a{
  if (self = [super init]){
    _a = [a retain];
  }
  return self;
}

-(A*) getA{
  return _a;
}
-(void) dealloc{
  [_a release];
  [super dealloc];
}

@end



@interface ATModuleTest : GTMTestCase {
}
@end
@implementation ATModuleTest
-(void) testAInit{
  A* a = [A class_builder:NULL];
  STAssertTrue([a getInitialized],@"Should be true after init");
}
-(void) testBInit{
  ATInjector *i = [[[ATInjector alloc] init] autorelease];
  
  B* b = [i instanceOf:[B class]];
  STAssertNotNil([b getA],@"Should be true after init");
}
@end
