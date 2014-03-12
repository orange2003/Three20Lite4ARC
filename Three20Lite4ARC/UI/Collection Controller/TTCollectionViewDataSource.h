//
//  TTCollectionDataSource.h
//  Three20Lite4ARC
//
//  Created by 高飞 on 14-3-7.
//  Copyright (c) 2014年 高飞. All rights reserved.
//

#import <Foundation/Foundation.h>
// Network
#import "TTModel.h"
#import <UIKit/UIKit.h>
@protocol TTCollectionViewDataSource <UICollectionViewDataSource, TTModel>
/**
 * Optional method to return a model object to delegate the TTModel protocol to.
 */
@property (nonatomic, strong) id<TTModel> model;

- (id)collectionView:(UICollectionView*)collectionView objectForRowAtIndexPath:(NSIndexPath*)indexPath;

- (Class)collectionView:(UICollectionView*)collectionView cellClassForObject:(id)object;

- (NSIndexPath*)collectionView:(UICollectionView*)collectionView indexPathForObject:(id)object;

- (void)collectionView:(UICollectionView*)collectionView cell:(UITableViewCell*)cell
willAppearAtIndexPath:(NSIndexPath*)indexPath;

/**
 * Informs the data source that its model loaded.
 *
 * That would be a good time to prepare the freshly loaded data for use in the table view.
 */
- (void)collectionViewDidLoadModel:(UICollectionView*)collectionView;

- (NSString*)titleForLoading:(BOOL)reloading;

- (UIImage*)imageForEmpty;

- (NSString*)titleForEmpty;

- (NSString*)subtitleForEmpty;

/**
 * return YES to include a reload button in the TTErrorView.
 */
- (BOOL)reloadButtonForEmpty;

- (UIImage*)imageForError:(NSError*)error;

- (NSString*)titleForError:(NSError*)error;

- (NSString*)subtitleForError:(NSError*)error;

@end
@interface TTCollectionViewDataSource : NSObject<TTCollectionViewDataSource>{
    id<TTModel> _model;
}

@end

///////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * A datasource that is eternally loading.  Useful when you are in between data sources and
 * want to show the impression of loading until your actual data source is available.
 */
@interface TTCollectionViewInterstitialDataSource : TTCollectionViewDataSource <TTModel>
@end
