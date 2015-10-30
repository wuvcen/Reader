//
//  NSString+Paging.h
//  Reader
//
//  Created by 吴伟城 on 15/10/30.
//  Copyright © 2015年 吴伟城. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>

@interface NSString (Paging)

/// 对字符串根据给定的样式进行分页操作,返回分页后的数组
- (NSArray *)pageWithAttributes:(NSDictionary *)attributes constrainToSize:(CGSize)size;

///计算UILabel高度
- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font;

@end
