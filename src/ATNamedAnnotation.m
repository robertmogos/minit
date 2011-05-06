//
//  ATNamedAnnotation.m
//  minit
//
//  Created by Adrian Tofan on 04/05/11.
//  Copyright 2011 Adrian Tofan. All rights reserved.
//

#import "ATNamedAnnotation.h"


@implementation ATNamedAnnotation

-(id) initWithName:(NSString*) name{
  if (self = [super init]){
    name_ = [[name copy] retain];
  }
  return self;
}

-(NSString*) name{
  return name_;
}


- (NSUInteger)hash{
  return [[self class] hash] + [name_ hash];
}

// Two instances are equal if they have the same class and the same name
- (BOOL)isEqual:(id)anObject{
  BOOL sameClass = [anObject class] == [self class];
  NSString* name = [anObject name];
  BOOL sameName = (name_ == nil) && (name == nil);
  if (!sameName) {
    sameName = [name isEqualToString:name_];
  }
  return sameClass && sameName;
}

-(void) dealloc{
  [name_ release];
  [super dealloc];
}
@end
