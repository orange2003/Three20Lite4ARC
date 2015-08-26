//
//  TTCollectionViewController.m
//  Three20Lite4ARC
//
//  Created by 高飞 on 14-3-7.
//  Copyright (c) 2014年 高飞. All rights reserved.
//

#import "TTCollectionViewController.h"
#import "TTCollectionViewDelegate.h"

// UI
#import "TTActivityLabel.h"
#import "TTErrorView.h"
#import "TTCollectionViewDataSource.h"
#import "TTCollectionViewSectionedDataSource.h"
#import "UIViewAdditions.h"

// UICommon
#import "TTGlobalUICommon.h"
#import "UIViewControllerAdditions.h"

// Core
#import "TTCorePreprocessorMacros.h"
#import "TTGlobalCoreLocale.h"
#import "TTGlobalCoreRects.h"
#import "TTDebug.h"
#import "TTDebugFlags.h"

@interface TTCollectionViewController ()

@end

@implementation TTCollectionViewController
@synthesize collectionView = _collectionView;
@synthesize tableOverlayView = _tableOverlayView;
@synthesize loadingView = _loadingView;
@synthesize errorView = _errorView;
@synthesize emptyView = _emptyView;
@synthesize dataSource = _dataSource;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self) {
        _lastInterfaceOrientation = self.interfaceOrientation;
    }
    
    return self;
}


