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
#import "ATProviderBlock.h"
#import "ATSingletonScope.h"
#import "ATModule.h"

// This implementation is not thread safe !

@implementation ATInjector
-(id) init{
  if (self = [super init]){
    bindings_ = [[NSMutableDictionary dictionaryWithCapacity:200] retain];
    singletonScope_ = [[ATSingletonScope alloc] init];
  }
  return self;
}

-(void) dealloc{
  [bindings_ release];
  [singletonScope_ release];
  [super dealloc];
}

#pragma mark Loading modules

// Creates injector instance and calls to helper configureModules: before
// returning it
+(ATInjector*) injectorWithModules:(NSArray*) modules{
    ATInjector *injector = [[[ATInjector alloc] init] autorelease];
    [injector configureModules:modules];
    return injector;
}

// creates a instance of each module and calls configure method on them
-(void) configureModules:(NSArray*) modules{
    for(Class moduleClass in modules){
      id module = [[[moduleClass alloc] init] autorelease];
      if([module isKindOfClass:[ATModule class]]){
        [(ATModule*)module configureWithBinder:self];
      }else {
        NSLog(@"%@ is not a ATModule. Unable to load configuration",[module description]);
      }
    }
}

#pragma mark Injection

// Tries to find a simple binding of |cls| and returns a wired instance. If there
// is no binding for |cls| builds and returns a instance.
-(id) instanceOf:(Class) cls{
  id result;
  ATKey *injectedKey = [ATKey keyWithClass:cls];
  ATProviderBlock provider = [bindings_ objectForKey:injectedKey];
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
  ATProviderBlock provider = [bindings_ objectForKey:injectedKey];
  if ( nil != provider) { return provider();} 
  return nil;
}


-(id) instanceOf:(Class) cls annotated:(Class) annotation{
  return NULL; // not implemented
}

-(ATProviderBlock) providerOf:(Class) cls{
  ATProviderBlock provider = [[(id)^{
    return [self instanceOf:cls];
  } copy] autorelease];
  return provider;
}

-(ATProviderBlock) providerOf:(Class) cls named:(NSString*)name{
  ATProviderBlock provider = [[(id)^{
    return [self instanceOf:cls named:name];
  } copy] autorelease];
  return provider;
}

// Retruns a provider block of |cls| annotated with annotated with |annotation|
-(ATProviderBlock) providerOf:(Class) cls annotated:(Class) annotation{
  ATProviderBlock provider = [[(id)^{
    return [self instanceOf:cls annotated:annotation];
  } copy] autorelease];
  return provider;
}


#pragma mark Bindings
// registers a |key| bounded |provider| in |bindings_|
-(void) setBinding:(ATProviderBlock)provider forKey:(ATKey*)key{
  [bindings_ setObject:provider 
                forKey:key];
}

// binds a provider returning |obj| instance in |bindings_|
-(id<ATBinder>) bind:(Class) cls toInstance:(id) obj{
  ATKey *key = [ATKey keyWithClass:cls];
  ATProviderBlock provider = [[(id)^{
    return obj;
  } copy] autorelease];
  
  [bindings_ setObject:provider 
                forKey:key];
  return self;
}


// Maps a provider capable of building |impl| to a |cls| key in |bindings_|
// Stores in |bindings_| a provider capable of building |impl|
-(id<ATBinder>) bind:(Class) cls toImplementation:(Class) impl{
  ATKey *key = [ATKey keyWithClass:cls];
  ATProviderBlock provider = [[(id)^{
    return [(id)impl class_builder:self];
  } copy] autorelease];
  
  [bindings_ setObject:provider 
                forKey:key];
  return self;
}

// binds a provider returning |obj| instance in |bindings_| for a |name| named key
-(id<ATBinder>) bind:(Class) cls 
               named:(NSString*) name 
          toInstance:(id) obj{
  ATKey *key = [ATKey keyWithClass:cls named:name];
  ATProviderBlock provider = [[(id)^{
    return obj;
  } copy] autorelease];
  
  [bindings_ setObject:provider 
                forKey:key];
  return self;
}

// Maps a provider capable of building |impl| to a |cls| named |name| key in 
// |bindings_|
-(id<ATBinder>) bind:(Class) cls named:(NSString*) name toImplementation:(Class) impl{
  ATKey *key = [ATKey keyWithClass:cls named:name];
  ATProviderBlock provider = [[(id)^{
    return [(id)impl class_builder:self];
  } copy] autorelease];
  
  [self setBinding:provider forKey:key];
  return self;
}

// Maps a SCOPED provider capable of building |impl| to a |cls|  key in 
// |bindings_|
-(id<ATBinder>) bind:(Class) cls 
    toImplementation:(Class) impl 
             inScope:(Class) scope{
  if (scope != [ATSingletonScope class]) {
    // Maybe we should die nicely instead?
    return [self bind:cls toImplementation:impl]; 
  }
  ATProviderBlock provider = [[(id)^{
    return [(id)impl class_builder:self];
  } copy] autorelease];
  ATKey *key = [ATKey keyWithClass:cls];
  ATProviderBlock scoped = [singletonScope_ scope:key unscoped:provider];
  [self setBinding:scoped forKey:key];
  return self;
  
}

// Maps a SCOPED provider capable of building |impl| to a |cls| named |name| key in 
// |bindings_|
-(id<ATBinder>) bind:(Class) cls 
               named:(NSString*) name 
    toImplementation:(Class) impl
             inScope:(Class) scope{
  
  if (scope != [ATSingletonScope class]) {
    // Maybe we should die nicely instead?
    return [self bind:cls named:name toImplementation:impl]; 
  }
  ATProviderBlock provider = [[(id)^{
    return [(id)impl class_builder:self];
  } copy] autorelease];
  ATKey *key = [ATKey keyWithClass:cls named:name];
  ATProviderBlock scoped = [singletonScope_ scope:key unscoped:provider];
  [self setBinding:scoped forKey:key];
  return self;
}


-(id<ATBinder>) bind:(Class) cls 
       annotatedWith:(Class) annotation 
    toImplementation:(Class) impl{
  [NSException raise:NSInternalInconsistencyException 
              format:@"Not implemented"];
  return nil;
}



-(id<ATBinder>) bind:(Class) cls 
       annotatedWith:(Class) annotation 
    toImplementation:(Class) impl
             inScope:(Class) scope{
  [NSException raise:NSInternalInconsistencyException 
              format:@"Not implemented"];
  return nil;
}
@end
