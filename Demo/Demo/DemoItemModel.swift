//
//  ItemModel.swift
//  DemoTableView2
//
//  Created by huan huan on 8/31/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit

class DemoItemModel: NSObject {
    var avatar: String! = nil
    var name: String! = nil
    var time: String! = nil
    var icon: String! = nil
    var text: String! = nil
    var image: String! = nil
    var numberOfLike: String! = nil
    
    override init() {
        super.init()
    }
    
    init(avt: String, nm: String, tm: String, ic: String, tx: String, img: String, like: String) {
        avatar = avt
        name = nm
        time = tm
        icon = ic
        text = tx
        image = img
        numberOfLike = like
    }
}

