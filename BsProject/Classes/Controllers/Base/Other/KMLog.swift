//
//  KMLog.swift
//  BsProject
//
//  Created by wujianming on 16/10/20.
//  Copyright © 2016年 szteyou. All rights reserved.
//

import UIKit

class KMLog: NSObject {
    static func show(_ items: String) {
        #if DEBUG
            print("\(items)")
        #endif
    }
}
