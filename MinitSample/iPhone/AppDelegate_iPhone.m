//
//  AppDelegate_iPhone.m
//  MinitSample
//
//  Created by Adrian Tofan on 30/05/11.
//  Copyright 2011 Adrian Tofan. All rights reserved.
//

#import "AppDelegate_iPhone.h"
#import "ATInjector.h"
#import "MinitSampleModule.h"

@implementation AppDelegate_iPhone

@synthesize window=window_;


#pragma mark -
#pragma mark Application lifecycle

-(id) initWithXibName:(NSString *) xibName{
  if (self = [super init]) {
    xibName_ = [xibName copy];
  }
  return self;
}

-(id) init{
  [self release];
  NSArray *modules = [NSArray arrayWithObject:[MinitSampleModule class]];
  ATInjector *i = [ATInjector injectorWithModules:modules];
  return [[i instanceOf:[AppDelegate_iPhone class]] retain];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    [[NSBundle mainBundle] loadNibNamed:xibName_ owner:self options:nil];
    [xibNameLabel_ setText:xibName_];
    [window_ makeKeyAndVisible];
    
    return YES;
}

- (void)dealloc {
  [xibName_ release];
  [xibNameLabel_ release];
  [window_ release];
  [super dealloc];
}


@end
