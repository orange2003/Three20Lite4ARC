//
//  TTUICollectionViewDelegate.h
//  Three20Lite4ARC
//
//  Created by 高飞 on 14-3-10.
//  Copyright (c) 2014年 高飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class TTCollectionViewController;
@interface TTCollectionViewDelegate : NSObject<UICollectionViewDelegate>
{
    TTCollectionViewController* _controller;
}

- (id)initWithController:(TTCollectionViewController*)controller;

@property (nonatomic, readonly) TTCollectionViewController* controller;

@end
