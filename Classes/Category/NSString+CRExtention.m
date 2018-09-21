//
//  NSString+CRExtension.m
//  CRKit
//
//  Created by roger wu on 16/7/14.
//  Copyright © 2016年 cocoaroger. All rights reserved.
//

#import "NSString+CRExtention.h"
#import "CRMacro.h"
#import "UIViewController+CRExtension.h"
#import "UIAlertController+Blocks.h"

@implementation NSString (CRExtention)

+ (instancetype)cr_stringWithLocalizedKey:(NSString *)key {
    return NSLocalizedString(key, key);
}

- (BOOL)cr_hasValue {
    if ([self isEqualToString:@"null"] ||
        [self isEqualToString:@""] ||
        [self isEqualToString:@"(null)"]) {
        return NO;
    } else {
        return YES;
    }
}

- (void)cr_callPhoneWithSourceView:(UIView *)sourceView sourceRect:(CGRect)sourceRect {
    NSString *phoneString = [NSString stringWithFormat:@"tel://%@", self];
    NSURL *telPhoneURL = [NSURL URLWithString:phoneString];
    UIViewController *currentVC = [UIViewController cr_currentViewController];
    
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:telPhoneURL options:@{} completionHandler:nil];
    } else {
        UIWebView *webView = [[UIWebView alloc] init];
        [webView loadRequest:[NSURLRequest requestWithURL:telPhoneURL]];
        [currentVC.view addSubview:webView];
    }
}

- (CGRect)cr_measureFrameWithFont:(UIFont *)font size:(CGSize)size {
    NSDictionary *attriDic = @{NSFontAttributeName : font};
    CGRect strRect = [self boundingRectWithSize:size
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:attriDic
                                        context:nil];
    return strRect;
}
@end

@implementation NSString (CRValidate)

- (BOOL)cr_matchWithRegex:(NSString *)regex {
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:self];
}

- (BOOL)cr_isSpecialLetter {
    return [self cr_matchWithRegex:@"[`~!@#$%^&*()_\\-+=|{}':;',\\[\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]"];
}

- (BOOL)cr_isEmailAddress {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self cr_matchWithRegex:emailRegex];
}

- (BOOL)cr_isWork {
    NSString *regex = @"^[a-zA-Z\u4e00-\u9fa5]*$";
    return [self cr_matchWithRegex:regex];
}

- (BOOL)cr_isNickName {
    NSString *regex = @"^[a-zA-Z\u4e00-\u9fa50-9]*$";
    return [self cr_matchWithRegex:regex];
}

- (BOOL)cr_isChineseLetter {
    NSString *regex = @"^[\u4e00-\u9fa5]*$";
    return [self cr_matchWithRegex:regex];
}

- (BOOL)cr_isLetter {
    NSString *regex = @"^[a-zA-Z]*$";
    return [self cr_matchWithRegex:regex];
}

- (BOOL)cr_isNumber {
    NSString *regex = @"^[0-9]*$";
    return [self cr_matchWithRegex:regex];
}

- (BOOL)cr_isPassword {
    // 密码包括数字和字母
    if ([self cr_isNumber]) {
        return NO;
    }
    if ([self cr_isLetter]) {
        return NO;
    }
    return YES;
}

- (BOOL)cr_isWeixin {
    NSString *regex = @"^[a-zA-Z0-9_]+$";
    return [self cr_matchWithRegex:regex];
}

- (BOOL)cr_isPhoneNumber {
    NSUInteger phoneLength = 11;
    if (self.length != phoneLength) {
        return NO;
    }
    if (![self cr_isNumber]) {
        return NO;
    }
    char firstLetter = [self characterAtIndex:0];
    if (firstLetter != '1') {
        return NO;
    }
    return YES;
}

- (BOOL)cr_isAlipayAccount {
    if ([self cr_isPhoneNumber]) {
        return YES;
    }
    if ([self cr_isEmailAddress]) {
        return YES;
    }
    return NO;
}

- (BOOL)cr_isIdCode {
    NSString *regex = @"^[0-9]{15}|[0-9]{18}|[0-9]{17}x|[0-9]{17}X+$";
    return [self cr_matchWithRegex:regex];
}

- (BOOL)cr_isIdCodeExact {
    NSString *value = self;
    value = [value uppercaseString];
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSInteger length = 0;
    if (!value) {
        return NO;
    }else {
        length = value.length;
        if (length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return NO;
    }
    
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    NSInteger year =0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue +
                         [value substringWithRange:NSMakeRange(10,1)].intValue) *7 +
                ([value substringWithRange:NSMakeRange(1,1)].intValue +
                 [value substringWithRange:NSMakeRange(11,1)].intValue) *9 +
                ([value substringWithRange:NSMakeRange(2,1)].intValue +
                 [value substringWithRange:NSMakeRange(12,1)].intValue) *10 +
                ([value substringWithRange:NSMakeRange(3,1)].intValue +
                 [value substringWithRange:NSMakeRange(13,1)].intValue) *5 +
                ([value substringWithRange:NSMakeRange(4,1)].intValue +
                 [value substringWithRange:NSMakeRange(14,1)].intValue) *8 +
                ([value substringWithRange:NSMakeRange(5,1)].intValue +
                 [value substringWithRange:NSMakeRange(15,1)].intValue) *4 +
                ([value substringWithRange:NSMakeRange(6,1)].intValue +
                 [value substringWithRange:NSMakeRange(16,1)].intValue) *2 +
                [value substringWithRange:NSMakeRange(7,1)].intValue *1 +
                [value substringWithRange:NSMakeRange(8,1)].intValue *6 +
                [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return NO;
    }
}
@end
