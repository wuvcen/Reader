//
//  CollectionViewController.m
//  Reader
//
//  Created by 吴伟城 on 15/10/24.
//  Copyright © 2015年 吴伟城. All rights reserved.
//

#import "CollectionViewController.h"
#import "PageViewController.h"
#import "BookCoverCell.h"

@interface CollectionViewController ()
@property (nonatomic, copy) NSArray *books;
@end
@implementation CollectionViewController

static NSString * const reuseIdentifier = @"BookCoverCell";

#pragma mark - Override

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configLayout];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView registerNib:[UINib nibWithNibName:@"BookCoverCell" bundle:nil]
          forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PageViewController *destViewController = segue.destinationViewController;
    destViewController.title = [self.books objectAtIndex:[sender integerValue]];
}

#pragma mark - LazyLoad

- (NSArray *)books {
    if (_books == nil) {
        _books = @[@"左耳",@"十年",@"沙漏"];
    }
    return _books;
}

#pragma mark - Custom

- (void)configLayout {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat space = (screenWidth - 3 * 90) / 4;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(90, 120);
    flowLayout.minimumInteritemSpacing = space;
    flowLayout.minimumLineSpacing = 16;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, space, 10, space);
    self.collectionView.collectionViewLayout = flowLayout;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.books.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BookCoverCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.bookName.text = self.books[indexPath.item];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"PushToPageView" sender:@(indexPath.item)];
}

@end
