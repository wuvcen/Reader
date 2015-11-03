//
//  DataUtils.m
//  Reader
//
//  Created by 吴伟城 on 15/11/3.
//  Copyright © 2015年 吴伟城. All rights reserved.
//

#import "DataUtils.h"
#import "FMDB.h"

@interface DataUtils()
@property (nonatomic, strong) FMDatabase *db;
@end

@implementation DataUtils

//+ (instancetype)sharedDataUtils;
//
//- (BOOL)insertBooks:(NSArray *)books;
//- (NSDictionary *)getBookByName:(NSString *)bookName;
//- (NSMutableArray *)getAllBooks;
//- (void)updateBook:(NSDictionary *)book;
//
//- (NSMutableArray *)getAllBookMarks;
//- (NSMutableArray *)getBookMarksOfBookWithName:(NSString *)bookName;
//- (void)insertBookMark:(NSDictionary *)dict;
//- (void)deleteBookMark:(NSDictionary *)dict;
//
//- (void)insertReserves:(NSDictionary *)dict;
//- (NSMutableArray *)getAllReserves;
//- (NSMutableArray *)getReservesOfBookWithName:(NSString *)bookName;
//- (void)deleteReserve:(NSDictionary *)dict;

#pragma mark - Override

- (instancetype)init {
    if (self = [super init]) {
        [self.db open];
        [self createTables];
        [self.db close];
    }
    return self;
}

#pragma mark - Declared in .h

+ (instancetype)sharedDataUtils {
    static DataUtils *dataUtils = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        dataUtils = [[DataUtils alloc] init];
    });
    return dataUtils;
}

#pragma mark - Custom

- (void)createTables {
    //
}

- (BOOL)isTableExists:(NSString *)tableName {
    [self.db open];
    FMResultSet *rs = [self.db executeQueryWithFormat:@"SELECT count(*) AS 'count' FROM sqlite_master WHERE type = 'table' AND name = '%@'", tableName];
    while (rs.next) {
        NSInteger count = [rs intForColumn:@"count"];
        return count != 0;
    }
    return NO;
}


@end
