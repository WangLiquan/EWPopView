//
//  ViewController.swift
//  popView
//
//  Created by Ethan.Wang on 2018/8/16.
//  Copyright © 2018年 Ethan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let topPopButton: UIButton = {
        let button = UIButton(frame: CGRect(x: ScreenInfo.Width/2 - 50, y: ScreenInfo.Height/2 - 150, width: 100, height: 100))
        button.backgroundColor = UIColor.gray
        button.setTitle("弹出", for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(onClickPopButton(_:)), for: .touchUpInside)
        return button
    }()
    let bottomPopButton: UIButton = {
        let button = UIButton(frame: CGRect(x: ScreenInfo.Width/2 - 50, y: ScreenInfo.Height/2 + 150, width: 100, height: 100))
        button.backgroundColor = UIColor.gray
        button.setTitle("弹出", for: .normal)
        button.tag = 2
        button.addTarget(self, action: #selector(onClickPopButton(_:)), for: .touchUpInside)
        return button
    }()
    let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backImage")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        drawMyView()
    }
    func drawMyView() {
        self.view.addSubview(backImageView)
        backImageView.frame = self.view.frame
        self.view.addSubview(topPopButton)
        self.view.addSubview(bottomPopButton)
    }

    @objc func onClickPopButton(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            popViewWithType(type:.left)
        case 2:
            popViewWithType(type: .right)
        default:
            break
        }
    }

    private func popViewWithType(type: PopViewType) {
        let popView = CRPopView.init(frame: self.view.frame,type:type)
        switch type {
        case .left:
            popView.backBlockLeft = {
                print(1)
            }
            popView.backBlockRight = {
                print(2)
            }
        case .right:
            popView.backBlockLeft = {
                print(3)
            }
            popView.backBlockRight = {
                print(4)
            }
        }
        popView.showToView(view: self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
