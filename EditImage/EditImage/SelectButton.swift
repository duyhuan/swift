//
//  SetButton.swift
//  EditImage
//
//  Created by huan huan on 10/11/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit

class SelectButton: UIButton {
    
    var selectedBackground: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    init() {
        super.init(frame: CGRectZero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        selectedBackground.image = UIImage(named: "CP_Deselect")
        selectedBackground.contentMode = .ScaleAspectFit
        selectedBackground.translatesAutoresizingMaskIntoConstraints = false
        self.userInteractionEnabled = false
        addSubview(selectedBackground)
        
        addConstraint(NSLayoutConstraint(item: selectedBackground, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: selectedBackground, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: selectedBackground, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: selectedBackground, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0.0))
        layoutIfNeeded()
    }
    
    func setChosen(isSelected: Bool) {
        if isSelected {
            selectedBackground.image = UIImage.init(named: "CP_Selected")
        } else {
            selectedBackground.image = UIImage.init(named: "CP_Deselect")
        }
    }
}
