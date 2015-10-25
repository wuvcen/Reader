//
//  PageViewController.m
//  Reader
//
//  Created by 吴伟城 on 15/10/24.
//  Copyright © 2015年 吴伟城. All rights reserved.
//

#import "PageViewController.h"
#import "PageDataViewController.h"
#import "TopMenuInPageVC.h"

@interface PageViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (nonatomic, strong) NSArray *pageContents;
@property (nonatomic, strong) TopMenuInPageVC *topMenu;
@end
@implementation PageViewController

#pragma mark - Override

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
    self.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setViewControllers:@[[self viewControllerAtIndex:1]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self addCoverButton];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.view addSubview:self.topMenu];
}

#pragma mark - LazyLoad

- (NSArray *)pageContents {
    if (_pageContents == nil) {
        _pageContents = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G"];
    }
    return _pageContents;
}

- (TopMenuInPageVC *)topMenu {
    if (_topMenu == nil) {
        _topMenu = [TopMenuInPageVC topMenu];
    }
    _topMenu.frame = CGRectMake(0, 0, self.view.bounds.size.width, 60);
    [_topMenu.backButton addTarget:self action:@selector(backToCollectionView) forControlEvents:UIControlEventTouchUpInside];
    return _topMenu;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //
}

#pragma mark - Custom

- (void)addCoverButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    CGSize viewSize = self.view.bounds.size;
    CGFloat w = viewSize.width / 2.0;
    CGFloat h = viewSize.height / 2.0;
    CGFloat x = (self.view.bounds.size.width - w) / 2.0;
    CGFloat y = (self.view.bounds.size.height - h) / 2.0;
    button.frame = CGRectMake(x, y, w, h);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(backToCollectionView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)backToCollectionView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (PageDataViewController *)viewControllerAtIndex:(NSInteger)index {
    if (self.pageContents.count == 0 || self.pageContents.count <= index) {
        return nil;
    }
    PageDataViewController *dataViewController = [[PageDataViewController alloc] init];
    dataViewController.pageContent = [self.pageContents objectAtIndex:index];
    return dataViewController;
}

- (NSInteger)indexOfViewController:(PageDataViewController *)viewController {
    return [self.pageContents indexOfObject:viewController.pageContent];
}

#pragma mark - <UIPageViewControllerDataSource>

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self indexOfViewController:(PageDataViewController *)viewController];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    --index;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self indexOfViewController:(PageDataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    ++index;
    return [self viewControllerAtIndex:index];
}

#pragma mark - <UIPageViewControllerDelegate>

@end
