//
//  TBVTableViewAdapterProxy.m
//  TBVTableViewAdapter
//
//  Created by tripleCC on 2017/6/17.
//  Copyright © 2017年 tripleCC. All rights reserved.
//

#import "TBVTableViewAdapterProxy.h"

@interface TBVTableViewAdapterProxy () {
    __weak TBVTableViewAdapter *_interceptor;
    __weak id <UITableViewDelegate> _delegate;
}

@end

inline static BOOL isInterceptedSelector(SEL sel) {
    return (
            sel == @selector(tableView:didSelectRowAtIndexPath:) ||
            sel == @selector(tableView:viewForHeaderInSection:) ||
            sel == @selector(tableView:heightForHeaderInSection:) ||
            sel == @selector(tableView:viewForFooterInSection:) ||
            sel == @selector(tableView:heightForFooterInSection:) ||
            sel == @selector(tableView:heightForRowAtIndexPath:)
            );
}

@implementation TBVTableViewAdapterProxy
- (instancetype)initWithTableViewDelegate:(id <UITableViewDelegate>)delegate interceptor:(TBVTableViewAdapter *)interceptor {
    if (self = [super init]) {
        _interceptor = interceptor;
        _delegate = delegate;
    }
    
    return self;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return isInterceptedSelector(aSelector) || [_delegate respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (isInterceptedSelector(aSelector)) {
        return _interceptor;
    }
    
    return _delegate;
}

// https://github.com/Flipboard/FLAnimatedImage/blob/76a31aefc645cc09463a62d42c02954a30434d7d/FLAnimatedImage/FLAnimatedImage.m#L786-L807
- (void)forwardInvocation:(NSInvocation *)invocation {
    void *nullPointer = NULL;
    [invocation setReturnValue:&nullPointer];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}
@end
