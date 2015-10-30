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
#import "BottomMenuInPageVC.h"

@interface PageViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (nonatomic, strong) NSArray *pageContents;
@property (nonatomic, strong) UIButton *coverButton;
@property (nonatomic, strong) TopMenuInPageVC *topMenu;
@property (nonatomic, strong) BottomMenuInPageVC *bottomMenu;
@property (nonatomic, assign) BOOL isMenusHidden;
@end
@implementation PageViewController

#pragma mark - Override

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
    self.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setControllersAtIndex:0];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self addMenus];
    self.isMenusHidden = NO;
    [self addCoverButton];
}

- (void)setIsMenusHidden:(BOOL)isMenusHidden {
    // 重写该set方法，控制上下 Menu 的显示与隐藏，和中间覆盖按钮的大小
    _isMenusHidden = isMenusHidden;
    [UIView animateWithDuration:0.2 animations:^{
        if (isMenusHidden) {
            self.topMenu.frame = CGRectMake(0, -60, self.view.bounds.size.width, 60);
            self.bottomMenu.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 60);
            self.coverButton.frame = [self computeCoverButtonFrameSmall];
        } else {
            // 提前执行，后面completion中重复执行无碍
            self.topMenu.hidden = isMenusHidden;
            self.bottomMenu.hidden = isMenusHidden;
            // ---
            self.topMenu.frame = CGRectMake(0, 0, self.view.bounds.size.width, 60);
            self.bottomMenu.frame = CGRectMake(0, self.view.bounds.size.height - 60, self.view.bounds.size.width, 60);
            self.coverButton.frame = CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height - 120);
        }
    } completion:^(BOOL finished) {
        self.topMenu.hidden = isMenusHidden;
        self.bottomMenu.hidden = isMenusHidden;
    }];
}

#pragma mark - ManageViews

- (void)addCoverButton {
    self.coverButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.coverButton.frame = CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height - 120);
    self.coverButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [self.coverButton addTarget:self action:@selector(didClickCoverButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.coverButton];
}

- (void)addMenus {
    // Top
    self.topMenu.hidden = YES;
    self.topMenu.frame = CGRectMake(0, -60, self.view.bounds.size.width, 60);
    [self.topMenu.titleButton setTitle:self.title forState:UIControlStateNormal];
    [self.view addSubview:self.topMenu];
    // Bottom
    self.bottomMenu.hidden = YES;
    self.bottomMenu.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 60);
    [self.bottomMenu.backBtn addTarget:self action:@selector(backToCollectionView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.bottomMenu];
}

- (CGRect)computeCoverButtonFrameSmall {
    // 辅助方法，用于计算按钮为中间状态时的大小
    CGSize viewSize = self.view.bounds.size;
    CGFloat w = viewSize.width / 2.0;
    CGFloat h = viewSize.height / 2.0;
    CGFloat x = (self.view.bounds.size.width - w) / 2.0;
    CGFloat y = (self.view.bounds.size.height - h) / 2.0;
    return CGRectMake(x, y, w, h);
}

#pragma mark - Selectors

- (void)backToCollectionView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didClickCoverButton {
    self.isMenusHidden = !self.isMenusHidden;
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
    return _topMenu;
}

- (BottomMenuInPageVC *)bottomMenu {
    if (_bottomMenu == nil) {
        _bottomMenu = [BottomMenuInPageVC bottomMenu];
    }
    return _bottomMenu;
}

- (UIButton *)coverButton {
    if (_coverButton == nil) {
        _coverButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _coverButton.backgroundColor = [UIColor redColor];
    }
    return _coverButton;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //
}

#pragma mark - Others

- (void)setControllersAtIndex:(NSUInteger)index {
    [self setViewControllers:@[[self viewControllerAtIndex:index]]
                   direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
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

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    // 翻页动画执行之前隐藏上下菜单
    self.topMenu.frame = CGRectMake(0, -60, self.view.bounds.size.width, 60);
    self.bottomMenu.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 60);
    self.isMenusHidden = YES;
}

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    // P.S.
    UIViewController *currentViewController = self.viewControllers[0];
    NSArray *viewControllers = @[currentViewController];
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    self.doubleSided = NO;
    return UIPageViewControllerSpineLocationMin;
}

@end
