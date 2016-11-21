//
//  Request.m
//  Flobillersdk
//
//  Created by Do Quoc Lam on 10/30/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import "Request.h"
#import "CommonUtilities.h"
@implementation Request
- (NSDictionary *)dictionaryByRequest {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if (self.order) {
        [dict setObject:[CommonUtilities dictionaryWithPropertiesOfObject:self.order] forKey:@"order"];
        
    }
    if (self.payer) {
        [dict setObject:[CommonUtilities dictionaryWithPropertiesOfObject:self.payer] forKey:@"payer"];
        
    }
    if (self.merchant) {
        [dict setObject:[CommonUtilities dictionaryWithPropertiesOfObject:self.merchant] forKey:@"merchant"];
    }
    if (self.payOption) {
        [dict setObject:[CommonUtilities dictionaryWithPropertiesOfObject:self.payOption] forKey:@"payOption"];
       
    }
    if (self.cardInfo) {
        [dict setObject:[CommonUtilities dictionaryWithPropertiesOfObject:self.cardInfo] forKey:@"cardInfo"];
    }
    return dict;
}
@end
