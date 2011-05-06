/*
 * This file is part of the minit project.
 *
 * (c) Adrian Tofan http://di-objective-c.blogspot.com/
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */

#import "ATAnnotation.h"


@implementation ATAnnotation
// instance's hash is equal to class hash
- (NSUInteger)hash{
  return [[self class] hash];
}
// Two instances are equal if they have the same class
- (BOOL)isEqual:(id)anObject{
  return [anObject class] == [self class] ;
}

@end
