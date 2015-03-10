# LCFastSingleton
Quickly create singleton, and centralized management.

You may be create every static instance use this way.

static XXX xx = nil;

if (!xx) {
    xx = [[XXX alloc] init];
}

return xx;
or this.

static XXX * xx = nil;
static dispatch_once_t onceToken;
dispatch_once(&onceToken, ^{
    xx = [[XXX alloc] init];
});

return xx;
Now, You can discard all of these methods and use LCFastInstance.

For example.

DemoConfig.LCI.id = 1;
DemoConfig.LCI.type = 2;
DemoConfig.LCI.name = @"3";

NSLog(@"DemoConfig instance: id=%@, type=%@, name=%@", @(DemoConfig.LCI.id), @(DemoConfig.LCI.type),             DemoConfig.LCI.name);
You can also custom method name on .h file. (Such as DemoConfig.VGI.id)

#define LC_INSTANCE_CUSTOM_METHOD_NAME LCI // You can custom the method name, for example: your project prefix + I.
