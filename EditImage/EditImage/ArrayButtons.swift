//
//  ArrayButton.swift
//  EditImage
//
//  Created by huan huan on 9/25/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit

class ArrayButtons: NSObject {
    var myBtnTopLeft: UIButton! = UIButton()
    var myBtnTopRight: UIButton! = UIButton()
    var myBtnBotLeft: UIButton! = UIButton()
    var myBtnBotRight: UIButton! = UIButton()
    
    override init() {
        super.init()
    }
    
    init(btnTopLeft: UIButton, btnTopRight: UIButton, btnBotLeft: UIButton, btnBotRight: UIButton) {
        super.init()
        myBtnTopLeft = btnTopLeft
        myBtnTopRight = btnTopRight
        myBtnBotLeft = btnBotLeft
        myBtnBotRight = btnBotRight
    }
}
