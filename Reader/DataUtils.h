//
//  DataUtils.h
//  Reader
//
//  Created by 吴伟城 on 15/11/3.
//  Copyright © 2015年 吴伟城. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataUtils : NSObject

+ (instancetype)sharedDataUtils;

- (BOOL)insertBooks:(NSArray *)books;
- (NSDictionary *)getBookByName:(NSString *)bookName;
- (NSMutableArray *)getAllBooks;
- (void)updateBook:(NSDictionary *)book;

- (NSMutableArray *)getAllBookMarks;
- (NSMutableArray *)getBookMarksOfBookWithName:(NSString *)bookName;
- (void)insertBookMark:(NSDictionary *)dict;
- (void)deleteBookMark:(NSDictionary *)dict;

- (void)insertReserves:(NSDictionary *)dict;
- (NSMutableArray *)getAllReserves;
- (NSMutableArray *)getReservesOfBookWithName:(NSString *)bookName;
- (void)deleteReserve:(NSDictionary *)dict;

@end
