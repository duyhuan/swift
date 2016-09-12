//
//  Table3.swift
//  Demo
//
//  Created by huan huan on 9/7/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit

class Table3: NSObject {
    var avatar: String! = nil
    var username: String! = nil
    var mutualFriend: String! = nil
    
    override init() {
        super.init()
    }
    
    init(avt: String, name: String, mutual: String) {
        super.init()
        avatar = avt
        username = name
        mutualFriend = mutual
    }
}
