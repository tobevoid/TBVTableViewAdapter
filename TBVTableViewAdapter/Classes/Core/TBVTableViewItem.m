//
//  TBVTableViewItem.m
//  TBVTableViewAdapter
//
//  Created by tripleCC on 2017/6/16.
//  Copyright © 2017年 tripleCC. All rights reserved.
//

#import "TBVTableViewItem.h"
#import "TBVTableViewSection.h"
#import "TBVTableViewAdapter.h"

@interface TBVTableViewItem ()
@property (strong, nonatomic, readonly) NSIndexPath *indexPath;
@end

@implementation TBVTableViewItem
#pragma mark - init
- (instancetype)init {
    if (self = [super init]) {
        _shouldReuse = YES;
        _cellHeight = 44.0f;
    }
    
    return self;
}

+ (instancetype)item {
    return [[self alloc] init];
}

#pragma mark - public
- (void)reload {
    [self reloadWithRowAnimation:UITableViewRowAnimationNone];
}

- (void)reloadWithRowAnimation:(UITableViewRowAnimation)animation {
    [self.section.adapter.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:animation];
}

- (void)selectWithAnimated:(BOOL)animated {
    [self selectWithAnimated:animated scrollPosition:UITableViewScrollPositionNone];
}

- (void)selectWithAnimated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition {
    [self.section.adapter.tableView scrollToRowAtIndexPath:self.indexPath atScrollPosition:scrollPosition animated:animated];
}

- (void)deselectWithAnimated:(BOOL)animated {
    [self.section.adapter.tableView deselectRowAtIndexPath:self.indexPath animated:animated];
}

#pragma mark - getter
- (NSIndexPath *)indexPath {
    return [NSIndexPath indexPathForRow:self.row inSection:self.section.section];
}
@end
