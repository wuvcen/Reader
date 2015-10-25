//
//  BottomMenuInPageVC.m
//  Reader
//
//  Created by 吴伟城 on 15/10/25.
//  Copyright © 2015年 吴伟城. All rights reserved.
//

#import "BottomMenuInPageVC.h"

@implementation BottomMenuInPageVC

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 */

+ (instancetype)bottomMenu {
    BottomMenuInPageVC *menu = [[NSBundle mainBundle] loadNibNamed:@"BottomMenuInPageVC" owner:self options:nil][0];
    return menu;
}

@end
