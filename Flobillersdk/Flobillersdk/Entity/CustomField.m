//
//  CustomField.m
//  Flobillersdk
//
//  Created by Do Quoc Lam on 10/24/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import "CustomField.h"
#import <objc/runtime.h>
@implementation CustomField

- (instancetype)initWithDictionary:(NSDictionary *)JSONDictionary
{
    self = [super init];
    if (self) {
        
        NSError *error = nil;
        
        if (!error && JSONDictionary) {
            
            unsigned count;
            objc_property_t *properties = class_copyPropertyList([self class], &count);
            
            for (int i = 0; i < count; i++) {
                NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
                if ([JSONDictionary valueForKey:key]) {
                    [self setValue:[JSONDictionary valueForKey:key] forKey:key];
                }
            }
            
            
            
            free(properties);
            
        }
    }
    return self;
}
@end
