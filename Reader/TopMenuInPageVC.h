//
//  TopMenuInPageVC.h
//  Reader
//
//  Created by 吴伟城 on 15/10/24.
//  Copyright © 2015年 吴伟城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopMenuInPageVC : UIView

@property (weak, nonatomic) IBOutlet UISwitch *nightSwitch;
@property (weak, nonatomic) IBOutlet UIButton *smallerFont;
@property (weak, nonatomic) IBOutlet UIButton *biggerFont;

+ (instancetype)topMenu;

@end
