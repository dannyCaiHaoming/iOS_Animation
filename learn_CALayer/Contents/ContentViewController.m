//
//  ContentViewController.m
//  learn_CALayer
//
//  Created by 蔡浩铭 on 2017/1/5.
//  Copyright © 2017年 蔡浩铭. All rights reserved.
//



#import "ContentViewController.h"

@interface ContentViewController ()<CALayerDelegate>

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CALayer *layer = [[CALayer alloc] init];
    layer.delegate = self;
    CGRect rect = CGRectMake(50, 100, 275, 467);
    layer.frame = rect;
    layer.backgroundColor = [UIColor grayColor].CGColor;
    [self.view.layer addSublayer:layer];
    
    CGPoint point ;
    point.x = 0;
    point.y = 0;
//    layer.anchorPoint = point;
    layer.masksToBounds = YES;
    
    //
    UIImage *image = [UIImage imageNamed:@"blue"];
    layer.contents = (__bridge id)image.CGImage;
    layer.contentsGravity = kCAGravityCenter;
    layer.contentsScale = image.scale / 2;
    //    layer.contentsRect = CGRectMake(0, 0, 0.5, 0.5);
    //    layer.contentsCenter = CGRectMake(0.1, 0.5, 0.1, 0.5);
    
//    [layer display];
}


- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    //draw a thick red circle
    CGContextSetLineWidth(ctx, 10.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
