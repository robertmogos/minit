//
//  AppDelegate_iPhone.h
//  MinitSample
//
//  Created by Adrian Tofan on 30/05/11.
//  Copyright 2011 Adrian Tofan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate_iPhone : NSObject <UIApplicationDelegate> {
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

-(id) initWithMessage:(NSString *) message;

@end

