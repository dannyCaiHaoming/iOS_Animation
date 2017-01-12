//
//  ExplicitAnimationViewController.m
//  learn_CALayer
//
//  Created by 蔡浩铭 on 2017/1/6.
//  Copyright © 2017年 蔡浩铭. All rights reserved.
//



/*
 *  动画跟UI如出一辙，你需要做出修改，都需要在主线程进行修改，不然不会起任何作用
 *  如果你开始了动画，但是却死活无法停止动画，这时候你就要看看，你结束动画的语句，
 *  是在哪个线程执行的。反之，如果动画无法开始，你也要去查看动画开始的线程。
 *
 *
 */

#import "ExplicitAnimationViewController.h"

@interface ExplicitAnimationViewController ()<CAAnimationDelegate> 
{
    NSTimer *timer;
}

@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, strong) CALayer *shipLayer;

@property (weak, nonatomic) IBOutlet UIImageView *shizhen;
@property (weak, nonatomic) IBOutlet UIImageView *fenzhen;
@property (weak, nonatomic) IBOutlet UIImageView *miaozhen;


@end

@implementation ExplicitAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.shipLayer = [CALayer layer];
    self.shipLayer.frame = CGRectMake(0, 0, 128, 128);
    self.shipLayer.position = CGPointMake(150, 150);
    self.shipLayer.contents = (__bridge id)[UIImage imageNamed: @"blue"].CGImage;
    [self.containerView.layer addSublayer:self.shipLayer];
    
    
    self.miaozhen.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.fenzhen.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.shizhen.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    //
    [self tick];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tick{
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calender components:units fromDate:[NSDate date]];
    //calculate hour hand angle
    CGFloat hoursAngle = (components.hour / 12.0) * M_PI * 2.0;
    //calculate minute hand angle
    CGFloat minsAngle = (components.minute / 60.0) * M_PI * 2.0;
    //calculate second hand angle
    CGFloat secsAngle = (components.second / 60.0) * M_PI * 2.0;
    //rotate hands
    self.shizhen.transform = CGAffineTransformMakeRotation(hoursAngle);
    self.fenzhen.transform = CGAffineTransformMakeRotation(minsAngle);
    self.miaozhen.transform = CGAffineTransformMakeRotation(secsAngle);
    
}



- (IBAction)startAction:(id)sender {
    //animate the ship rotation
//    
//    __weak ExplicitAnimationViewController * weekSelf = self;
//    
//    dispatch_queue_t queue = dispatch_queue_create("com.Danny.ExplicitAnimationViewController", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue, ^{
//        CABasicAnimation *animation = [CABasicAnimation animation];
//        animation.keyPath = @"transform.rotation";
//        animation.duration = 2.0;
//        animation.byValue = @(M_PI * 2);
//        animation.repeatCount = 5.0;
//        //    animation.delegate = self;
//        [weekSelf.shipLayer addAnimation:animation forKey:@"rotateAnimation"];
//    });
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 2.0;
    animation.byValue = @(M_PI * 2);
    animation.repeatCount = 5.0;
    //    animation.delegate = self;
    [self.shipLayer addAnimation:animation forKey:@"rotateAnimation"];

}

- (IBAction)stopAction:(id)sender {
    [self.shipLayer removeAnimationForKey:@"rotateAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //log that the animation stopped
    NSLog(@"The animation stopped (finished: %@)", flag? @"YES": @"NO");
}
@end