- (void)dealloc
{
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
    TT_RELEASE_SAFELY(_collectionDelegate);
    TT_RELEASE_SAFELY(_dataSource);
    TT_RELEASE_SAFELY(_collectionView);
    TT_RELEASE_SAFELY(_loadingView);
    TT_RELEASE_SAFELY(_errorView);
    TT_RELEASE_SAFELY(_emptyView);
    TT_RELEASE_SAFELY(_tableOverlayView);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createInterstitialModel
{
    self.dataSource = [[TTCollectionViewInterstitialDataSource alloc] init];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)defaultTitleForLoading
{
    return TTLocalizedString(@"Loading...", @"");
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)updateCollectionDelegate
{
    if (!_collectionView.delegate) {
        _collectionDelegate = nil;
        _collectionDelegate = [self createDelegate];
        
        // You need to set it to nil before changing it or it won't have any effect
        _collectionView.delegate = nil;
        _collectionView.delegate = _collectionDelegate;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)addToOverlayView:(UIView*)view
{
    if (!_tableOverlayView) {
        CGRect frame = [self rectForOverlayView];
        _tableOverlayView = [[UIView alloc] initWithFrame:frame];
        _tableOverlayView.autoresizesSubviews = YES;
        _tableOverlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth
        | UIViewAutoresizingFlexibleHeight;
        NSInteger tableIndex = [_collectionView.superview.subviews indexOfObject:_collectionView];
        if (tableIndex != NSNotFound) {
            [_collectionView.superview addSubview:_tableOverlayView];
        }
    }
    
    view.frame = _tableOverlayView.bounds;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_tableOverlayView addSubview:view];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)resetOverlayView
{
    if (_tableOverlayView && !_tableOverlayView.subviews.count) {
        [_tableOverlayView removeFromSuperview];
        TT_RELEASE_SAFELY(_tableOverlayView);
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)addSubviewOverTableView:(UIView*)view
{
    NSInteger tableIndex = [_collectionView.superview.subviews
                            indexOfObject:_collectionView];
    if (NSNotFound != tableIndex) {
        [_collectionView.superview addSubview:view];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutOverlayView
{
    if (_tableOverlayView) {
        _tableOverlayView.frame = [self rectForOverlayView];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)fadeOutView:(UIView*)view
{
    [UIView beginAnimations:nil
                    context:(__bridge void*)(view)];
    [UIView setAnimationDuration:TT_TRANSITION_DURATION];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(fadingOutViewDidStop:
                                                  finished:
                                                  context:)];
    view.alpha = 0;
    [UIView commitAnimations];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)fadingOutViewDidStop:(NSString*)animationID finished:(NSNumber*)finished
                     context:(void*)context
{
    UIView* view = (UIView*)CFBridgingRelease(context);
    [view removeFromSuperview];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadView
{
    [super loadView];
    [self collectionView];
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _viewOnScreen = YES;
    
    if (_lastInterfaceOrientation != self.interfaceOrientation) {
        _lastInterfaceOrientation = self.interfaceOrientation;
        [_collectionView reloadData];
        
    }
    
//    if (_clearsSelectionOnViewWillAppear) {
//        [_collectionView deselectRowAtIndexPath:[_collectionView indexPathsForSelectedItems]
//                                  animated:animated];
//    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    if (_flags.isShowingModel) {
        [_collectionView flashScrollIndicators];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillDisappear:(BOOL)animated
{
    _viewOnScreen = NO;
    [super viewWillDisappear:animated];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTModelViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)beginUpdates
{
    [super beginUpdates];
   // [_collectionView beginUpdates];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)endUpdates
{
    [super endUpdates];
  //  [_collectionView endUpdates];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)canShowModel
{
    if ([_dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
        NSInteger numberOfSections = [_dataSource numberOfSectionsInCollectionView:_collectionView];
        if (!numberOfSections) {
            return NO;
            
        } else if (numberOfSections == 1) {
           
            NSInteger numberOfRows = [_dataSource collectionView:_collectionView numberOfItemsInSection:0];
            return numberOfRows > 0;
            
        } else {
            return YES;
        }
        
    } else {
        NSInteger numberOfRows =  [_dataSource collectionView:_collectionView numberOfItemsInSection:0];
        return numberOfRows > 0;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didLoadModel:(BOOL)firstTime
{
    [super didLoadModel:firstTime];
    
    [_dataSource collectionViewDidLoadModel:_collectionView];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didShowModel:(BOOL)firstTime
{
    [super didShowModel:firstTime];
    if (![self isViewAppearing] && firstTime) {
        [_collectionView flashScrollIndicators];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showModel:(BOOL)show
{
    if (show) {
        [self updateCollectionDelegate];
        _collectionView.dataSource = _dataSource;
        
    } else {
        _collectionView.dataSource = nil;
    }
    [_collectionView reloadData];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showLoading:(BOOL)show
{
    if (show) {
        if (!self.model.isLoaded || ![self canShowModel]) {
            NSString* title = _dataSource
            ? [_dataSource titleForLoading:NO]
            : [self defaultTitleForLoading];
            if (title.length) {
                TTActivityLabel* label =
                [[TTActivityLabel alloc] initWithStyle:TTActivityLabelStyleWhiteBox];
                label.text = title;
                label.backgroundColor = _collectionView.backgroundColor;
                self.loadingView = label;
            }
        }
        
    } else {
        self.loadingView = nil;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showError:(BOOL)show
{
    if (show) {
        if (!self.model.isLoaded || ![self canShowModel]) {
            NSString* title = [_dataSource titleForError:_modelError];
            NSString* subtitle = [_dataSource subtitleForError:_modelError];
            UIImage* image = [_dataSource imageForError:_modelError];
            if (title.length || subtitle.length || image) {
                TTErrorView* errorView = [[TTErrorView alloc] initWithTitle:title
                                                                   subtitle:subtitle
                                                                      image:image];
                if ([_dataSource reloadButtonForEmpty]) {
                    [errorView addReloadButton];
                    [errorView.reloadButton addTarget:self
                                               action:@selector(reload)
                                     forControlEvents:UIControlEventTouchUpInside];
                }
                errorView.backgroundColor = _collectionView.backgroundColor;
                
                self.errorView = errorView;
                
            } else {
                self.errorView = nil;
            }
            _collectionView.dataSource = nil;
            [_collectionView reloadData];
        }
        
    } else {
        self.errorView = nil;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showEmpty:(BOOL)show
{
    if (show) {
        NSString* title = [_dataSource titleForEmpty];
        NSString* subtitle = [_dataSource subtitleForEmpty];
        UIImage* image = [_dataSource imageForEmpty];
        if (title.length || subtitle.length || image) {
            TTErrorView* errorView = [[TTErrorView alloc] initWithTitle:title
                                                               subtitle:subtitle
                                                                  image:image];
            self.emptyView = errorView;
            
        } else {
            self.emptyView = nil;
        }
        _collectionView.dataSource = nil;
        [_collectionView reloadData];
        
    } else {
        self.emptyView = nil;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public

///////////////////////////////////////////////////////////////////////////////////////////////////
-(UICollectionView *)collectionView
{
    if (nil == _collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[self createCollectionViewLayout]];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth
        | UIViewAutoresizingFlexibleHeight;
       // _collectionView.collectionViewLayout = [self createCollectionViewLayout];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)setCollectionView:(UICollectionView *)collectionView
{
    if (collectionView != _collectionView) {
        _collectionView = nil;
        _collectionView = collectionView;
        if (!_collectionView) {
            self.tableOverlayView = nil;
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTableOverlayView:(UIView*)tableOverlayView animated:(BOOL)animated
{
    if (tableOverlayView != _tableOverlayView) {
        if (_tableOverlayView) {
            if (animated) {
                [self fadeOutView:_tableOverlayView];
                
            } else {
                [_tableOverlayView removeFromSuperview];
            }
        }
        
        _tableOverlayView = nil;
        _tableOverlayView = tableOverlayView;
        
        if (_tableOverlayView) {
            _tableOverlayView.frame = [self rectForOverlayView];
            [self addToOverlayView:_tableOverlayView];
        }
        
        // XXXjoe There seem to be cases where this gets left disable - must investigate
        //_tableView.scrollEnabled = !_tableOverlayView;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setDataSource:(id<TTCollectionViewDataSource>)dataSource
{
    if (dataSource != _dataSource) {
        _dataSource = nil;
        _dataSource = dataSource;
        _collectionView.dataSource = nil;
        
        self.model = dataSource.model;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setLoadingView:(UIView*)view
{
    if (view != _loadingView) {
        if (_loadingView) {
            [_loadingView removeFromSuperview];
            TT_RELEASE_SAFELY(_loadingView);
        }
        _loadingView = view;
        if (_loadingView) {
            [self addToOverlayView:_loadingView];
            
        } else {
            [self resetOverlayView];
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setErrorView:(UIView*)view
{
    if (view != _errorView) {
        if (_errorView) {
            [_errorView removeFromSuperview];
            TT_RELEASE_SAFELY(_errorView);
        }
        _errorView = view;
        
        if (_errorView) {
            [self addToOverlayView:_errorView];
            
        } else {
            [self resetOverlayView];
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setEmptyView:(UIView*)view
{
    if (view != _emptyView) {
        if (_emptyView) {
            [_emptyView removeFromSuperview];
            TT_RELEASE_SAFELY(_emptyView);
        }
        _emptyView = view;
        if (_emptyView) {
            [self addToOverlayView:_emptyView];
            
        } else {
            [self resetOverlayView];
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<UICollectionViewDelegate>)createDelegate
{
   return [[TTCollectionViewDelegate alloc] initWithController:self];
}

-(UICollectionViewLayout *)createCollectionViewLayout
{
    return [[UICollectionViewFlowLayout alloc] init];
}


///////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath
{
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGRect)rectForOverlayView
{
    return [_collectionView frame];
}


@end