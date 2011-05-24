/*
 * This file is part of the minit project.
 *
 * (c) Adrian Tofan http://di-objective-c.blogspot.com/
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */


#import <Foundation/Foundation.h>


@interface ClassA : NSObject {

}
/**
  A simple initializer annotated for dependency injection [minit]
  @param str - this will be simply injected as a string
  @param named @@InjectNamed SomeString
  @param anno @@AnnotatedString
  @returns a newly initialized object
 */
-(id) initWithString:(NSString*)str namedString:(NSString*)named annotatedString:(NSString*)anno;


@end
s