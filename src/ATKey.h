/*
 * This file is part of the minit project.
 *
 * (c) Adrian Tofan http://di-objective-c.blogspot.com/
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */

#import <Foundation/Foundation.h>

// A binding key
//
@interface ATKey : NSObject <NSCopying>{
  @private
  Class cls_;
  NSString *annotation_; 
}

+(id) keyWithClass:(Class) cls;
-(Class)cls;
-(NSString*) annotation;
@end
