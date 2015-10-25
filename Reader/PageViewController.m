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
@property (nonatomic, strong) TopMenuInPageVC *topMenu;
@property (nonatomic, strong) BottomMenuInPageVC *bottomMenu;
@end
@implementation PageViewController

#pragma mark - Test
//

#pragma mark - Override

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
    self.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setViewControllers:@[[self viewControllerAtIndex:1]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self addCoverButton];
    [self addMenus];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.topMenu.hidden = NO;
        self.bottomMenu.hidden = NO;
        self.topMenu.frame = CGRectMake(0, 0, self.view.bounds.size.width, 60);
        self.bottomMenu.frame = CGRectMake(0, self.view.bounds.size.height - 60, self.view.bounds.size.width, 60);
    } completion:nil];
}

#pragma mark - SetUpSubViews

- (void)addCoverButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    CGSize viewSize = self.view.bounds.size;
    CGFloat w = viewSize.width / 2.0;
    CGFloat h = viewSize.height / 2.0;
    CGFloat x = (self.view.bounds.size.width - w) / 2.0;
    CGFloat y = (self.view.bounds.size.height - h) / 2.0;
    button.frame = CGRectMake(x, y, w, h);
    button.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [button addTarget:self action:@selector(showOrHideMenus) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)addMenus {
    // topMenu
    self.topMenu.hidden = YES;
    self.topMenu.frame = CGRectMake(0, -60, self.view.bounds.size.width, 60);
    [self.view addSubview:self.topMenu];
    // bottomMenu
    self.bottomMenu.hidden = YES;
    self.bottomMenu.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 60);
    [self.bottomMenu.backBtn addTarget:self action:@selector(backToCollectionView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.bottomMenu];
}

- (void)showOrHideTopMenu {
    if (self.topMenu.hidden) {
        [UIView animateWithDuration:0.2 animations:^{
            self.topMenu.frame = CGRectMake(0, 0, self.view.bounds.size.width, 60);
        }];
        self.topMenu.hidden = NO;
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.topMenu.frame = CGRectMake(0, -60, self.view.bounds.size.width, 60);
        }];
        self.topMenu.hidden = YES;
    }
}

- (void)showOrHideBottomMenu {
    if (self.bottomMenu.hidden) {
        [UIView animateWithDuration:0.2 animations:^{
            self.bottomMenu.frame = CGRectMake(0, self.view.bounds.size.height - 60, self.view.bounds.size.width, 60);
        }];
        self.bottomMenu.hidden = NO;
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.bottomMenu.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 60);
        }];
        self.bottomMenu.hidden = YES;
    }
}

#pragma mark - Selectors

- (void)backToCollectionView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showOrHideMenus {
    [self showOrHideTopMenu];
    [self showOrHideBottomMenu];
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //
}

#pragma mark - Others

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
