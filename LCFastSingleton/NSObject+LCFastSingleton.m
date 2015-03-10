//
//  NSObject+LCFastSingleton.m
//  LCFastSingleton

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com / https://github.com/titman ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "NSObject+LCFastSingleton.h"

static NSMutableDictionary * __instanceDatasource = nil;

@implementation NSObject (LCFastSingleton)

+(instancetype) LC_SINGLETON_CUSTOM_METHOD_NAME
{
    return [self LCSingleton];
}

+(instancetype) LCSingleton
{
    @synchronized(__instanceDatasource){
        
        NSMutableDictionary * datasource = self.shareInstanceDatasource;
        
        NSString * selfClass = [[self class] description];
        
        id __singleton__ = datasource[selfClass];
        
        if (datasource[selfClass]) {
            return __singleton__;
        }
        
        __singleton__ = [[self alloc] init];
        
        [self setObjectToInstanceDatasource:__singleton__];
        
        NSLog(@"[LCFastSingleton] %@ singleton inited.",[__singleton__ class]);
        
        return __singleton__;
        
    }
}

+(NSMutableDictionary *) shareInstanceDatasource
{
    @synchronized(__instanceDatasource){
        
        if (!__instanceDatasource) {
            __instanceDatasource = [[NSMutableDictionary alloc] init];
        }
    }
    
    return __instanceDatasource;
}

+(BOOL) setObjectToInstanceDatasource:(id)object
{
    NSString * objectClass = [[object class] description];
    
    if (!object) {
        NSLog(@"Instence init fail.");
        return NO;
    }
    
    if (!objectClass) {
        NSLog(@"Instence class error.");
        return NO;
    }
    
    self.shareInstanceDatasource[objectClass] = object;
    
    return YES;
}

@end
