//
//  ViewController.m
//  TBVTableViewAdapterDemo
//
//  Created by tripleCC on 2017/6/16.
//  Copyright © 2017年 tripleCC. All rights reserved.
//

#import "ViewController.h"
#import "TBVTableViewAdapter.h"
#import "TBVTableViewCell.h"


@interface ViewController () <UITableViewDelegate>
@property (strong, nonatomic) TBVTableViewAdapter *adapter;
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation ViewController
- (IBAction)click:(id)sender {
    
    TBVTableViewItem *item = self.adapter.sections.firstObject.items.firstObject;
    item.cellHeight = arc4random_uniform(100);
    [item reloadWithRowAnimation:UITableViewRowAnimationRight];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    
    self.adapter = [[TBVTableViewAdapter alloc] initWithTableView:self.tableView];
    self.adapter.tableViewDelegate = self;
    
    TBVTableViewSection *section = [[TBVTableViewSection alloc] init];
    section.headerViewHeight = 100;
    {
        TBVTableViewItem *item = [TBVTableViewItem new];
        item.selectBlock = ^(TBVTableViewItem * _Nonnull item) {
            item.cellHeight = arc4random_uniform(200);
            [item reload];
        };
        [section addItem:item];
    }
    
    {
        TBVTableViewItem *item = [TBVTableViewItem new];
        [section addItem:item];        
    }
    
    [self.adapter registerItem:[TBVTableViewItem class] withCell:[TBVTableViewCell class]];
    [self.adapter addSection:section];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    self.tableView.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
