//
//  ViewController.m
//  learn_CALayer
//
//  Created by 蔡浩铭 on 2017/1/4.
//  Copyright © 2017年 蔡浩铭. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * dataSoure;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    dataSoure = @[[ContentViewController new],[ExplicitAnimationViewController new],[VisualEffectViewController new],[TransformViewController new]];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSoure.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    id controller = [dataSoure objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-%@",(long)indexPath.row,NSStringFromClass([controller class])];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *controller = [dataSoure objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
