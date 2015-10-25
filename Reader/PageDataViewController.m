//
//  PageDataViewController.m
//  Reader
//
//  Created by 吴伟城 on 15/10/24.
//  Copyright © 2015年 吴伟城. All rights reserved.
//

#import "PageDataViewController.h"

@interface PageDataViewController ()
@end
@implementation PageDataViewController

#pragma mark - Override

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTextView];
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - Custom

- (void)addTextView {
    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.bounds textContainer:nil];
    textView.backgroundColor = [UIColor whiteColor];
    textView.text = self.pageContent;
    textView.editable = NO;
    [self.view addSubview:textView];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //
}

@end
