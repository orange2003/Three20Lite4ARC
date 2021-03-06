//
//  TTCollectionDataSource.m
//  Three20Lite4ARC
//
//  Created by 高飞 on 14-3-7.
//  Copyright (c) 2014年 高飞. All rights reserved.
//

#import "TTCollectionViewDataSource.h"
#import "TTCollectionViewCell.h"

// Core
#import "TTCorePreprocessorMacros.h"
#import "TTGlobalCoreLocale.h"

@implementation TTCollectionViewDataSource
@synthesize model = _model; 
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UICollectionViewDataSource


///////////////////////////////////////////////////////////////////////////////////////////////////

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self collectionView:collectionView objectForRowAtIndexPath:indexPath];
    Class cellClass = [self collectionView:collectionView cellClassForObject:object];
    
    NSString* identifier = NSStringFromClass(cellClass);
    
    UICollectionViewCell* cell = (UICollectionViewCell*)[collectionView
                                               dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if ([cell isKindOfClass:[TTCollectionViewCell class]]) {
        [(TTCollectionViewCell*)cell setObject:object];
    }
    
    return cell;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTModel


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSMutableArray*)delegates {
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoaded {
    return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoading {
    return NO;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoadingMore {
    return NO;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isOutdated {
    return NO;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(NSURLCacheStoragePolicy)cachePolicy more:(BOOL)more {
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)cancel {
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)invalidate:(BOOL)erase {
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewDataSource


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<TTModel>)model {
    return _model ? _model : self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)collectionView:(UICollectionView*)collectionView objectForRowAtIndexPath:(NSIndexPath*)indexPath {
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (Class)collectionView:(UICollectionView*)collectionView cellClassForObject:(id)object {
    // This will display an empty white table cell - probably not what you want, but it
    // is better than crashing, which is what happens if you return nil here
    return [TTCollectionViewCell class];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(NSIndexPath *)collectionView:(UICollectionView *)collectionView indexPathForObject:(id)object
{
    return nil;
}


-(void)collectionView:(UICollectionView *)collectionView cell:(UITableViewCell *)cell willAppearAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)collectionViewDidLoadModel:(UICollectionView *)collectionView
{
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForLoading:(BOOL)reloading {
    if (reloading) {
        return TTLocalizedString(@"Updating...", @"");
        
    } else {
        return TTLocalizedString(@"Loading...", @"");
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIImage*)imageForEmpty {
    return [self imageForError:nil];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForEmpty {
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)subtitleForEmpty {
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)reloadButtonForEmpty {
    return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIImage*)imageForError:(NSError*)error {
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForError:(NSError*)error {
    return TTDescriptionForError(error);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)subtitleForError:(NSError*)error {
    return TTLocalizedString(@"Sorry, there was an error.", @"");
}

@end

#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTCollectionViewInterstitialDataSource

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewDataSource

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<TTModel>)model
{
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTModel

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSMutableArray*)delegates
{
    return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoaded
{
    return NO;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoading
{
    return YES;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoadingMore
{
    return NO;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isOutdated
{
    return NO;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(NSURLCacheStoragePolicy)cachePolicy more:(BOOL)more
{
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)cancel
{
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)invalidate:(BOOL)erase
{
}

@end
