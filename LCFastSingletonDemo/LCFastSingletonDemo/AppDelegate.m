//
//  AppDelegate.m
//  LCFastSingletonDemo
//
//  Created by Licheng Guo . http://nsobject.me/ on 15/3/10.
//  Copyright (c) 2015年 Licheng Guo . http://nsobject.me/. All rights reserved.
//

#import "AppDelegate.h"
#import "NSObject+LCFastSingleton.h"


@interface DemoConfig : NSObject <FastSingleton>

@property(assign) NSInteger id;
@property(assign) NSInteger type;
@property(strong) NSString * name;

@end

@implementation DemoConfig

-(instancetype) singletonInit
{
    // Default settings.
    self.id = 1;
    self.type = 1;
    self.name = @"1";
    
    return self;
}

@end



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    
    NSLog(@"%@",DemoConfig.singleton.description);
    
    
    // Just Example.
    DemoConfig.singleton.id = 1;
    DemoConfig.singleton.type = 2;
    DemoConfig.singleton.name = @"3";

    
    NSLog(@"DemoConfig singleton: id=%@, type=%@, name=%@", @(DemoConfig.singleton.id), @(DemoConfig.singleton.type), DemoConfig.singleton.name);
    
    
    
    // Just a joke.
    NSDateFormatter.singleton.dateFormat = @"yyyy-MM-dd";
    
    NSLog(@"NSDateFormatter singleton: dateFormat=%@", NSDateFormatter.singleton.dateFormat);
    
    
    DemoConfig * newDemoConfig = [[DemoConfig alloc] init];
    
    
    // The singleton is safely if the pointer same.
    NSLog(@"LCS P: %p Alloc newDemoConfig P:%p", DemoConfig.singleton, newDemoConfig);
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
