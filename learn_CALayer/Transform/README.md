仿射变化：（二维平面变化）
CGAffineTransform中的“仿射”的意思是无论变换矩阵用什么值，图层中平行的两条线在变换之后任然保持平行

混合变换：（连续变换）
view结束时候的位置属性可能不能通过单纯一个变换换算得出，需要结合多个换算计算出来。

CGAffineTransformMakeScale(CGFloat sx, CGFloat sy)
CGAffineTransformScale(CGAffineTransform t,CGFloat sx, CGFloat sy) 
二者区别：前者如果多次赋值，只会选择最后一个。
后者可以将连续赋值，但是不满足交换律！


view的transform与layer的affineTransform：
效果一样，二者的类型都是CGAffineTransForm，只是view对layer进行了封装

view的transform与layer的transFrom：
二者属性不一样，后者是CATransform3D。

3D变换：
为什么使用矩阵的m34元素就能做出透视效果。😅现在数学忘光了，找了些资料都不知道说什么。
透视投影：
使用transform.m34 = -1.0 ／ 500，使得视觉上不再是Y轴投影。


沿Y轴做相反旋转：
尽管Core Animation图层存在于3D空间之内，但它们并不都存在同一个3D空间。每个图层的3D场景其实是扁平化的，当你从正面观察一个图层，看到的实际上由子图层创建的想象出来的3D场景，但当你倾斜这个图层，你会发现实际上这个3D场景仅仅是被绘制在图层的表面。

所以将A沿Y轴旋转45度，然后将在A上的B沿Y轴反方向。B并不会恢复正原来的正方形，而是会再次被压缩。



固体对象：
所有的位移，旋转依照的坐标轴都是基于锚点的。
建立的立体空心对象之后，使用了透视投影，还需要进行照相机角度的调整，不然看到的只是正面。
使用sublayerTransform属性，可以对子layer进行统一处理
perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0); 
perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
统一绕Y，X轴旋转45度。



光亮和阴影：
