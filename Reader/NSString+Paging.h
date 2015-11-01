//
//  NSString+Paging.h
//  Reader
//
//  Created by 吴伟城 on 15/11/1.
//  Copyright © 2015年 吴伟城. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface NSString (Paging)

- (NSArray *)pageWithAttributes:(NSDictionary *)attributes constrainToSize:(CGSize)size;
- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font; ///< 计算UILabel高度

@end
