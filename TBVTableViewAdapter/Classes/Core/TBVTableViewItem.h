//
//  TBVTableViewItem.h
//  TBVTableViewAdapter
//
//  Created by tripleCC on 2017/6/16.
//  Copyright © 2017年 tripleCC. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@class TBVTableViewSection;
@class TBVTableViewItem;

typedef void (^TBVTableViewItemSelectBlock)(TBVTableViewItem *item);

NS_SWIFT_NAME(TableViewItem)
@interface TBVTableViewItem : NSObject {
    @package
    __weak TBVTableViewSection *_section;
    NSInteger _row;
}
@property (nullable, weak, nonatomic, readonly) TBVTableViewSection *section;
@property (assign, nonatomic, readonly) NSInteger row;

@property (assign, nonatomic) BOOL shouldReuse;
@property (assign, nonatomic) CGFloat cellHeight;
@property (nullable, copy, nonatomic) TBVTableViewItemSelectBlock selectBlock;

+ (instancetype)item;

- (void)reload;
- (void)reloadWithRowAnimation:(UITableViewRowAnimation)animation;
- (void)selectWithAnimated:(BOOL)animated;
- (void)selectWithAnimated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition;
- (void)deselectWithAnimated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
