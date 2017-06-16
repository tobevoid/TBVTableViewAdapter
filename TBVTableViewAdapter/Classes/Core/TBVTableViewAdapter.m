//
//  TBVTableViewAdapter.m
//  TBVTableViewAdapter
//
//  Created by tripleCC on 2017/6/16.
//  Copyright © 2017年 tripleCC. All rights reserved.
//

#import "TBVTableViewAdapter+UITableView.h"
#import "TBVTableViewAdapter.h"
#import "TBVTableViewAdapterProxy.h"

@interface TBVTableViewAdapter ()
@property (strong, nonatomic, readonly) NSMutableArray <TBVTableViewSection *> *mSections;
@property (strong, nonatomic) NSMutableDictionary <NSString *, NSString *> *mItemMapping;
@property (strong, nonatomic) NSMutableSet <Class> *mRegisteredCellClasses;
@property (strong, nonatomic) TBVTableViewAdapterProxy *delegateProxy;
@end

@implementation TBVTableViewAdapter
- (instancetype)initWithTableView:(UITableView *)tableView {
    if (self = [super init]) {
        _tableView = tableView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _mSections = [NSMutableArray array];
        _mItemMapping = [NSMutableDictionary dictionary];
        _mRegisteredCellClasses = [NSMutableSet set];
    }
    
    return self;
}

#pragma mark - public
- (void)reload {
    [self.tableView reloadData];
}

- (void)addSection:(TBVTableViewSection *)section {
    NSParameterAssert(section);
    
    section->_adapter = self;
    [self.mSections addObject:section];
}

- (void)removeSection:(TBVTableViewSection *)section {
    NSParameterAssert(section);
    
    [self.mSections removeObject:section];
}


- (void)registerItem:(Class)item withCell:(Class)cell {
    NSParameterAssert(item);
    NSParameterAssert(cell && [cell conformsToProtocol:@protocol(TBVTableViewCellProtocol)]);
    
    self.mItemMapping[NSStringFromClass(item)] = NSStringFromClass(cell);
}

- (void)registerItems:(NSArray<Class> *)items {
    NSParameterAssert(items);
    
    for (Class itemCls in items) {
        NSString *item = NSStringFromClass(itemCls);
        
        NSString *realItem = item;
        if ([realItem hasSuffix:@"Item"]) {
            realItem = [realItem stringByReplacingOccurrencesOfString:@"Item" withString:@""];
        }
        
        Class cellCls = NSClassFromString([realItem stringByAppendingString:@"Cell"]);
        itemCls = NSClassFromString([realItem stringByAppendingString:@"Item"]);
        
        NSAssert(cellCls && itemCls, @"Can't find cell %@ or item %@", cellCls, itemCls);
        
        [self registerItem:itemCls withCell:cellCls];
    }
}

- (void)registerAllItems {
    NSParameterAssert(self.sections.count > 0);
    
    NSMutableArray *items = [NSMutableArray array];
    for (TBVTableViewSection *section in self.sections) {
        for (TBVTableViewItem *item in section.items) {
            [items addObject:[item class]];
        }
    }
    [self registerItems:items];
}

#pragma mark - private
- (void)createDelegateProxyForTableView {
    self.tableView.delegate = nil;
    
    self.delegateProxy = [[TBVTableViewAdapterProxy alloc] initWithTableViewDelegate:self.tableViewDelegate interceptor:self];
    
    self.tableView.delegate = (id <UITableViewDelegate>)self.delegateProxy ?: self;
}

#pragma mark - getter
- (NSArray<TBVTableViewSection *> *)sections {
    return self.mSections;
}

- (NSSet<Class> *)registeredCellClasses {
    return self.mRegisteredCellClasses;
}

- (NSDictionary<NSString *,NSString *> *)itemMapping {
    return self.mItemMapping;
}

- (void)setTableViewDelegate:(id <UITableViewDelegate>)tableViewDelegate {
    _tableViewDelegate = tableViewDelegate;
    
    [self createDelegateProxyForTableView];
}
@end
