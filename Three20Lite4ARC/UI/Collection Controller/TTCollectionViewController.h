//
//  TTCollectionViewController.h
//  Three20Lite4ARC
//
//  Created by 高飞 on 14-3-7.
//  Copyright (c) 2014年 高飞. All rights reserved.
//

#import "TTModelViewController.h"
@protocol TTCollectionViewDataSource;

@interface TTCollectionViewController : TTModelViewController
{
    UICollectionView* _collectionView;
    UIView* _tableOverlayView;
    UIView* _loadingView;
    UIView* _errorView;
    UIView* _emptyView;
    
    UIInterfaceOrientation _lastInterfaceOrientation;
    
    id<TTCollectionViewDataSource> _dataSource;
    id<UICollectionViewDelegate> _collectionDelegate;
    
    BOOL _viewOnScreen;
}

@property (nonatomic, strong) IBOutlet UICollectionView* collectionView;

/**
 * A view that is displayed over the table view.
 */
@property (nonatomic, strong) UIView* tableOverlayView;

@property (nonatomic, strong) UIView* loadingView;
@property (nonatomic, strong) UIView* errorView;
@property (nonatomic, strong) UIView* emptyView;
@property (nonatomic, strong) id<TTCollectionViewDataSource> dataSource;


/**
 * Creates an delegate for the table view.
 *
 * Subclasses can override this to provide their own table delegate implementation.
 */
- (id<UICollectionViewDelegate>)createDelegate;

- (UICollectionViewLayout*)createCollectionViewLayout;

/**
 * Tells the controller that the user selected an object in the table.
 *
 * By default, the object's URLValue will be opened in TTNavigator, if it has one. If you don't
 * want this to be happen, be sure to override this method and be sure not to call super.
 */
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath;

/**
 * The rectangle where the overlay view should appear.
 */
- (CGRect)rectForOverlayView;

@end
