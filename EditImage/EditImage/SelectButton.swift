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
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        selectedBackground.image = UIImage(named: "CP_Deselect")
        selectedBackground.contentMode = .scaleAspectFit
        selectedBackground.translatesAutoresizingMaskIntoConstraints = false
        selectedBackground.alpha = 0.5
        self.isUserInteractionEnabled = false
        addSubview(selectedBackground)
        
        addConstraint(NSLayoutConstraint(item: selectedBackground, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: selectedBackground, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: selectedBackground, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: selectedBackground, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0))
        layoutIfNeeded()
    }
    
    func setChosen(_ isSelected: Bool) {
        if isSelected {
            selectedBackground.image = UIImage.init(named: "CP_Selected")
            selectedBackground.alpha = 1.0
        } else {
            selectedBackground.image = UIImage.init(named: "CP_Deselect")
            selectedBackground.alpha = 0.5
        }
    }
}
