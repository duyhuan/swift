//
//  TableViewCell3_2.swift
//  Demo
//
//  Created by huan huan on 9/8/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit

class TableViewCell3_2: UITableViewCell {
    
    @IBOutlet var imgAvatar: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblMutualFriend: UILabel!
    @IBOutlet var btnAccept: UIButton!
    @IBOutlet var btnIgnore: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnAccept.layer.cornerRadius = 5
        btnIgnore.layer.cornerRadius = 5
        btnIgnore.layer.borderColor = UIColor.grayColor().CGColor
        btnIgnore.layer.borderWidth = 1
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
