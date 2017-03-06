//
//  CyclicCardFlowLayout.m
//  DemoList
//
//  Created by luoyan on 17/2/22.
//  Copyright © 2017年 luoyan. All rights reserved.
//

#import "CyclicCardFlowLayout.h"

@implementation CyclicCardFlowLayout

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    
    // 目标区域中包含的cell
    NSArray *attriArray = [super layoutAttributesForElementsInRect:targetRect];
    // collectionView落在屏幕中点的x坐标
    CGFloat horizontalCenterX = proposedContentOffset.x + (self.collectionView.bounds.size.width / 2.0);
    
    CGFloat offsetAdjustment = MAXFLOAT;
    
    for (UICollectionViewLayoutAttributes *layoutAttributes in attriArray) {
        CGFloat itemHorizontalCenterX = layoutAttributes.center.x;
        // 找出离中心点最近的
        if (fabs(itemHorizontalCenterX-horizontalCenterX) < fabs(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenterX-horizontalCenterX;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    CGFloat ActiveDistance = 400;
    CGFloat ScaleFactor = 0.25;
    
    for (UICollectionViewLayoutAttributes *attributes in array) {
        CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
        CGFloat normallizedDistance = fabs(distance/ActiveDistance);
        CGFloat zoom = 1 - ScaleFactor * normallizedDistance;
        attributes.transform3D = CATransform3DMakeScale(1.0, zoom, 1.0);
        attributes.zIndex = 1;
    }
    
    return array;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
