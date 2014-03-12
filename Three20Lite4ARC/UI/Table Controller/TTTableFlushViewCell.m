//
// Copyright 2009-2011 Facebook
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "TTTableFlushViewCell.h"

// UI
#import "TTTableViewItem.h"

// UICommon
#import "TTGlobalUICommon.h"

// Core
#import "TTCorePreprocessorMacros.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableFlushViewCell

@synthesize item = _item;
@synthesize view = _view;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier
{
    self = [super initWithStyle:style
                reuseIdentifier:identifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc
{
    TT_RELEASE_SAFELY(_item);
    TT_RELEASE_SAFELY(_view);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewCell class public

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object
{
    return TT_ROW_HEIGHT;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews
{
    [super layoutSubviews];
    _view.frame = self.contentView.bounds;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewCell

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)object
{
    return _item ? _item : (id)_view;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object
{
    if (object != _view && object != _item) {
        [_view removeFromSuperview];
        TT_RELEASE_SAFELY(_view);
        TT_RELEASE_SAFELY(_item);

        if ([object isKindOfClass:[UIView class]]) {
            _view = object;

        } else if ([object isKindOfClass:[TTTableViewItem class]]) {
            _item = object;
            _view = _item.view;
        }

        [self.contentView addSubview:_view];
    }
}

@end
