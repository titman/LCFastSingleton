# LCFastSingleton
Quickly create singleton, and centralized management.

You may be create every static instance use this way.

static XXX xx = nil;

if (!xx) {
    xx = [[XXX alloc] init];
}

return xx;
