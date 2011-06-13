//
//  MinitSampleModule.m
//  MinitSample
//
//  Created by Adrian Tofan on 13/06/11.
//  Copyright 2011 Adrian Tofan. All rights reserved.
//

#import "MinitSampleModule.h"

@implementation MinitSampleModule

-(void) configure{
  [self bind:[NSString class] named:@"MainWindow" toInstance:@"MainWindow_iPhone"];
}
@end