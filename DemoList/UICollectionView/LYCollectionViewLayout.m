//
//  LYCollectionViewLayout.m
//  DemoList
//
//  Created by luoyan on 17/2/23.
//  Copyright © 2017年 luoyan. All rights reserved.
//

#import "LYCollectionViewLayout.h"

@interface LYCollectionViewLayout()
{
    //这个数组就是我们自定义的布局配置数组
    NSMutableArray * _attributeAttay;
    CGFloat marginWidth;
    CGFloat cellWidth;
}

@end

@implementation LYCollectionViewLayout

- (void)prepareLayout{
    _attributeAttay = [[NSMutableArray alloc]init];
    [super prepareLayout];
    marginWidth = 4;
    cellWidth = ([UIScreen mainScreen].bounds.size.width - (marginWidth*5))/4;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //itemCount是外界传进来的item的个数 遍历来设置每一个item的布局
    for (int i=0; i<[self.collectionView numberOfItemsInSection:0]; i++) {
        //设置每个item的位置等相关属性
        NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
        //创建一个布局属性类，通过indexPath来创建
        UICollectionViewLayoutAttributes * attris = [self layoutAttributesForItemAtIndexPath:index];
        
        [_attributeAttay addObject:attris];
    }
    
}
// 返回布局属性，一个UICollectionViewLayoutAttributes对象数组
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return _attributeAttay;
}

// 计算布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attrs.frame = CGRectMake(marginWidth+indexPath.row%4 * (cellWidth+marginWidth), marginWidth + indexPath.row/4 * (cellWidth+marginWidth), cellWidth, cellWidth);
    
    return attrs;
}

- (CGSize)collectionViewContentSize
{
    // Don't scroll horizontally
    CGFloat contentWidth = self.collectionView.bounds.size.width;
    CGFloat contentHeight = ([self.collectionView numberOfItemsInSection:0]/4 + 1) * (marginWidth+cellWidth) + marginWidth;
    CGSize contentSize = CGSizeMake(contentWidth, contentHeight);
    return contentSize;
}
@end
