//
//  NSMutableDictionary+checkNil.h
//  Ziker
//
//  Created by HansonYang on 16/8/11.
//  Copyright © 2016年 Ziker.hanson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (checkNil)


-(void)setObjectCheckNil:(id)anObject forKey:(id<NSCopying>)aKey;


@end
