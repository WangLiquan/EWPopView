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
        for view in views {
            self.addSubview(view)
        }
    }

    func fadeInWithTime(time:TimeInterval) {
        self.alpha = 0
        UIView.animate(withDuration: time, animations: {
            self.alpha = 1
        }) { (_) in
        }
    }

    func fadeOutWithTime(time:TimeInterval) {
        self.alpha = 1
        UIView.animate(withDuration: time, animations: {
            self.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
    }

}
