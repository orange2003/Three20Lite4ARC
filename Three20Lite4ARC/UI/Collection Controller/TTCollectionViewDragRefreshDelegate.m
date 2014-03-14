//
//  TTCollectionViewDragRefreshDelegate.m
//  Three20ARCSimulationTest
//
//  Created by 高飞 on 14-3-13.
//  Copyright (c) 2014年 高飞. All rights reserved.
//

#import "TTCollectionViewDragRefreshDelegate.h"
#import "TTModel.h"
@implementation TTCollectionViewDragRefreshDelegate


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithController:(TTCollectionViewController*)controller
{
    self = [super initWithController:controller];
    if (self) {
        // Add our refresh header
        _headerView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - controller.collectionView.bounds.size.height, controller.view.frame.size.width, controller.collectionView.bounds.size.height)];
        _headerView.delegate = self;
        [controller.collectionView addSubview:_headerView];
        self.model = controller.model;
        [_model.delegates addObject:self];
        
        // Grab the last refresh date if there is one.
        [_headerView refreshLastUpdatedDate];
    }
    return self;
}

- (void)dealloc
{
    [_model.delegates removeObject:self];
    [_headerView removeFromSuperview];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIScrollViewDelegate


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
   // [super scrollViewDidScroll:scrollView];
    [_headerView egoRefreshScrollViewDidScroll:scrollView];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
   // [super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
	[_headerView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)modelDidFinishLoad:(id<TTModel>)model
{
    [_headerView egoRefreshScrollViewDataSourceDidFinishedLoading:_controller.collectionView];
}

- (void)model:(id<TTModel>)model didFailLoadWithError:(NSError*)error
{
    [_headerView egoRefreshScrollViewDataSourceDidFinishedLoading:_controller.collectionView];
}

- (void)modelDidCancelLoad:(id<TTModel>)model
{
    [_headerView egoRefreshScrollViewDataSourceDidFinishedLoading:_controller.collectionView];
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
	[_model load:NSURLRequestUseProtocolCachePolicy more:NO];
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
	return [_model isLoading]; // should return if data source model is reloading
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
	return [NSDate date]; // should return date data source was last changed
    
}

@end
