//
//  ATInject.h
//  minit
//
//  Created by Adrian Tofan on 25/04/11.
//  Copyright 2011 Adrian Tofan. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ATInject
-(id) instanceOf:(Class) cls;
-(id) instanceOf:(Class) cls named:(NSString*)name; 
-(id) instanceOf:(Class) cls annotated:(Class) annotation;
-(id) providerOf:(Class) cls;
-(id) providerOf:(Class) cls named:(NSString*)name;
-(id) providerOf:(Class) cls annotated:(Class) annotation;

@end
