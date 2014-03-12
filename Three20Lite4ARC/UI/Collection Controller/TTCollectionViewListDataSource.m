//
//  TTCollectionViewListDataSource.m
//  Three20Lite4ARC
//
//  Created by 高飞 on 14-3-10.
//  Copyright (c) 2014年 高飞. All rights reserved.
//

#import "TTCollectionViewListDataSource.h"
// UI
#import "TTTableItem.h"

// Core
#import "TTCorePreprocessorMacros.h"

@implementation TTCollectionViewListDataSource
@synthesize items = _items;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithItems:(NSArray*)items
{
    self = [self init];
    if (self) {
        _items = [items mutableCopy];
    }
    
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Class public

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (TTCollectionViewListDataSource*)dataSourceWithObjects:(id)object, ...
{
    NSMutableArray* items = [NSMutableArray array];
    va_list ap;
    va_start(ap, object);
    while (object) {
        [items addObject:object];
        object = va_arg(ap, id);
    }
    va_end(ap);
    
    return [[self alloc] initWithItems:items];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (TTCollectionViewListDataSource*)dataSourceWithItems:(NSMutableArray*)items
{
    return [[self alloc] initWithItems:items];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UICollectionViewDataSource

///////////////////////////////////////////////////////////////////////////////////////////////////
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _items.count;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTCollectionViewDataSource

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)collectionView:(UICollectionView*)collectionView objectForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.row < _items.count) {
        return [_items objectAtIndex:indexPath.row];
        
    } else {
        return nil;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSIndexPath*)collectionView:(UICollectionView*)collectionView indexPathForObject:(id)object
{
    NSUInteger objectIndex = [_items indexOfObject:object];
    if (objectIndex != NSNotFound) {
        return [NSIndexPath indexPathForRow:objectIndex
                                  inSection:0];
    }
    return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSMutableArray*)items
{
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSIndexPath*)indexPathOfItemWithUserInfo:(id)userInfo
{
    for (NSInteger i = 0; i < _items.count; ++i) {
        TTTableItem* item = [_items objectAtIndex:i];
        if (item.userInfo == userInfo) {
            return [NSIndexPath indexPathForRow:i
                                      inSection:0];
        }
    }
    return nil;
}

@end
