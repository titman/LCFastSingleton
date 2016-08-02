//
//
//      _|          _|_|_|
//      _|        _|
//      _|        _|
//      _|        _|
//      _|_|_|_|    _|_|_|
//
//
//  Copyright (c) 2014-2015, Licheng Guo. ( http://nsobject.me )
//  http://github.com/titman
//
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//

#import "NSObject+LCFastSingleton.h"
#import <objc/runtime.h>
#import <objc/message.h>

static NSMutableDictionary * __instanceDatasource = nil;

@implementation NSObject (LCFastSingleton)


+(instancetype) LC_SINGLETON_CUSTOM_METHOD_NAME
{
    return [self LCSingleton];
}

+(instancetype) LCSingleton
{
    @synchronized(__instanceDatasource){
        
        if (LC_SINGLETON_PROTOCOL_VERIFY == YES && ![[self class] conformsToProtocol:@protocol(LC_SINGLETON_CUSTOM_PROTOCOL_NAME)]) {
            
            NSLog(@"[FastSingleton] %@ didn't conforms to singleton protocol.", [self class]);
            NSLog(@"[FastSingleton] %@ didn't conforms to singleton protocol.", [self class]);
            NSLog(@"[FastSingleton] %@ didn't conforms to singleton protocol.", [self class]);
            return nil;
        }
        
        NSMutableDictionary * datasource = self.shareInstanceDatasource;
        
        NSString * selfClass = [[self class] description];
        
        id __singleton__ = datasource[selfClass];
        
        if (__singleton__) {
            return __singleton__;
        }
        
        //        MethodSwizzleClass([self class], @selector(allocWithZone:), @selector(allocWithZoneSwizzled:));
        //        MethodSwizzle([self class], @selector(init), @selector(initSwizzled));
        //        MethodSwizzle([self class], @selector(description), @selector(descriptionSwizzled));
        
        __singleton__ = [[[self class] alloc] init];
        [__singleton__ singletonInit];
        
        [[self class] setObjectToInstanceDatasource:__singleton__];
        
        //NSLog(@"[LCFastSingleton] %@ singleton inited.",[__singleton__ class]);
        
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

#pragma mark -

void MethodSwizzle(Class aClass, SEL orig_sel, SEL alt_sel)
{
    Method orig_method = nil, alt_method = nil;
    
    // First, look for the methods
    orig_method = class_getInstanceMethod(aClass, orig_sel);
    alt_method = class_getInstanceMethod(aClass, alt_sel);
    
    if (class_addMethod(aClass, orig_sel, method_getImplementation(alt_method), method_getTypeEncoding(alt_method))) {
        class_replaceMethod(aClass, alt_sel, method_getImplementation(orig_method), method_getTypeEncoding(orig_method));
    }
    else{
        
        // If both are found, swizzle them
        if ((orig_method != nil) && (alt_method != nil)) {
            method_exchangeImplementations(orig_method, alt_method);
        }
    }
}

void MethodSwizzleClass(Class aClass, SEL orig_sel, SEL alt_sel)
{
    Method orig_method = nil, alt_method = nil;
    
    // First, look for the methods
    orig_method = class_getClassMethod(aClass, orig_sel);
    alt_method = class_getClassMethod(aClass, alt_sel);
    
    if (class_addMethod(aClass, orig_sel, method_getImplementation(alt_method), method_getTypeEncoding(alt_method))) {
        class_replaceMethod(aClass, alt_sel, method_getImplementation(orig_method), method_getTypeEncoding(orig_method));
    }
    else{
        
        // If both are found, swizzle them
        if ((orig_method != nil) && (alt_method != nil)) {
            method_exchangeImplementations(orig_method, alt_method);
        }
    }
}

- (BOOL)swizzled
{
    NSNumber * obj = objc_getAssociatedObject( self, @"swizzled" );
    
    return [obj boolValue];
}

- (void)setSwizzled:(BOOL)value
{
    objc_setAssociatedObject( self, @"swizzled", @(value), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -

+(instancetype) allocWithZoneSwizzled:(NSZone *)zone
{
    id value = [self shareInstanceDatasource][[self.class description]];
    
    if (value) {
        return value;
    }
    
    return [self allocWithZoneSwizzled:zone];
}

-(instancetype) initSwizzled
{
    id value = [self.class shareInstanceDatasource][[self.class description]];
    
    if (value) {
        return value;
    }
    
    return [self initSwizzled];
}

-(instancetype) singletonInit
{
    return self;
}

-(NSString *) descriptionSwizzled
{
    id value = [self.class shareInstanceDatasource][[self.class description]];
    
    if (value) {
        return [NSString stringWithFormat:@"[LCFastSingleton] %@",[self descriptionSwizzled]];
    }
    
    return [self descriptionSwizzled];
}

@end
