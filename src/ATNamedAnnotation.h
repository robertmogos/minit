//
//  ATNamedAnnotation.h
//  minit
//
//  Created by Adrian Tofan on 04/05/11.
//  Copyright 2011 Adrian Tofan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATAnnotation.h"

@interface ATNamedAnnotation : ATAnnotation {
 @protected
  NSString* name_;
}
-(id) initWithName:(NSString*) name;
-(NSString*) name;
@end
