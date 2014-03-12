//
//  TTUICollectionViewDelegate.m
//  Three20Lite4ARC
//
//  Created by 高飞 on 14-3-10.
//  Copyright (c) 2014年 高飞. All rights reserved.
//

#import "TTCollectionViewDelegate.h"
#import "TTCollectionViewController.h"
#import "TTCollectionViewDataSource.h"
@implementation TTCollectionViewDelegate

@synthesize controller = _controller;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSObject

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithController:(TTCollectionViewController*)controller
{
    self = [super init];
    if (self) {
        _controller = controller;
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UICollectionViewDelegate

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<TTCollectionViewDataSource> dataSource = (id<TTCollectionViewDataSource>)collectionView.dataSource;
    id object = [dataSource collectionView:collectionView objectForRowAtIndexPath:indexPath];
    
    [_controller didSelectObject:object atIndexPath:indexPath];
}


@end
