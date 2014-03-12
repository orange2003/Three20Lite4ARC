//
//  TTCollectionViewSectionedDataSource.h
//  Three20Lite4ARC
//
//  Created by 高飞 on 14-3-11.
//  Copyright (c) 2014年 高飞. All rights reserved.
//

#import "TTCollectionViewDataSource.h"

@interface TTCollectionViewSectionedDataSource : TTCollectionViewDataSource {
    NSMutableArray* _sections;
    NSMutableArray* _items;
}

@property (nonatomic, strong) NSMutableArray* items;
@property (nonatomic, strong) NSMutableArray* sections;

/**
 * Objects should be in this format:
 *
 *   @"section title", item, item, @"section title", item, item, ...
 *
 * Where item is generally a type of TTTableItem.
 */
+ (TTCollectionViewSectionedDataSource*)dataSourceWithObjects:(id)object, ...;

/**
 * Objects should be in this format:
 *
 *   @"section title", arrayOfItems, @"section title", arrayOfItems, ...
 *
 * Where arrayOfItems is generally an array of items of type TTTableItem.
 */
+ (TTCollectionViewSectionedDataSource*)dataSourceWithArrays:(id)object, ...;

/**
 *  @param items
 *
 *    An array of arrays, where each array is the contents of a
 *    section, to be listed under the section title held in the
 *    corresponding index of the `section` array.
 *
 *  @param sections
 *
 *    An array of strings, where each string is the title
 *    of a section.
 *
 *  The items and sections arrays should be of equal length.
 */
+ (TTCollectionViewSectionedDataSource*)dataSourceWithItems:(NSArray*)items sections:(NSArray*)sections;

- (id)initWithItems:(NSArray*)items sections:(NSArray*)sections;

- (NSIndexPath*)indexPathOfItemWithUserInfo:(id)userInfo;

- (void)removeItemAtIndexPath:(NSIndexPath*)indexPath;
- (BOOL)removeItemAtIndexPath:(NSIndexPath*)indexPath andSectionIfEmpty:(BOOL)andSection;

@end
