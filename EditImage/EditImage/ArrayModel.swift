//
//  Array.swift
//  EditImage
//
//  Created by huan huan on 9/23/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit

class ArrayModel: NSObject {
    var textView: UITextView! = UITextView()
    var label: UILabel! = UILabel()
    override init() {
        super.init()
    }
    init(txtv: UITextView, lbl: UILabel) {
        super.init()
        textView = txtv
        label = lbl
    }
}
