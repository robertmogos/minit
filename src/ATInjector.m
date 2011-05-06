/*
 * This file is part of the minit project.
 *
 * (c) Adrian Tofan http://di-objective-c.blogspot.com/
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */


#import "ATInjector.h"
#import "ATInjectable.h"
#import "ATKey.h"
// 'Provider' block
typedef id(^ProviderBlock)(void);

@implementation ATInjector
-(id) init{
  if (self = [super init]){
    bindings_ = [[NSMutableDictionary dictionaryWithCapacity:200] retain];
  }
  return self;
}

-(void) dealloc{
  [bindings_ release];
  [super dealloc];
}

#pragma mark Injection

// Tries to find a simple binding of |cls| and returns a wired instance. If there
// is no binding for |cls| builds and returns a instance.
-(id) instanceOf:(Class) cls{
  id result;
  ATKey *injectedKey = [ATKey keyWithClass:cls];
  ProviderBlock provider = [bindings_ objectForKey:injectedKey];
  if ( nil != provider) { return provider(); }
  // I guess that there is no point in validating if the |cls| responds to 
  // class_builder selector. If it dosen't it is a runtime error anyway
  result = [(id)cls class_builder:self];
  return result;
}

// Tries to find a named binding of |cls| and returns a wired instance. If there 
// is no named binding returns nil
-(id) instanceOf:(Class) cls named:(NSString*)name{
  ATKey *injectedKey = [ATKey keyWithClass:cls named:name];
  ProviderBlock provider = [bindings_ objectForKey:injectedKey];
  if ( nil != provider) { return provider();} 
  return nil;
}


-(id) instanceOf:(Class) cls annotated:(Class) annotation{
  return NULL; // not implemented
}

-(id) providerOf:(Class) cls{
  return NULL; // not implemented
}

-(id) providerOf:(Class) cls named:(NSString*)name{
  return NULL; // not implemented
}

-(id) providerOf:(Class) cls annotated:(Class) annotation{
  return NULL; // not implemented
}

#pragma mark Bindings
// Maps a provider capable of building |impl| to a |cls| key in |bindings_|
// Stores in |bindings_| a provider capable of building |impl|
-(id<ATBinder>) bind:(Class) cls toImplementation:(Class) impl{
  ATKey *key = [ATKey keyWithClass:cls];
  ProviderBlock provider = [[(id)^{
    return [(id)impl class_builder:self];
  } copy] autorelease];
  
  [bindings_ setObject:provider 
                forKey:key];
  return self;
}
// Maps a provider capable of building |impl| to a |cls| named |name| key in 
// |bindings_|
-(id<ATBinder>) bind:(Class) cls named:(NSString*) name toImplementation:(Class) impl{
  ATKey *key = [ATKey keyWithClass:cls named:name];
  ProviderBlock provider = [[(id)^{
    return [(id)impl class_builder:self];
  } copy] autorelease];
  
  [bindings_ setObject:provider 
                forKey:key];
  return self;
}

@end
