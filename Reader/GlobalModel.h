//
//  GlobalModel.h
//  Reader
//
//  Created by 吴伟城 on 15/11/1.
//  Copyright © 2015年 吴伟城. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GlobalModel : NSObject
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSMutableArray *rangeArray;
@property (strong, nonatomic) NSDictionary *attributes;
@property (assign, nonatomic) CGFloat fontSize;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSRange currentRange;
@property (assign, nonatomic) BOOL isNightMode;

+ (instancetype)sharedModel;
- (void)loadText:(NSString *)text completion:(void (^)(void))completion;
- (void)updateFontCompletion:(void (^)(void))completion;
- (void)updateNightMode:(BOOL)isNight completion:(void (^)(void))completion;


@end
