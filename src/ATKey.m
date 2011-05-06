/*
 * This file is part of the minit project.
 *
 * (c) Adrian Tofan http://di-objective-c.blogspot.com/
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */

#import "ATKey.h"
#import "ATAnnotation.h"
#import "ATNamedAnnotation.h"

@implementation ATKey
-(id) initWithClass:(Class) cls annotation:(ATAnnotation*)annotation{
  if (self = [super init]){
    cls_ = [cls retain];
    annotation_ = [annotation retain];
  }
  return self;
}


-(id) initWithClass:(Class) cls named:(NSString*)name{
  if (self = [super init]){
    cls_ = [cls retain];
    annotation_ = [[ATNamedAnnotation alloc] initWithName:name];;
  }
  return self;
}

+(id) keyWithClass:(Class) cls named:(NSString* ) name{
  return [[[ATKey alloc] initWithClass:cls named:name] autorelease];
}


// 
+(id) keyWithClass:(Class) cls{
  return [[[ATKey alloc] initWithClass:cls annotation:nil] autorelease];
}


- (NSUInteger)hash{
  return [cls_ hash] + [annotation_ hash];
}

- (BOOL)isEqual:(id)anObject{ // this is to complex !
  Class comp_cls = [(ATKey*)anObject cls];
  ATAnnotation* comp_ano = [(ATKey*)anObject annotation];
  if ( comp_cls != cls_ ) return FALSE;
  if ( (comp_ano == NULL) && (annotation_ == NULL)) return TRUE;
  return [annotation_ isEqual:comp_ano];
  }
-(Class)cls{
  return cls_;
}
-(ATAnnotation*) annotation{
  return annotation_;
}

// As this class is imutable we can return |self|
-(id) copyWithZone:(NSZone *)zone{
  return [self retain];
}

-(void) dealloc{
  [cls_ release];
  [annotation_ release];
  [super dealloc];
}
@end
