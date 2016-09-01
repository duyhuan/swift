//
//  DemoTableViewCell.swift
//  DemoTableView2
//
//  Created by huan huan on 8/31/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit

class DemoTableViewCell: UITableViewCell {
    
    @IBOutlet var imgAvatar: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var imgIcon: UIImageView!
    @IBOutlet var lblText: UILabel!
    @IBOutlet var imgImage: UIImageView!
    @IBOutlet var lblLike: UILabel!
    @IBOutlet var lblConversation: UILabel!
    @IBOutlet var lblShare: UILabel!
    @IBOutlet var lblTextBottomWithProtocol: NSLayoutConstraint!
    @IBOutlet var lblTextBottomWithImgImage: NSLayoutConstraint!
    @IBOutlet var imgImageTopWithImgAvatar: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //bo tron avatar
        imgAvatar.layer.cornerRadius = imgAvatar.frame.width / 2
        imgAvatar.clipsToBounds = true
        
        //lam mo
        lblTime.alpha = 0.2
        imgIcon.alpha = 0.2
        lblLike.alpha = 0.2
        lblConversation.alpha = 0.2
        lblShare.alpha = 0.2

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
