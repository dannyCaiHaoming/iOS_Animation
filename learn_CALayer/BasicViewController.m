//
//  BasicViewController.m
//  learn_CALayer
//
//  Created by 蔡浩铭 on 2017/1/5.
//  Copyright © 2017年 蔡浩铭. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController ()

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = [NSString stringWithFormat:@"%@",[self class]];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#ifdef DEBUG
-(void)dealloc{
    NSLog(@"%@ dealloc",[self class]);
}
#endif


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
