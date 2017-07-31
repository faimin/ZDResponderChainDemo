//
//  ZDTableViewCell.m
//  ZDResponderTestDemo
//
//  Created by Zero.D.Saber on 2017/7/27.
//  Copyright © 2017年 Zero.D.Saber. All rights reserved.
//

#import "ZDTableViewCell.h"
#import "UIResponder+ZDRouter.h"

@interface ZDTableViewCell ()
@property (nonatomic, weak) IBOutlet UILabel *label;
@property (nonatomic, weak) IBOutlet UIButton *button;
@end

@implementation ZDTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if (!selected) return;
    NSString *selectorString = NSStringFromSelector(@selector(tableView:didSelectRowAtIndexPath:));
    [self deliverEventWithName:selectorString parameters:@{@"cell" : self}];
}

- (IBAction)sendEvent:(UIButton *)sender {
    void(^callback)(NSString *) = ^(NSString *newText){
        self.label.text = newText;
    };
    
    [self deliverEventWithName:@"hello:"
                    parameters:@{
                                 @"name" : @"Zero.D.Saber",
                                 @"block" : callback
                                 }];
}

- (void)privateMethod:(NSString *)string {
    self.label.text = string;
}

@end
