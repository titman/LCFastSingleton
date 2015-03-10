# LCFastSingleton
Quickly create singleton, and centralized management.

You perhaps create every singleton use this way.

    static XXX * xx = nil;
    if (!xx) {
        xx = [[XXX alloc] init];
    }
    return xx;
    
Or this.

    static XXX * xx = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        xx = [[XXX alloc] init];
    });
    return xx;
    
Now, You can discard all of those methods and use LCFastSingleton.
For example.
    
    DemoConfig.LCS.id = @(1);
    DemoConfig.LCS.type = @(2);
    DemoConfig.LCS.name = @"3";
    
    NSLog(@"DemoConfig singleton: id=%@, type=%@, name=%@", DemoConfig.LCS.id, DemoConfig.LCS.type, DemoConfig.LCI.name);
    
You can also custom method name on .h file. (Such as DemoConfig.VGS.id)
    
    #define LC_SINGLETON_CUSTOM_METHOD_NAME LCS // You can custom the method name, for example: your project prefix + S.

    
