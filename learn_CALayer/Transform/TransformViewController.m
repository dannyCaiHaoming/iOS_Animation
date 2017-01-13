//
//  TransformViewController.m
//  learn_CALayer
//
//  Created by 蔡浩铭 on 2017/1/12.
//  Copyright © 2017年 蔡浩铭. All rights reserved.
//
#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5

#import <GLKit/GLKit.h>
#import "TransformViewController.h"

@interface TransformViewController (){
    UIImage *image;
}
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *faceViews;

@end

@implementation TransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    image = [UIImage imageNamed:@"xueren"];
    [self first];
    [self second];
    [self third];
    [self forth];
    [self fifth];
    
}


- (void)first{
    
    _view1.layer.contents = (__bridge id)image.CGImage;
    
    
//    _view1.transform = CGAffineTransformMakeRotation(90 * M_PI / 180);
    _view1.layer.affineTransform = CGAffineTransformMakeRotation(90 * M_PI / 180);
    
}


- (void)second{
    _view2.layer.contents = (__bridge id)image.CGImage;
    
    /////多次赋值，只会使用最后一个。
//    _view2.transform = CGAffineTransformMakeScale(0.5, 0.5);
//    _view2.transform = CGAffineTransformMakeRotation(RADIANS_TO_DEGREES(30));
//    _view2.transform = CGAffineTransformMakeTranslation(200, 0);
    
    /////不满足交换律
    CGAffineTransform transform = CGAffineTransformIdentity;
//    transform = CGAffineTransformTranslate(transform, 200, 0);
    transform = CGAffineTransformScale(transform, 0.5, 0.5);
    transform = CGAffineTransformRotate(transform, RADIANS_TO_DEGREES(30));
    transform = CGAffineTransformTranslate(transform, 200, 0);
    _view2.transform = transform;
    
    
}


- (void)third{
    _view3.layer.contents = (__bridge id)image.CGImage;
    //如果只是单纯沿某一个方向旋转，由于iOS使用Y轴投影，所以图像会看起来像被压缩。
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / 500;
    transform = CATransform3DRotate(transform, RADIANS_TO_DEGREES(45), 0, 1, 0);//CATransform3DMakeRotation(RADIANS_TO_DEGREES(45), 0, 1, 0);
    
    _view3.layer.transform = transform;
    
    
}


- (void)forth{
    _view4.layer.transform = CATransform3DMakeRotation(RADIANS_TO_DEGREES(45), 0, 1, 0);
    
//    _view5.layer.transform = CATransform3DMakeRotation(RADIANS_TO_DEGREES(-45), 0, 1, 0);
    
    
}



- (void)fifth{
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    self.contentView.layer.sublayerTransform = perspective;

    
    
    
    
    //face 1
    
    CATransform3D transfrom0 = CATransform3DMakeTranslation(0, 0, 100);
    [self setTransformWithIndex:0 Transform:transfrom0];
    
    //face 2
    transfrom0 = CATransform3DMakeTranslation(0, 0, -100);
    transfrom0 = CATransform3DRotate(transfrom0, M_PI, 0, 1, 0);
    [self setTransformWithIndex:1 Transform:transfrom0];
    
    //face 3
    transfrom0 = CATransform3DMakeTranslation(-100, 0, 0);
    transfrom0 = CATransform3DRotate(transfrom0, -M_PI_2, 0, 1, 0);
    [self setTransformWithIndex:2 Transform:transfrom0];
    
    //face 4
    
    transfrom0 = CATransform3DMakeTranslation(100, 0, 0);
    transfrom0 = CATransform3DRotate(transfrom0, M_PI_2, 0, 1, 0);
    [self setTransformWithIndex:3 Transform:transfrom0];

    //face 5
    transfrom0 = CATransform3DMakeTranslation(0, 100, 0);
    transfrom0 = CATransform3DRotate(transfrom0, -M_PI_2, 1, 0, 0);
    [self setTransformWithIndex:4 Transform:transfrom0];

    //face 6
    transfrom0 = CATransform3DMakeTranslation(0, -100, 0);
    transfrom0 = CATransform3DRotate(transfrom0, M_PI_2, 1, 0, 0);
    [self setTransformWithIndex:5 Transform:transfrom0];

    
}




- (void)setTransformWithIndex:(NSInteger)index Transform:(CATransform3D)transform{
    
    UIView *face = self.faceViews[index];
    
    CGPoint point = CGPointMake(_contentView.bounds.size.width/2, _contentView.bounds.size.height/2);
    face.center = point;
    face.layer.transform = transform;
    
    [self.contentView addSubview:face];
//    [self applyLightingToFace:face.layer];
    
}

- (void)applyLightingToFace:(CALayer *)face
{
    //add lighting layer
    CALayer *layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];
    //convert the face transform to matrix
    //(GLKMatrix4 has the same structure as CATransform3D)
    //译者注：GLKMatrix4和CATransform3D内存结构一致，但坐标类型有长度区别，所以理论上应该做一次float到CGFloat的转换，感谢[@zihuyishi](https://github.com/zihuyishi)同学~
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
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
