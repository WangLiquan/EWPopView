//
//  CRPopView.swift
//  iTour
//
//  Created by Ethan.Wang on 2018/6/22.
//  Copyright © 2018年 Croninfo. All rights reserved.
//

import UIKit

struct ScreenInfo {
    static let Frame = UIScreen.main.bounds
    static let Height = Frame.height
    static let Width = Frame.width
    static let tabBarHeight:CGFloat = tabBarrHeight()
    static func isIphoneX() -> Bool {
        return UIScreen.main.bounds.equalTo(CGRect(x: 0, y: 0, width: 375, height: 812))
    }
    static private func tabBarrHeight() -> CGFloat {
        return isIphoneX() ? 83 : 49
    }
}
//popView两种Type,通过修改type来实现不同样式
enum PopViewType {
    case left//概况
    case right//发布
}

class CRPopView: UIView {

    var contentArr : [UIButton] = []

    var backBlockLeft : (()->Void)?//左侧按钮点击事件
    var backBlockRight : (()->Void)?//右侧按钮点击事件

    var leftButtonTitle:String?
    var rightButtonTitle:String?
    var leftButtonImage:String?
    var rightButtonImage:String?

    private var type: PopViewType = .left {
        didSet {
            switch type {
            case .left:
                leftButtonTitle = "历史"
                leftButtonImage = "lishi"
                rightButtonTitle = "今天"
                rightButtonImage = "jintian"
            case .right:
                leftButtonTitle = "政策"
                leftButtonImage = "zuixinzhengce"
                rightButtonTitle = "快报"
                rightButtonImage = "jdkb"
            }
        }
    }

    init(frame: CGRect,type: PopViewType) {
        super.init(frame: frame)
        //在init方法中直接赋值不能调用didSet方法,使用kvo方式赋值
        self.setValue(type, forKey: "type")
        drawMyView()
        addTap()
        addBtn()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //重写kvo方法才能完成赋值,不然报错
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        guard let type = value as? PopViewType else {
            return
        }
        self.type = type
    }

    func drawMyView() {
        //首先创建一个模糊效果
        let blurEffect = UIBlurEffect(style: .light)
        //接着创建一个承载模糊效果的视图
        let blurView = UIVisualEffectView(effect: blurEffect)
        //设置模糊视图的大小（全屏）
        blurView.frame.size = CGSize(width: self.frame.width, height: self.frame.height)
        //添加模糊视图到页面view上（模糊视图下方都会有模糊效果）
        self.addSubview(blurView)
    }
    //添加背景点击退出事件
    func addTap() {
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(fadeOut))
        self.addGestureRecognizer(tap)
    }
    //添加左右button,修改button数量只需要在这里修改
    func addBtn() {
        let leftButton = UIButton(frame: CGRect(x:ScreenInfo.Width/4-35,y:(ScreenInfo.Height-ScreenInfo.tabBarHeight)/2-35,width:70,height:70))
        leftButton.setBackgroundImage(UIImage(named: leftButtonImage ?? ""), for: .normal)
        leftButton.layer.cornerRadius = 35
        leftButton.addTarget(self, action: #selector(onClickButton(_:)), for: .touchUpInside)
        leftButton.tag = 0//左button
        contentArr.append(leftButton)
        //button下title
        let leftLabel = UILabel(frame: CGRect(x: -25, y: 80, width: 120, height: 30))
        leftLabel.text = leftButtonTitle
        leftLabel.textAlignment = .center
        leftButton.addSubview(leftLabel)

        let rightButton = UIButton(frame: CGRect(x: ScreenInfo.Width/4*3-35, y: (ScreenInfo.Height-ScreenInfo.tabBarHeight)/2-35, width: 70, height: 70))
        rightButton.setBackgroundImage(UIImage(named: rightButtonImage ?? ""), for: .normal)
        rightButton.layer.cornerRadius = 35
        rightButton.tag = 1//右button
        rightButton.addTarget(self, action: #selector(onClickButton(_:)), for: .touchUpInside)
        contentArr.append(rightButton)
        //button下title
        let rightLabel = UILabel(frame: CGRect(x: -25, y: 80, width: 120, height: 30))
        rightLabel.text = rightButtonTitle
        rightLabel.textAlignment = .center
        rightButton.addSubview(rightLabel)

        self.addSubViews(contentArr)

    }
    //背景点击退出事件
    @objc func fadeOut() {
        moveOutAnimation()
        self.fadeOutWithTime(time: 0.25)
    }
    //popview展示方法
    func showToView(view:UIView) {
        view.addSubview(self)
        self.fadeInWithTime(time: 0.25)
        moveInAnimation()
    }
    //popview展示动画
    func moveInAnimation() {
        for (index,value) in (contentArr.enumerated()) {
            let btn:UIButton = value
            let btnX = btn.frame.origin.x
            let btnY = btn.frame.origin.y
            let width = btn.frame.size.width
            let height = btn.frame.size.height
            btn.frame = CGRect(x: btnX, y: 10, width: width, height: height)
            btn.alpha = 0.0

            DispatchAfter(after: (Double(index) * 0.05)) {
                UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 25, options: .curveEaseIn, animations: {
                    btn.alpha = 1
                    btn.frame = CGRect(x: btnX, y: btnY, width: width, height: height)
                }, completion: { (_) in
                    if (btn.isEqual(self.contentArr.last)) {
                        self.superview?.superview?.isUserInteractionEnabled = true
                    }
                })
            }
        }
    }
    //popview退出动画
    func moveOutAnimation() {
        for (index,value) in (contentArr.enumerated()) {
            let btn:UIButton = value
            let btnX = btn.frame.origin.x
            let btnY = btn.frame.origin.y
            let width = btn.frame.size.width
            let height = btn.frame.size.height
            btn.frame = CGRect(x: btnX, y: btnY, width: width, height: height)
            btn.alpha = 1

            DispatchAfter(after: (Double(index) * 0.05)) {
                UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 25, options: .curveEaseIn, animations: {
                    btn.alpha = 0
                    btn.frame = CGRect(x: btnX, y: 10, width: width, height: height)
                }, completion: { (_) in
                    if (btn.isEqual(self.contentArr.last)) {
                        self.superview?.superview?.isUserInteractionEnabled = true
                    }
                })
            }
        }
    }
    //点击左右button事件
    @objc func onClickButton(_ button:UIButton) {
        if button.tag  == 0 {
            if backBlockLeft != nil {
                backBlockLeft!()
            }
        } else {
            if backBlockRight != nil {
                backBlockRight!()
            }
        }
    }
}
