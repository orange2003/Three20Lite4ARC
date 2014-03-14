//
//  TTCollectionViewDragRefreshDelegate.h
//  Three20ARCSimulationTest
//
//  Created by 高飞 on 14-3-13.
//  Copyright (c) 2014年 高飞. All rights reserved.
//

#import "TTCollectionViewDelegate.h"
#import "EGORefreshTableHeaderView.h"
@protocol TTModel;

@interface TTCollectionViewDragRefreshDelegate : TTCollectionViewDelegate<EGORefreshTableHeaderDelegate>
@property (nonatomic, strong) id<TTModel> model;
@property (nonatomic, retain) EGORefreshTableHeaderView* headerView;
@end
