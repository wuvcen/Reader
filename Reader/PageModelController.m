//
//  PageModelController.m
//  Reader
//
//  Created by 吴伟城 on 15/11/1.
//  Copyright © 2015年 吴伟城. All rights reserved.
//

#import "PageModelController.h"
#import "NSString+Paging.h"

@interface PageModelController()
@property (nonatomic, copy) NSString *text;             ///< 本书所有文本内容
@property (nonatomic, strong) NSArray *pageRanges;      ///< 将文本分页后的所有页面数组
@property (nonatomic, strong) NSDictionary *attributes; ///< 文本的属性
@property (nonatomic, assign) NSInteger currentIndex;
@end
@implementation PageModelController

#pragma mark - Custom

- (PageDataController *)viewControllerAtIndex:(NSInteger)index {
    if (self.pageRanges.count == 0 || self.pageRanges.count <= index) {
        return nil;
    }
    self.currentIndex = index;
    PageDataController *dataController = [[PageDataController alloc] init];
    NSString *currentContent = [self.text substringWithRange:NSRangeFromString(self.pageRanges[index])];
    dataController.textViewContent = [[NSAttributedString alloc] initWithString:currentContent attributes:self.attributes];
    return dataController;
}

- (NSInteger)indexOfViewController:(PageDataController *)viewController {
    NSRange range = [self.text rangeOfString:[viewController.textViewContent string]];
    return [self.pageRanges indexOfObject:NSStringFromRange(range)];
}

#pragma LazyLoad

- (NSDictionary *)attributes {
    if (_attributes == nil) {
        NSMutableDictionary *resultAttributes = [NSMutableDictionary dictionaryWithCapacity:5];
        // Font style
        UIFont *font = [UIFont systemFontOfSize:16];
        [resultAttributes setValue:font forKey:NSFontAttributeName];
        [resultAttributes setValue:@(1.0) forKey:NSKernAttributeName];
        // Paragraph style
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 5.0;
        paragraphStyle.paragraphSpacing = 10.0;
        paragraphStyle.alignment = NSTextAlignmentJustified;
        [resultAttributes setValue:paragraphStyle forKey:NSParagraphStyleAttributeName];
        _attributes = [resultAttributes copy];
    }
    return _attributes;
}

- (NSString *)text {
    if (_text == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:self.bookName ofType:@"txt"];
        _text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    }
    return _text;
}

- (NSArray *)pageRanges {
    if (_pageRanges == nil) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        CGSize size = CGSizeMake(screenSize.width - (20 * 2), screenSize.height - 120); // 有问题！
        _pageRanges = [self.text pageWithAttributes:self.attributes constrainToSize:size];
    }
    return _pageRanges;
}

#pragma mark - <UIPageViewControllerDataSource>

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self indexOfViewController:(PageDataController *)viewController];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    --index;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self indexOfViewController:(PageDataController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    ++index;
    return [self viewControllerAtIndex:index];
}

@end
