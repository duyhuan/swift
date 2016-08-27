//
//  DemoTableViewCell.swift
//  DemoTableView
//
//  Created by huan huan on 8/27/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit

class DemoTableViewCell: UITableViewCell {
    
    @IBOutlet var imgAvatar: UIImageView!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var imgIcon: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblTime: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgAvatar.layer.cornerRadius = imgAvatar.frame.size.width / 2
        imgAvatar.clipsToBounds = true
        
        imgView.layer.cornerRadius = 10
        imgView.clipsToBounds = true
        
        lblTime.alpha = 0.2
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
