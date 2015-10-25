//
//  TopMenuInPageVC.m
//  Reader
//
//  Created by 吴伟城 on 15/10/24.
//  Copyright © 2015年 吴伟城. All rights reserved.
//

#import "TopMenuInPageVC.h"

@implementation TopMenuInPageVC

+ (instancetype)topMenu {
    TopMenuInPageVC *menu = [[NSBundle mainBundle] loadNibNamed:@"TopMenuInPageVC" owner:self options:nil][0];
    return menu;
}

@end
