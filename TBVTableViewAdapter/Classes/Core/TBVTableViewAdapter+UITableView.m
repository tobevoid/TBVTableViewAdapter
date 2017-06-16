//
//  TBVTableViewAdapter+UITableView.m
//  TBVTableViewAdapter
//
//  Created by tripleCC on 2017/6/17.
//  Copyright © 2017年 tripleCC. All rights reserved.
//

#import "TBVTableViewAdapter+UITableView.h"

@implementation TBVTableViewAdapter (UITableView)
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TBVTableViewSection *localSection = self.sections[section];
    localSection->_section = section;
    
    return localSection.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TBVTableViewItem *localItem = self.sections[indexPath.section].items[indexPath.row];
    localItem->_row = indexPath.row;
    
    NSString *identifier = localItem.shouldReuse ? NSStringFromClass([localItem class]) : @(localItem.hash).stringValue;
    Class cellClass = NSClassFromString(self.itemMapping[NSStringFromClass([localItem class])]);
    NSAssert(cellClass, @"Can't find cell for item %@ in %@, you should register them first", localItem, self.itemMapping);
    
    if (![self.registeredCellClasses containsObject:cellClass]) {
        [tableView registerClass:cellClass forCellReuseIdentifier:identifier];
        [(NSMutableSet *)self.registeredCellClasses addObject:cellClass];
    }
    
    UITableViewCell <TBVTableViewCellProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell configureWithItem:localItem];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.tableViewDelegate respondsToSelector:_cmd]) {
        [self.tableViewDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    
    TBVTableViewItem *item = self.sections[indexPath.section].items[indexPath.row];
    if (item.selectBlock) {
        item.selectBlock(item);
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert(![self.tableViewDelegate respondsToSelector:_cmd], @"TBVTableViewAdapter is consuming method also implemented by the tableViewDelegate: %@", NSStringFromSelector(_cmd));
    return self.sections[indexPath.section].items[indexPath.row].cellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSAssert(![self.tableViewDelegate respondsToSelector:_cmd], @"TBVTableViewAdapter is consuming method also implemented by the tableViewDelegate: %@", NSStringFromSelector(_cmd));
    return self.sections[section].headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSAssert(![self.tableViewDelegate respondsToSelector:_cmd], @"TBVTableViewAdapter is consuming method also implemented by the tableViewDelegate: %@", NSStringFromSelector(_cmd));
    return self.sections[section].headerViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section; {
    NSAssert(![self.tableViewDelegate respondsToSelector:_cmd], @"TBVTableViewAdapter is consuming method also implemented by the tableViewDelegate: %@", NSStringFromSelector(_cmd));
    return self.sections[section].footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    NSAssert(![self.tableViewDelegate respondsToSelector:_cmd], @"TBVTableViewAdapter is consuming method also implemented by the tableViewDelegate: %@", NSStringFromSelector(_cmd));
    return self.sections[section].footerViewHeight;
}

@end
