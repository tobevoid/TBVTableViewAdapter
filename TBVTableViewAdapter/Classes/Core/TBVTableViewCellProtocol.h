//
//  TBVTableViewCellProtocol.h
//  TBVTableViewAdapter
//
//  Created by tripleCC on 2017/6/16.
//  Copyright © 2017年 tripleCC. All rights reserved.
//

#ifndef TBVTableViewCellProtocol_h
#define TBVTableViewCellProtocol_h

@class TBVTableViewItem;
@protocol TBVTableViewCellProtocol <NSObject>
- (void)configureWithItem:(TBVTableViewItem *)item;
@end

#endif /* TBVTableViewCellProtocol_h */
