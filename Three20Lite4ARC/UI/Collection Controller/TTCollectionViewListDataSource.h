//
//  TTCollectionViewListDataSource.h
//  Three20Lite4ARC
//
//  Created by 高飞 on 14-3-10.
//  Copyright (c) 2014年 高飞. All rights reserved.
//

#import "TTCollectionViewDataSource.h"

@interface TTCollectionViewListDataSource : TTCollectionViewDataSource{
    NSMutableArray* _items;
}
@property (nonatomic, strong) NSMutableArray* items;

+ (TTCollectionViewListDataSource*)dataSourceWithObjects:(id)object, ...;
+ (TTCollectionViewListDataSource*)dataSourceWithItems:(NSMutableArray*)items;

- (id)initWithItems:(NSArray*)items;

- (NSIndexPath*)indexPathOfItemWithUserInfo:(id)userInfo;
@end
