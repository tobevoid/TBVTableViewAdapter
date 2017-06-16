//
//  TBVTableViewSection.h
//  TBVTableViewAdapter
//
//  Created by tripleCC on 2017/6/16.
//  Copyright © 2017年 tripleCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBVTableViewItem.h"

NS_ASSUME_NONNULL_BEGIN

@class TBVTableViewAdapter;

NS_SWIFT_NAME(TableViewSection)
@interface TBVTableViewSection : NSObject {
    @package
    __weak TBVTableViewAdapter *_adapter;
    NSInteger _section;
}
@property (nullable, weak, nonatomic, readonly) TBVTableViewAdapter *adapter;
@property (nullable, strong, nonatomic, readonly) NSArray <TBVTableViewItem *> *items;
@property (assign, nonatomic, readonly) NSInteger section;

@property (nullable, strong, nonatomic) UIView *headerView;
@property (assign, nonatomic) CGFloat headerViewHeight;
@property (nullable, strong, nonatomic) UIView *footerView;
@property (assign, nonatomic) CGFloat footerViewHeight;

- (void)addItem:(nonnull TBVTableViewItem *)item;
- (void)removeItem:(nonnull TBVTableViewItem *)item;

- (void)reload;
- (void)reloadWithRowAnimation:(UITableViewRowAnimation)animation;

+ (instancetype)section;
+ (instancetype)minSection;
+ (instancetype)minFooterSection;
+ (instancetype)minHeaderSection;
@end
NS_ASSUME_NONNULL_END
