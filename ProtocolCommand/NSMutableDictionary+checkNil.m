//
//  NSMutableDictionary+checkNil.m
//  Ziker
//
//  Created by HansonYang on 16/8/11.
//  Copyright © 2016年 Ziker.hanson. All rights reserved.
//

#import "NSMutableDictionary+checkNil.h"

@implementation NSMutableDictionary (checkNil)

-(void)setObjectCheckNil:(id)anObject forKey:(id<NSCopying>)aKey{

    NSString *object ;
    
    BOOL  isNull = NO;
    
    if(anObject==nil) {
            isNull = YES;
    }
    
    if([anObject isEqual:[NSNull null] ]) {
        isNull = YES;
    }
    
    if (isNull) {
         object =  @"";
        [self setObject:object forKey:aKey];
        
    }else{
        [self setObject:anObject forKey:aKey];
        
    }
}

@end
