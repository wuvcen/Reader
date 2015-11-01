//
//  PageModelController.m
//  Reader
//
//  Created by 吴伟城 on 15/11/1.
//  Copyright © 2015年 吴伟城. All rights reserved.
//

#import "PageModelController.h"

@interface PageModelController()
@property (nonatomic, copy) NSString *text;          ///< 本书所有文本内容
@property (nonatomic, strong) NSArray *pageContents; ///< 将文本分页后的所有页面数组
@end
@implementation PageModelController

#pragma mark - Custom

- (PageDataController *)viewControllerAtIndex:(NSInteger)index {
    if (self.pageContents.count == 0 || self.pageContents.count <= index) {
        return nil;
    }
    PageDataController *dataController = [[PageDataController alloc] init];
    dataController.pageContent = [self.pageContents objectAtIndex:index];
    return dataController;
}

- (NSInteger)indexOfViewController:(PageDataController *)viewController {
    return [self.pageContents indexOfObject:viewController.pageContent];
}

#pragma LazyLoad

- (NSString *)text {
    if (_text == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:self.bookName ofType:@"txt"];
        _text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    }
    return _text;
}

- (NSArray *)pageContents {
    if (_pageContents == nil) {
        _pageContents = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G", self.bookName];
    }
    return _pageContents;
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
