//
//  GCDTimer+Extension.swift
//  popView
//
//  Created by Ethan.Wang on 2018/8/16.
//  Copyright © 2018年 Ethan. All rights reserved.
//

import Foundation
// swiftlint:disable identifier_name
/// GCD延时操作
///   - after: 延迟的时间
///   - handler: 事件
public func DispatchAfter(after: Double, handler:@escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + after) {
        handler()
    }
}
