/*
 * This file is part of the minit project.
 *
 * (c) Adrian Tofan http://di-objective-c.blogspot.com/
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */

#import <Foundation/Foundation.h>

// Something that can bind a class to it's implementation. 
//
@protocol ATBinder

// Binds a |cls| to a object
-(id<ATBinder>) bind:(Class) cls toInstance:(id) obj;


// Binds a |cls| to it's implementation class |immpl|
-(id<ATBinder>) bind:(Class) cls toImplementation:(Class) impl;

// Binds a |cls| to it's implementation class |impl| in scope |scope|
-(id<ATBinder>) bind:(Class) cls 
    toImplementation:(Class) impl 
             inScope:(Class) scope;

// Binds |cls| annotated with |annotation| to it's implementation |impl|. |annotation|
// should be a kind of ATAnnotation
-(id<ATBinder>) bind:(Class) cls 
       annotatedWith:(Class) annotation 
    toImplementation:(Class) impl;


// Binds |cls| annotated with |annotation| to it's implementation |impl| 
// in scope |scope|. |annotation| should be a kind of ATAnnotation
-(id<ATBinder>) bind:(Class) cls 
       annotatedWith:(Class) annotation 
    toImplementation:(Class) impl
             inScope:(Class) scope;


// Binds |cls| named |name| to it's implementation |impl|
-(id<ATBinder>) bind:(Class) cls 
               named:(NSString*) name 
    toImplementation:(Class) impl;

// Binds |cls| named |name| to it's implementation |impl| in scope |scope|
-(id<ATBinder>) bind:(Class) cls 
               named:(NSString*) name 
    toImplementation:(Class) impl
             inScope:(Class) scope;


@end
