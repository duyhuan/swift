//
//  TableViewCell3.swift
//  Demo
//
//  Created by huan huan on 9/7/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit

class TableViewCell3: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collecView: UICollectionView!
    var arrItem:[Table3] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collecView.delegate = self
        collecView.dataSource = self
        
        arrItem.append(Table3.init(avt: "1.png", name: "Phuong Trinh", mutual: "0 mutual friends"))
        arrItem.append(Table3.init(avt: "2.png", name: "Ngoc Trinh", mutual: "0 mutual friends"))
        arrItem.append(Table3.init(avt: "1.png", name: "Phuong Trinh", mutual: "0 mutual friends"))
        arrItem.append(Table3.init(avt: "2.png", name: "Ngoc Trinh", mutual: "0 mutual friends"))
        arrItem.append(Table3.init(avt: "1.png", name: "Phuong Trinh", mutual: "0 mutual friends"))
        arrItem.append(Table3.init(avt: "2.png", name: "Ngoc Trinh", mutual: "0 mutual friends"))
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrItem.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionViewCell3
        let data = arrItem[indexPath.row]
        cell.imgAvatar.image = UIImage(named: data.avatar)
        cell.imgAvatar.layer.cornerRadius = cell.imgAvatar.frame.size.width / 2
        cell.imgAvatar.clipsToBounds = true
        cell.lblName.text = data.username
        cell.lblMunutalFriend.text = data.mutualFriend
        cell.btnAdd.setTitle("+ Add", forState: .Normal)
        cell.btnAdd.layer.cornerRadius = 5
//        cell.contentView.frame = cell.bounds
//        cell.contentView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        return cell
    }

}
