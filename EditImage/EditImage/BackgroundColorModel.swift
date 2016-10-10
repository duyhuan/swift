//
//  BackgroundColorModel.swift
//  EditImage
//
//  Created by huan huan on 10/6/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit

class BackgroundColorModel: NSObject {
    var bgroundColor: UIColor! = nil
    
    override init() {
        super.init()
    }
    
    init(bgColor: UIColor) {
        bgroundColor = bgColor
    }
}
