/*
 * This file is part of the minit project.
 *
 * (c) Adrian Tofan http://di-objective-c.blogspot.com/
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */


#import "ATSingletonScope.h"

// This implementation is not thread safe !

@implementation ATSingletonScope

-(id) init{
  if (self = [super init]){
    instances_ = [[NSMutableDictionary dictionaryWithCapacity:200] retain];
  }
  return self;
}

-(void) dealloc{
  [instances_ release];
  [super dealloc];
}

// If it doesen
-(ATProviderBlock) scope:(ATKey*)key unscoped:(ATProviderBlock)provider{
  return [[(id)^{      
    id scoped  = [instances_ objectForKey:key];
    if (nil == scoped) {
      scoped = provider();
      [instances_ setObject:scoped forKey:key];
    }
    return scoped;
  } copy] autorelease];
}
@end
