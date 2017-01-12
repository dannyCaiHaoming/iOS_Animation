//
//  VisualEffectViewController.m
//  learn_CALayer
//
//  Created by 蔡浩铭 on 2017/1/10.
//  Copyright © 2017年 蔡浩铭. All rights reserved.
//

#import "VisualEffectViewController.h"




@interface VisualEffectViewController ()
//content view1
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;

@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;

@property (weak, nonatomic) IBOutlet UIView *view5_back;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UIView *view6;

@property (weak, nonatomic) IBOutlet UIView *view7;
@property (weak, nonatomic) IBOutlet UIView *view8;
//content view2
@property (strong, nonatomic) IBOutlet UIView *contentView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *digitsViews;
@property (strong, nonatomic) NSTimer *timer;






@end

@implementation VisualEffectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //

    
    [self first];
    [self second];
    [self third];
    [self forth];
    [self fifth];
    [self sixth];
}


- (void)first{
    //view1 加了阴影，但是使用了masksToBounds，把阴影也裁剪了
    _view1.layer.shadowOpacity = 0.5;
    _view1.layer.masksToBounds = YES;
    //
    _view3.layer.shadowOpacity = 0.5;
}

- (void)second{
    _view5_back.layer.shadowOpacity = 0.5;
    _view5_back.layer.cornerRadius = 10;
    _view5.layer.cornerRadius = 10;
    _view5.layer.masksToBounds = YES;
    
}

- (void)third{
    _view7.layer.shadowOpacity = 0.5;
    _view8.layer.shadowOpacity = 0.5;
    _view8.layer.cornerRadius = _view8.bounds.size.width / 2;
    
    CGMutablePathRef square = CGPathCreateMutable();
    CGPathAddRect(square, NULL, _view7.bounds);
    _view7.layer.shadowPath = square;
    CGPathRelease(square);
    
    CGMutablePathRef cicle = CGPathCreateMutable();
    CGPathAddEllipseInRect(cicle, NULL, _view8.bounds);
    _view8.layer.shadowPath = cicle;
    CGPathRelease(cicle);
}

- (IBAction)buttonAction:(id)sender {
    
    [self.view addSubview:self.contentView2];
    
}


- (void)forth{
    CALayer *layer = [[CALayer alloc] init];
    layer.frame = self.imageView.bounds;
    layer.contents = (__bridge id)[UIImage imageNamed:@"mask"].CGImage;
    
    self.imageView.layer.mask = layer;
}


- (void)fifth{
    UIImage *image = [UIImage imageNamed:@"Digits"];
    for (UIView *view in _digitsViews) {
        view.layer.contents = (__bridge id)image.CGImage;
        view.layer.contentsRect = CGRectMake(0, 0, 0.1, 1);
//        view.layer.contentsGravity = kCAGravityResizeAspect;
#warning  不知道为什么没起作用。。
        view.layer.magnificationFilter = kCAFilterNearest;//kCAFilterTrilinear;//
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];

    [self tick];
}



- (void)tick{
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//    NSCalendarUnitHour               = kCFCalendarUnitHour,
//    NSCalendarUnitMinute             = kCFCalendarUnitMinute,
//    NSCalendarUnitSecond             = kCFCalendarUnitSecond,
    NSDateComponents * components = [calendar components:unit fromDate:[NSDate date]];
    
    //set hour
    [self setDigits:components.hour / 10 forView:_digitsViews[0]];
    [self setDigits:components.hour % 10 forView:_digitsViews[1]];
    
    //minute
    [self setDigits:components.minute / 10 forView:_digitsViews[2]];
    [self setDigits:components.minute % 10 forView:_digitsViews[3]];
    
    //seconds
    [self setDigits:components.second / 10 forView:_digitsViews[4]];
    [self setDigits:components.second % 10 forView:_digitsViews[5]];
}


- (void)setDigits:(NSInteger)digit forView:(UIView *)view{
    view.layer.contentsRect = CGRectMake(0.1 * digit, 0, 0.1, 1);
}


- (void)sixth{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 400, 200, 100);
    button.backgroundColor = [UIColor whiteColor];
//    button.alpha = 0.5;
    button.layer.opacity = 0.5;
    button.layer.cornerRadius = 15;
    [_contentView2 addSubview:button];

    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 80, 50)];
    label.backgroundColor = [UIColor whiteColor];
    label.text = @"asdf";
    label.layer.opacity = 0.5;
    label.layer.cornerRadius = 10;
    button.layer.shouldRasterize = NO;
    [button addSubview:label];
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(250, 400, 200, 100);
    button2.backgroundColor = [UIColor whiteColor];
    button2.alpha = 0.5;
    button2.layer.cornerRadius = 15;
    [_contentView2 addSubview:button2];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 80, 50)];
    label2.backgroundColor = [UIColor whiteColor];
    label2.text = @"asdfasdf";
    label2.alpha = 0.5;
    label2.layer.cornerRadius = 10;
    button2.layer.shouldRasterize = YES;
    [button2 addSubview:label2];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end



