//
//  ItemModel.swift
//  EditImage
//
//  Created by huan huan on 9/19/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit

class ItemModel: NSObject {
    
    var image: String! = nil

    override init() {
        super.init()
    }
    
    init(img: String) {
        super.init()
        image = img
    }
    
}
