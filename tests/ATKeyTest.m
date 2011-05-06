/*
 * This file is part of the minit project.
 *
 * (c) Adrian Tofan http://di-objective-c.blogspot.com/
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */

#import "ATKey.h"
#import "GTMSenTestCase.h"

@interface ATKeyTest: GTMTestCase{}
@end


@implementation ATKeyTest
-(void) testHashValuesAndComp{
  ATKey *first = [ATKey keyWithClass:[NSObject class]];
  ATKey *seccond = [ATKey keyWithClass:[NSObject class]];
  NSUInteger one = [first hash];
  NSUInteger two = [first hash];
  NSUInteger sec = [seccond hash];
  STAssertEquals(one,two,@"the hash to the same object should be identical between calls");
  STAssertEquals(sec,one,@"the hash on identical objects should be identiacl");
  STAssertTrue([first isEqual:seccond],@"");
  STAssertTrue([first isEqual:first],@"");
}

-(void) testNamedHashValuesAndComp{
  ATKey *first = [ATKey keyWithClass:[NSObject class] named:@"name"];
  ATKey *seccond = [ATKey keyWithClass:[NSObject class] named:@"name"];
  NSUInteger one = [first hash];
  NSUInteger two = [first hash];
  NSUInteger sec = [seccond hash];
  STAssertEquals(one,two,@"the hash to the same object should be identical between calls");
  STAssertEquals(sec,one,@"the hash on identical objects should be identiacl");
  STAssertTrue([first isEqual:seccond],@"");
  STAssertTrue([first isEqual:first],@"");
}

-(void) testAsDictKey{
  NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:2];
  ATKey *first = [ATKey keyWithClass:[NSObject class]];
  ATKey *seccond = [ATKey keyWithClass:[NSObject class]];
  [dict setObject:@"first" forKey:first];
  [dict setObject:@"seccond" forKey:seccond];
  NSString *value = [dict objectForKey:first];
  STAssertNotEquals(first,seccond,@"");
  STAssertEquals([dict count],(NSUInteger)1,@"");
  STAssertEqualStrings(value,@"seccond",@"");
}

-(void) testNamedAsDictKey{
  NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:2];
  ATKey *first = [ATKey keyWithClass:[NSObject class] named:@"name"];
  ATKey *seccond = [ATKey keyWithClass:[NSObject class] named:@"name"];
  [dict setObject:@"first" forKey:first];
  [dict setObject:@"seccond" forKey:seccond];
  NSString *value = [dict objectForKey:first];
  STAssertNotEquals(first,seccond,@"");
  STAssertEquals([dict count],(NSUInteger)1,@"");
  STAssertEqualStrings(value,@"seccond",@"");
}
@end
