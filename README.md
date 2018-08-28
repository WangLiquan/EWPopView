# EWPopView
<h3>类微博弹出动画</h3>

# 实现效果: 
静止时:子view对称排列,允许动态添加,0~24个都能较好的显示.

旋转时:中心view不动,子view随手势旋转,最下方子view变大突出.

# 实现思路:
所有的控件全部加到一个大的背景view上,本质上旋转的是这个背景view,在旋转背景view的同时,让它所有的子控件反向旋转,就实现了现在这种效果.

最下方的view变大是循环判断子view.frame.x,当它处于一个范围,并且frame.y小于中心view.frame.y的时候.修改它的transform,来使其变大,并且修改它的tag来标记它已经属于变大状态,当它frame.x超出了预定范围,使其还原.
<br>
![效果图预览](https://github.com/WangLiquan/popView/raw/master/images/demonstration.gif)
<br>
<br>
<br>
<br>
自己学习一直闭门造车,欢迎各位同僚与我交流.<br>
<img src="https://github.com/WangLiquan/popView/raw/master/images/wechat.jpg" width="30%" height="30%"><br>
添加请备注github
