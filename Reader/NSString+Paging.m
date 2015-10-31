//
//  NSString+Paging.m
//  Reader
//
//  Created by 吴伟城 on 15/10/30.
//  Copyright © 2015年 吴伟城. All rights reserved.
//

#import "NSString+Paging.h"

@implementation NSString (Paging)

- (NSArray *)pageWithAttributes:(NSDictionary *)attributes constrainToSize:(CGSize)size {
    NSMutableArray * resultRange = [NSMutableArray arrayWithCapacity:5];
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    // 构造NSAttributedString
    NSAttributedString * attributedString = [[NSAttributedString alloc] initWithString:self attributes:attributes];
    NSInteger rangeIndex = 0;
    do {
#warning Why 750?
        unsigned long length = MIN(750, attributedString.length - rangeIndex);
        NSAttributedString * childString = [attributedString attributedSubstringFromRange:NSMakeRange(rangeIndex, length)];
        
        CTFramesetterRef childFramesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef) childString);
        UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRect:rect];
        CTFrameRef frame = CTFramesetterCreateFrame(childFramesetter, CFRangeMake(0, 0), bezierPath.CGPath, NULL);
        
        CFRange range = CTFrameGetVisibleStringRange(frame);
        NSRange r = {rangeIndex, range.length};
        
        if (r.length > 0) {
            [resultRange addObject:NSStringFromRange(r)];
        }
        rangeIndex += r.length;
        CFRelease(frame);
        CFRelease(childFramesetter);
    } while (rangeIndex < attributedString.length && attributedString.length > 0);
    
    return resultRange;
    
}

- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font {
    CGSize expectedLabelSize = CGSizeZero;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    expectedLabelSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return CGSizeMake(ceil(expectedLabelSize.width), ceil(expectedLabelSize.height));
}

@end
