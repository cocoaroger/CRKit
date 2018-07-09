//
//  NSString+CRExtention.h
//  CRKit
//
//  Created by roger wu on 16/7/14.
//  Copyright © 2016年 cocoaroger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (CRExtention)

/**
 *  获取国际化的文本
 *
 *  @param key 文本key
 *
 *  @return 真正的字符串
 */
+ (instancetype)cr_stringWithLocalizedKey:(NSString *)key;

/**
 *  是否有值
 *
 *  @return 有值返回YES,反之返回NO
 */
- (BOOL)cr_hasValue;

/**
 *  打电话，电话就是自己，为了兼容iPad必须要加上这个
 *
 *  @param sourceView 点击的按钮的父视图
 *  @param sourceRect 按钮的frame
 */
- (void)cr_callPhoneWithSourceView:(UIView *)sourceView sourceRect:(CGRect)sourceRect;

/**
 *  通过字体和size计算出字符串的CGRect
 *
 *  @param font 字体
 *  @param size size
 *
 *  @return 返回计算好的CGRect
 */
- (CGRect)cr_measureFrameWithFont:(UIFont *)font size:(CGSize)size;

@end

/**
 *  验证字符串
 */
@interface NSString (CRValidate)

/**
 *  正则表达式验证
 *
 *  @param regex 验证的公式
 *
 *  @return 是否符合验证
 */
- (BOOL)cr_matchWithRegex:(NSString *)regex;

/**
 *  判断是否是邮箱
 *
 *  @return YES表示正确，NO表示错误
 */
- (BOOL)cr_isEmailAddress;

/**
 *  判断是否是字母
 */
- (BOOL)cr_isLetter;

/**
 *  判断是否数字
 */
- (BOOL)cr_isNumber;

/**
 *  验证是否是密码的格式
 */
- (BOOL)cr_isPassword;

/**
 *  判断是否微信号
 */
- (BOOL)cr_isWeixin;

/**
 *  判断是否手机号
 */
- (BOOL)cr_isPhoneNumber;

/**
 *  判断是否支付宝帐号
 */
- (BOOL)cr_isAlipayAccount;

/**
 *  验证是否是身份证号（简单验证）
 */
- (BOOL)cr_isIdCode;

/**
 *  验证是否是身份证号（精确验证）
 */
- (BOOL)cr_isIdCodeExact;
@end
