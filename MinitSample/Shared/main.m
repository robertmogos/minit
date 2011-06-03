//
//  main.m
//  MinitSample
//
//  Created by Adrian Tofan on 30/05/11.
//  Copyright 2011 Adrian Tofan. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, @"MinitSampleApplication", @"AppDelegate_iPhone");
    [pool release];
    return retVal;
}
