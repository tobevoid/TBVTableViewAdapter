//
//  TBVTableViewAdapter.h
//  TBVTableViewAdapter
//
//  Created by tripleCC on 2017/6/16.
//  Copyright © 2017年 tripleCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBVTableViewAdapterMacro.h"
#import "TBVTableViewCellProtocol.h"
#import "TBVTableViewSection.h"
#import "TBVTableViewItem.h"

TBV_SUBCLASSING_RESTRICTED
NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(TableViewAdapter)
@interface TBVTableViewAdapter : NSObject
@property (nullable, weak, nonatomic, readonly) UITableView *tableView;
@property (nullable, strong, nonatomic, readonly) NSArray <TBVTableViewSection *> *sections;
@property (nullable, strong, nonatomic, readonly) NSSet <Class> *registeredCellClasses;
@property (nullable, strong, nonatomic, readonly) NSDictionary <NSString *, NSString *> *itemMapping;

@property (nullable, weak, nonatomic) id <UITableViewDelegate> tableViewDelegate;

- (instancetype)initWithTableView:(nonnull UITableView *)tableView;

- (void)addSection:(nonnull TBVTableViewSection *)section;
- (void)removeSection:(nonnull TBVTableViewSection *)section;

- (void)registerItem:(nonnull Class)item withCell:(nonnull Class)cell;
- (void)registerItems:(nonnull NSArray <Class> *)items;
- (void)registerAllItems;

- (void)reload;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
@end
NS_ASSUME_NONNULL_END
