/*
 * This file is part of the minit project.
 *
 * (c) Adrian Tofan http://di-objective-c.blogspot.com/
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */


#import <Foundation/Foundation.h>
#import "ATAnnotation.h"

@interface ATNamedAnnotation : ATAnnotation {
 @protected
  NSString* name_;
}
-(id) initWithName:(NSString*) name;
-(NSString*) name;
@end
