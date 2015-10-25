//
//  BottomMenuInPageVC.h
//  Reader
//
//  Created by 吴伟城 on 15/10/25.
//  Copyright © 2015年 吴伟城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomMenuInPageVC : UIView

@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *bookMark;
@property (weak, nonatomic) IBOutlet UIButton *chosePage;
@property (weak, nonatomic) IBOutlet UIButton *reserve;

+ (instancetype)bottomMenu;

@end
