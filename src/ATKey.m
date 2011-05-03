/*
 * This file is part of the minit project.
 *
 * (c) Adrian Tofan http://di-objective-c.blogspot.com/
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */

#import "ATKey.h"


@implementation ATKey
-(id) initWithClass:(Class) cls{
  if (self = [super init]){
    cls_ = [cls retain]; // ?
  }
  return self;
}
+(id) keyWithClass:(Class) cls{
   return [[[ATKey alloc] initWithClass:cls] autorelease];
}
- (NSUInteger)hash{
  return [cls_ hash] + [annotation_ hash];
}

- (BOOL)isEqual:(id)anObject{ // this is to complex !
  Class comp_cls = [(ATKey*)anObject cls];
  NSString* comp_ano = [(ATKey*)anObject annotation];
  if ( comp_cls != cls_ ) return FALSE;
  if ( (comp_ano == NULL) && (annotation_ == NULL)) return TRUE;
  return [annotation_ isEqualToString:comp_ano];
  }
-(Class)cls{
  return cls_;
}
-(NSString*) annotation{
  return annotation_;
}

// As this class is imutable we can return |self|
-(id) copyWithZone:(NSZone *)zone{
  return [self retain];
}

-(void) dealloc{
  [cls_ release];
  [super dealloc];
}
@end
