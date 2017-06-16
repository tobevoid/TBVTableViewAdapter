//
//  TBVTableViewSection.m
//  TBVTableViewAdapter
//
//  Created by tripleCC on 2017/6/16.
//  Copyright © 2017年 tripleCC. All rights reserved.
//

#import "TBVTableViewSection.h"
#import "TBVTableViewAdapter.h"

@interface TBVTableViewSection ()
@property (nullable, strong, nonatomic, readonly) NSMutableArray <TBVTableViewItem *> *mItems;
@end

@implementation TBVTableViewSection
#pragma mark - init
- (instancetype)init {
    if (self = [super init]) {
        _mItems = [NSMutableArray array];
    }
    
    return self;
}

+ (instancetype)section {
    return [[self alloc] init];
}

+ (instancetype)minSection {
    TBVTableViewSection *section = [self section];
    // http://stackoverflow.com/questions/17699831/how-to-change-height-of-grouped-uitableview-header
    section.footerViewHeight = CGFLOAT_MIN;
    section.headerViewHeight = CGFLOAT_MIN;
    return section;
}

+ (instancetype)minFooterSection {
    TBVTableViewSection *section = [self section];
    section.footerViewHeight = CGFLOAT_MIN;
    return section;
}

+ (instancetype)minHeaderSection {
    TBVTableViewSection *section = [self section];
    section.headerViewHeight = CGFLOAT_MIN;
    return section;
}

#pragma mark - public
- (void)addItem:(TBVTableViewItem *)item {
    NSParameterAssert(item);
    
    item->_section = self;
    [self.mItems addObject:item];
}

- (void)removeItem:(TBVTableViewItem *)item {
    NSParameterAssert(item);
    
    [self.mItems removeObject:item];
}

- (void)reload {
    [self reloadWithRowAnimation:UITableViewRowAnimationNone];
}

- (void)reloadWithRowAnimation:(UITableViewRowAnimation)animation {
    [self.adapter.tableView reloadSections:[NSIndexSet indexSetWithIndex:self.section] withRowAnimation:animation];
}

#pragma mark - getter
- (NSArray<TBVTableViewItem *> *)items {
    return self.mItems;
}

@end
