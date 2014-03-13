//
//  TTCollectionViewCell.m
//  Three20Lite4ARC
//
//  Created by 高飞 on 14-3-7.
//  Copyright (c) 2014年 高飞. All rights reserved.
//

#import "TTCollectionViewCell.h"

@implementation TTCollectionViewCell

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)object
{
    return _item;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object
{
    if (_item != object) {
        _item = nil;
        _item = object;
    }
}

@end
