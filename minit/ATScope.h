/*
 * This file is part of the minit project.
 *
 * (c) Adrian Tofan http://di-objective-c.blogspot.com/
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */


#import <Foundation/Foundation.h>
#import "ATProviderBlock.h"

@class ATKey;

@protocol ATScope

// It should return a scoped provider for |key|. It may use the unscoped |provider| 
// to build the object when needed.
-(ATProviderBlock) scope:(ATKey*)key unscoped:(ATProviderBlock)provider;

@end
