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

@interface CardsViewController ()
{
    
}

@property (nonatomic,strong) UICollectionView *collectView;

@end

@implementation CardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    let padding = FIT_SCREEN_WIDTH(20)
//    
//    let layout = CyclicCardFlowLayout()
//    layout.scrollDirection = .horizontal
//    layout.minimumLineSpacing = padding
//    layout.minimumInteritemSpacing = padding
//    layout.sectionInset = UIEdgeInsetsMake(padding, 0, padding, 0)
//    let itemW = (SCREEN_WIDTH - padding * 2) * 0.5
//    layout.itemSize = CGSize(width: itemW, height: bgview.height - padding * 2)
//    collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: bgview.height), collectionViewLayout: layout)
//    collectionView.backgroundColor = UIColor.clear
//    collectionView.collectionViewLayout = layout
//    collectionView.showsHorizontalScrollIndicator = false
//    collectionView.delegate = self
//    collectionView.dataSource = self
//    collectionView.register(CyclicCardCell.self, forCellWithReuseIdentifier: NSStringFromClass(CyclicCardCell.self))
//    bgview.addSubview(self.collectionView)
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
