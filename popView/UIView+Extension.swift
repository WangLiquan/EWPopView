//
//  UIView+Extension.swift
//  popView
//
//  Created byEthan.Wang on 2018/8/16.
//  Copyright © 2018年 Ethan. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addSubViews(_ views:[UIView]) {
        for v in views {
            self.addSubview(v)
        }
    }

    func fadeInWithTime(time:TimeInterval){
        self.alpha = 0
        UIView.animate(withDuration: time, animations: {
            self.alpha = 1
        }) { (finished) in
        }
    }

    func fadeOutWithTime(time:TimeInterval){
        self.alpha = 1
        UIView.animate(withDuration: time, animations: {
            self.alpha = 0
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
}
