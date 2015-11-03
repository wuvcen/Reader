//
//  GlobalModel.m
//  Reader
//
//  Created by 吴伟城 on 15/11/1.
//  Copyright © 2015年 吴伟城. All rights reserved.
//

#import "GlobalModel.h"
#import "NSString+Paging.h"

@implementation GlobalModel

#pragma mark - Override

- (instancetype)init {
    if (self = [super init]) {
        self.fontSize = 17;     // 默认17
    }
    return self;
}

#pragma mark - Setter

- (void)setFontSize:(CGFloat)fontSize {
    _fontSize = MAX(12, MIN(fontSize, 30)); // 最小12，最大30
}

#pragma mark - Declared in .h

+ (instancetype)sharedModel {
    static GlobalModel *model = nil;  // 确保只执行一次
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        model = [[GlobalModel alloc] init];
    });
    return model;
}

- (void)loadText:(NSString *)text completion:(void (^)(void))completion {
    self.text = text;
    [self pagingTextCompletion:completion];
}

- (void)updateFontCompletion:(void (^)(void))completion {
    NSRange range = self.currentRange;
    [self pagingTextCompletion:^{
        // 重新定位页码
        [self.rangeArray enumerateObjectsUsingBlock:^(NSString *rangeString, NSUInteger index, BOOL *stop){
            NSRange tempRange = NSRangeFromString(rangeString);
            if (tempRange.location <= range.location && tempRange.location + tempRange.length > range.location) {
                self.currentPage = index;
                *stop = YES;
            }
        }];
        if (completion) {
            completion();
        }
    }];
}

- (void)updateNightMode:(BOOL)isNight completion:(void (^)(void))completion {
    self.isNightMode = isNight;
    if (completion) {
        completion();
    }
}

#pragma mark Custom

- (void)pagingTextCompletion:(void (^)(void))completion {
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] initWithCapacity:5];
    
    UIFont *font = [UIFont systemFontOfSize:self.fontSize];
    [attributes setValue:font forKey:NSFontAttributeName];
    [attributes setValue:@(1.0) forKey:NSKernAttributeName];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing =5.0;
    paragraphStyle.paragraphSpacing = 10.0;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    [attributes setValue:paragraphStyle forKey:NSParagraphStyleAttributeName];
    
    self.attributes = [attributes copy];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGSize size = CGSizeMake(screenSize.width - (20 * 2), screenSize.height - 120);
    self.rangeArray = [[self.text pageWithAttributes:self.attributes constrainToSize:size] mutableCopy];
    if (completion) {
        completion();
    }
}

@end
