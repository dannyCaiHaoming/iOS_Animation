圆角：
图层边框：
阴影：
shadowOpacity:是一个必须在0.0（不可见）和1.0（完全不透明）之间的浮点数。如果设置为1.0，将会显示一个有轻微模糊的黑色阴影
稍微在图层之上。
shadowColor控制着阴影的颜色,shadowOffset控制着阴影的方向和距离,shadowRadius控制着阴影的模糊度
阴影裁剪：
maskToBounds会将阴影部分也剪切掉。
如果需要用到剪切图层，但是又需要保留阴影部分，这时候就需要用到两个图层

shadowPath:
CGPath是一个Core Graphics对象，用来指定任意的一个矢量图形。我们可以通过这个属性单独于图层形状之外指定阴影的形状。


图层蒙版：
CALayer有一个属性叫做mask可以解决这个问题。这个属性本身就是个CALayer类型，有和其他图层一样的绘制和布局属性。它类似于一个子图层，相对于父图层（即拥有该属性的图层）布局，但是它却不是一个普通的子图层。不同于那些绘制在父图层中的子图层，mask图层定义了父图层的部分可见区域。
mask图层的Color属性是无关紧要的，真正重要的是图层的轮廓。mask属性就像是一个饼干切割机，mask图层实心的部分会被保留下来，其他的则会被抛弃。

拉伸过滤：
CALayer为此提供了三种拉伸过滤方法，他们是：
kCAFilterLinear
kCAFilterNearest
kCAFilterTrilinear
总的来说，对于比较小的图或者是差异特别明显，极少斜线的大图，最近过滤算法会保留这种差异明显的特质以呈现更好的结果。但是对于大多数的图尤其是有很多斜线或是曲线轮廓的图片来说，最近过滤算法会导致更差的结果。
线性过滤保留了形状，最近过滤保留了像素的差异。

组透明：
无论是是view的alpha，还是CALayer的opacity，都是会影响子层的。
mark： 从iOS7开始，默认将UIViewGroupOpacity设置为YES，整个图层树像一个整体一样透明。如果想尝试，你可以通过设置Info.plist文件中的UIViewGroupOpacity为NO来达到这个效果。
    
shouldRasterize跟UIViewGroupOpacity一起出现的时候会引起局部范围可控制的性能问题。具体是什么我也不清楚。但是在iOS7之后，基本就不用考虑组透明这个问题，因为默认了的。
