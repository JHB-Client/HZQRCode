//
//  NSString+IsUrlString.m
//  HZQRCodeExample
//
//  Created by 季怀斌 on 2017/11/8.
//  Copyright © 2017年 huazhuo. All rights reserved.
//

#import "NSString+IsUrlString.h"
@implementation NSString (IsUrlString)
- (BOOL)isUrlString {
    
    NSString *emailRegex = @"[a-zA-z]+://.*";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
    
}
@end
