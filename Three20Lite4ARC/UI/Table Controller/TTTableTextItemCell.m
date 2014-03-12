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

#import "TTTableTextItemCell.h"

// UI
#import "UIViewAdditions.h"
#import "UITableViewAdditions.h"

// - Table items
#import "TTTableTextItem.h"
#import "TTTableGrayTextItem.h"

static const CGFloat kMaxLabelHeight = 2000.0f;
static const UILineBreakMode kLineBreakMode = UILineBreakModeWordWrap;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableTextItemCell

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier
{
    self = [super initWithStyle:style
                reuseIdentifier:identifier];
    if (self) {
        //self.textLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
        self.textLabel.lineBreakMode = kLineBreakMode;
        self.textLabel.numberOfLines = 0;
    }

    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Class private

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (UIFont*)textFontForItem:(TTTableTextItem*)item
{
    return [UIFont boldSystemFontOfSize:17];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewCell class public

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object
{
    TTTableTextItem* item = object;

    CGFloat width = tableView.width - (kTableCellHPadding * 2 + [tableView tableCellMargin] * 2);
    UIFont* font = [self textFontForItem:item];
    CGSize size = [item.text sizeWithFont:font
                        constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                            lineBreakMode:kLineBreakMode];
    if (size.height > kMaxLabelHeight) {
        size.height = kMaxLabelHeight;
    }

    return size.height + kTableCellVPadding * 2;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews
{
    [super layoutSubviews];

    self.textLabel.frame = CGRectInset(self.contentView.bounds,
                                       kTableCellHPadding, kTableCellVPadding);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewCell

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object
{
    if (_item != object) {
        [super setObject:object];

        TTTableTextItem* item = object;
        self.textLabel.text = item.text;
    }
}

@end
