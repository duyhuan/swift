//
//  ItemModel.swift
//  EditImage
//
//  Created by huan huan on 10/6/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit

class ItemModel: NSObject {
    var items: String! = nil
    
    override init() {
        super.init()
    }
    
    init(item: String) {
        items = item
    }
}
