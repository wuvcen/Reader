//
//  PageModelController.h
//  Reader
//
//  Created by 吴伟城 on 15/11/1.
//  Copyright © 2015年 吴伟城. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PageViewController.h"
#import "PageDataController.h"

@interface PageModelController : NSObject <UIPageViewControllerDataSource>
@property (nonatomic, copy) NSString *bookName;

- (PageDataController *)viewControllerAtIndex:(NSInteger)index;          ///< 获取对应页码的Controller
- (NSInteger)indexOfViewController:(PageDataController *)viewController; ///< 获取Controller对应的页码

@end
