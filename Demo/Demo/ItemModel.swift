//
//  ItemModel.swift
//  Demo
//
//  Created by huan huan on 8/28/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit

class ItemModel: NSObject {
    var avatar: String! = nil
    var username: String! = nil
    var action: String! = nil
    var time: Int! = nil
    var icon: String! = nil
    var imageRight: String! = nil
    
    override init() {
        super.init()
    }
    
    init(avt: String, name: String, act: String, tm: Int, ic: String, imgR: String) {
        super.init()
        avatar = avt
        username = name
        action = act
        time = tm
        icon = ic
        imageRight = imgR
    }
}
