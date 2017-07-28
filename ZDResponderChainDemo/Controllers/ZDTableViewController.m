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

@interface ZDTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
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
    NSLog(@"event：%@", eventName);
    NSLog(@"参数：%@", paramsDict);
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
