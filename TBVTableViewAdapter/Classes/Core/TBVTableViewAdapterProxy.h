//
//  TBVTableViewAdapterProxy.h
//  TBVTableViewAdapter
//
//  Created by tripleCC on 2017/6/17.
//  Copyright © 2017年 tripleCC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TBVTableViewAdapter;
NS_SWIFT_NAME(TableViewAdapterProxy)
@interface TBVTableViewAdapterProxy : NSObject
- (instancetype)initWithTableViewDelegate:(nullable id <UITableViewDelegate>)delegate
                              interceptor:(nullable TBVTableViewAdapter *)interceptor;
@end
NS_ASSUME_NONNULL_END
