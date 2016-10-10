//
//  PatternModel.swift
//  EditImage
//
//  Created by huan huan on 10/6/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit

class PatternModel: NSObject {
    var pattern: String! = nil
    
    override init() {
        super.init()
    }
    
    init(pat: String) {
        pattern = pat
    }
}
