//
//  TTCollectionViewCell.h
//  Three20Lite4ARC
//
//  Created by 高飞 on 14-3-7.
//  Copyright (c) 2014年 高飞. All rights reserved.
//

#import "TTTableLinkedItem.h"

@interface TTCollectionViewCell : UICollectionViewCell
{
    TTTableLinkedItem* _item;
}
@property (nonatomic, strong) id object;
@end
