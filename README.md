# LCFastSingleton
Fast and safe to create singleton, and centralized management. Don't need to add any other code.

#### If you have used this way to create a singleton case.

    static XXX * xx = nil;
    if (!xx) {
        xx = [[XXX alloc] init];
    }
    return xx;
    
#### Or this.

    static XXX * xx = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        xx = [[XXX alloc] init];
    });
    return xx;
    
#### Now, You can discard all of those methods and use LCFastSingleton.

    DemoConfig.singleton.id = @(1);
    DemoConfig.singleton.type = @(2);
    DemoConfig.singleton.name = @"3";
    
    NSLog(@"DemoConfig singleton: id=%@, type=%@, name=%@", DemoConfig.singleton.id, DemoConfig.singleton.type, DemoConfig.singleton.name);
    
#### Safety LCFastSingleton.  

    DemoConfig * newDemoConfig = [[DemoConfig alloc] init];
    // The singleton is safe if the pointer same.
    NSLog(@"LCS P: %p Alloc newDemoConfig P:%p", DemoConfig.singleton, newDemoConfig);
    
#### You can also custom the method name on .h file. (Such as DemoConfig.XXSingleton.id)
    
    #define LC_SINGLETON_CUSTOM_METHOD_NAME singleton // You can custom the method name, for example: "singleton".

    
