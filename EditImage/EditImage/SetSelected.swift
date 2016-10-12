//
//  SetButton.swift
//  EditImage
//
//  Created by huan huan on 10/11/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit

class SetSelected: NSObject {
    
    var selectedBackground: UIImageView! = nil
    var btnTemporary: UIButton! = nil
    
    override init() {
        super.init()
    }
    
    init(selectedBg: UIImageView, btnTemp: UIButton) {
        selectedBackground = selectedBg
        btnTemporary = btnTemp
        selectedBackground.image = UIImage(named: "CP_Selected")
        selectedBackground.contentMode = .ScaleAspectFit
        selectedBackground.frame = btnTemporary.frame
        btnTemp.alpha = 1
    }
}
