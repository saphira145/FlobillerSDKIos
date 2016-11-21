//
//  OrderInfo.m
//  Flobillersdk
//
//  Created by Do Quoc Lam on 10/24/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import "OrderInfo.h"
#import <objc/runtime.h>

@implementation OrderInfo


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
                if ([key isEqualToString:@"payer"]) {
                    self.payer = [[PayerInfo alloc] init];
                    unsigned count2;
                    objc_property_t *properties2 = class_copyPropertyList([self.payer class], &count2);
                    for (int i = 0; i < count2; i++) {
                        NSString *key2 = [NSString stringWithUTF8String:property_getName(properties2[i])];
                        if ([[JSONDictionary valueForKey:@"payer"] valueForKey:key2]) {
                            [self.payer setValue:[[JSONDictionary valueForKey:@"payer"] valueForKey:key2] forKey:key2];
                        }
                        
                    }
                    

                    
                }
                else {
                    if ([JSONDictionary valueForKey:key]) {
                        [self setValue:[JSONDictionary valueForKey:key] forKey:key];
                    }
                }
                
            }
            
            free(properties);
            
        }
    }
    return self;
}
@end
