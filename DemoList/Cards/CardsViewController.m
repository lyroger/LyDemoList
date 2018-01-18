//
//  CardsViewController.m
//  DemoList
//
//  Created by luoyan on 17/2/22.
//  Copyright © 2017年 luoyan. All rights reserved.
//

#import "CardsViewController.h"
#import "CyclicCardFlowLayout.h"
#import "CyclicCardCell.h"
#import "HJCarouselViewLayout.h"

@interface CardsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    
}

@property (nonatomic,strong) UICollectionView *collectView;

@end

@implementation CardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    CyclicCardFlowLayout *flowLayout = [[CyclicCardFlowLayout alloc] init];
    HJCarouselViewLayout *flowLayout = [[HJCarouselViewLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(mScreenWidth-60, mScreenHeight-64-60);
    self.collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, self.contentView.frame.size.height) collectionViewLayout:flowLayout];
    [self.collectView registerClass:[CyclicCardCell class] forCellWithReuseIdentifier:NSStringFromClass([CyclicCardCell class])];
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    self.collectView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.collectView]; 
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了：%zd",indexPath.row);
}

#pragma mark UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CyclicCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CyclicCardCell class]) forIndexPath:indexPath];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
