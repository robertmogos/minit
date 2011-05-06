/*
 * This file is part of the minit project.
 *
 * (c) Adrian Tofan http://di-objective-c.blogspot.com/
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */

#import <Foundation/Foundation.h>
@class ATAnnotation;
// A binding key
//
@interface ATKey : NSObject <NSCopying>{
  @private
  Class cls_;
  ATAnnotation *annotation_; 
}

// returns a key for the |cls| class
+(id) keyWithClass:(Class) cls;
// returns a key a |cls| class named |name|
+(id) keyWithClass:(Class) cls named:(NSString* ) name;

-(Class)cls;
-(ATAnnotation*) annotation;
@end
