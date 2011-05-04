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

-(id) instanceOf:(Class) cls named:(NSString*)name{
  return NULL; // not implemented
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

-(id<ATBindable>) bind:(Class) cls toImplementation:(Class) impl{
  ATKey *key = [ATKey keyWithClass:cls];
  ProviderBlock provider = [[(id)^{
    return [(id)impl class_builder:self];
  } copy] autorelease];
  
  [bindings_ setObject:provider 
                forKey:key];
  return self;
}
   
-(void) dealloc{
  [bindings_ release];
  [super dealloc];
}
@end
