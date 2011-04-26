//
//  ATInjector.m
//  minit
//
//  Created by Adrian Tofan on 25/04/11.
//  Copyright 2011 Adrian Tofan. All rights reserved.
//

#import "ATInjector.h"


@implementation ATInjector

-(id) instanceOf:(Class) cls{
  return [cls class_builder:self];
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



@end
