布局：
UIView有三个比较重要的布局属性：frame，bounds和center，CALayer对应地叫做frame，bounds和position。
frame代表了图层的外部坐标（也就是在父图层上占据的空间），bounds是内部坐标（{0, 0}通常是图层的左上角），center和position都代表了相对于父图层
anchorPoint所在的位置。
视图的frame，bounds和center属性仅仅是存取方法，当操纵视图的frame，实际上是在改变位于视图下方CALayer的frame，不能够独立于图层之外改变视图的frame。
对于视图或者图层来说，frame并不是一个非常清晰的属性，它其实是一个虚拟属性，是根据bounds，position和transform计算而来，
所以当其中任何一个值发生改变，frame都会变化。相反，改变frame的值同样会影响到他们当中的值

锚点：
之前提到过，视图的center属性和图层的position属性都指定了anchorPoint相对于父图层的位置。图层的anchorPoint通过position来控制它的frame的位置，你可
以认为anchorPoint是用来移动
图层的把柄。
默认来说，anchorPoint位于图层的中点，所以图层的将会以这个点为中心放置。
为什么锚点从（0.5，0.5）移动到（0，0）图层反而往左下角移动？明明左下角是（0，0）右上角是（1，1）


自动布局：
如果想随意控制CALayer的布局，就需要手工操作。最简单的方法就是使用CALayerDelegate如下函数：

- (void)layoutSublayersOfLayer:(CALayer *)layer;

当图层的bounds发生改变，或者图层的-setNeedsLayout方法被调用的时候，这个函数将会被执行。这使得你可以手动地重新摆放或者重新调整子图层的大小，但是不能像
UIView的autoresizingMask和constraints属性做到自适应屏幕旋转。

