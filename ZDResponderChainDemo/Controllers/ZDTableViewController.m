//
//  ZDTableViewController.m
//  ZDResponderTestDemo
//
//  Created by Zero.D.Saber on 2017/7/27.
//  Copyright © 2017年 Zero.D.Saber. All rights reserved.
//

#import "ZDTableViewController.h"
#import "ZDTableViewCell.h"
#import "UIResponder+ZDRouter.h"
#import "NSObject+ZDTools.h"

@interface ZDTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSDictionary <NSString *, NSInvocation *> *eventStrategy;
@end

@implementation ZDTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)deliverEventWithName:(NSString *)eventName parameters:(NSDictionary *)paramsDict {
    void(^cellBlock)(NSString *) = paramsDict[@"block"];
    if (cellBlock) {
        cellBlock([NSString stringWithFormat:@"%@", [NSDate date]]);
    }
    
    NSInvocation *invocation = self.eventStrategy[eventName];
    [invocation setArgument:&paramsDict atIndex:2];
    [invocation invoke];
    id resultValue = [self zd_getReturnFromInvocation:invocation withSigature:[invocation.target methodSignatureForSelector:invocation.selector]];
    NSLog(@"%@", resultValue);
}

- (void)didSelecteCell:(NSDictionary *)params {
    NSLog(@"点击的tableviewCell：%@", params[@"cell"]);
}

- (void)hello:(NSDictionary *)paramsDict {
    NSLog(@"hello %@", paramsDict[@"name"]);
}

- (NSInvocation *)setupInvocationWithSelector:(SEL)selector {
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:selector]];
    [invocation setTarget:self];
    [invocation setSelector:selector];
    return invocation;
}

#pragma mark - UITableViewDatasource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZDTableViewCell class])];
    
    return cell;
}

#pragma mark - Property

- (NSDictionary <NSString *, NSInvocation *> *)eventStrategy {
    if (_eventStrategy == nil) {
        _eventStrategy = @{
                           NSStringFromSelector(@selector(tableView:didSelectRowAtIndexPath:)) : [self setupInvocationWithSelector:@selector(didSelecteCell:)],
                           @"hello:" : [self setupInvocationWithSelector:@selector(hello:)]
                           };
    }
    return _eventStrategy;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
