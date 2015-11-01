//
//  PageDataController.m
//  Reader
//
//  Created by 吴伟城 on 15/11/1.
//  Copyright © 2015年 吴伟城. All rights reserved.
//

#import "PageDataController.h"

@interface PageDataController()
@property (nonatomic, strong) UITextView *textView;
@end

@implementation PageDataController

#pragma mark - Override

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTextView];
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - Setters

- (void)setTextViewContent:(NSAttributedString *)textViewContent {
    _textViewContent = textViewContent;
    self.textView.attributedText = textViewContent;
}

#pragma mark - LazyLoad

- (UITextView *)textView {
    if (_textView == nil) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _textView = [[UITextView alloc] init];
        _textView.scrollEnabled = YES;
        _textView.editable = NO;
        _textView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        _textView.frame = CGRectMake(20, 30, screenSize.width - (20 * 2), screenSize.height - (30 + 20));
    }
    return _textView;
}

#pragma mark - SetUpViews

- (void)setUpTextView {
    UIView *baseView = [[UIView alloc] initWithFrame:self.view.bounds];
    baseView.backgroundColor = [UIColor whiteColor];
    [baseView addSubview:self.textView];
    [self.view addSubview:baseView];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //
}

@end
