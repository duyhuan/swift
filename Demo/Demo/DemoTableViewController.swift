//
//  DemoTableViewController.swift
//  Demo
//
//  Created by huan huan on 8/28/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit

class DemoTableViewController: UITableViewController {
    
    var arrItem:[ItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        arrItem.append(ItemModel.init(avt: "1.png", name: "Ngoc Trinh", act: "anh tim noi nho anh tim qua khu", tm: 10, ic: "airplane-symbol.png", imgR: "danang.jpg"))
        arrItem.append(ItemModel.init(avt: "2.png", name: "Phuong Trinh", act: "nho lam ky uc anh va em", tm: 9, ic: "eight-8-ball.png", imgR: ""))
        arrItem.append(ItemModel.init(avt: "3.png", name: "Kieu Trinh", act: "tra lai anh yeu thuong ay em se bay ve noi dau", tm: 8, ic: "sailboat-symbol.png", imgR: "hochiminh.jpg"))
        arrItem.append(ItemModel.init(avt: "4.png", name: "Mat Trinh", act: "ban tay yeu duoi niu giu em o lai", tm: 7, ic: "ship-symbol.png", imgR: "nhatrang.jpg"))
        arrItem.append(ItemModel.init(avt: "5.png", name: "Con Trinh", act: "em di xa qua em di xa anh qua chac ai do cung se quay ve thoi chac ai do cung se quay lai thoi", tm: 6, ic: "speedboat-emoji.png", imgR: "yenbai.jpg"))
        arrItem.append(ItemModel.init(avt: "1.png", name: "Ngoc Trinh", act: "anh tim noi nho anh tim qua khu", tm: 5, ic: "airplane-symbol.png", imgR: "danang.jpg"))
        arrItem.append(ItemModel.init(avt: "2.png", name: "Phuong Trinh", act: "nho lam ky uc anh va em", tm: 4, ic: "eight-8-ball.png", imgR: ""))
        arrItem.append(ItemModel.init(avt: "3.png", name: "Kieu Trinh", act: "tra lai anh yeu thuong ay em se bay ve noi dau", tm: 3, ic: "sailboat-symbol.png", imgR: "hochiminh.jpg"))
        arrItem.append(ItemModel.init(avt: "4.png", name: "Mat Trinh", act: "ban tay yeu duoi niu giu em o lai", tm: 2, ic: "ship-symbol.png", imgR: "nhatrang.jpg"))
        arrItem.append(ItemModel.init(avt: "5.png", name: "Con Trinh", act: "em di xa qua em di xa anh qua chac ai do cung se quay ve thoi chac ai do cung se quay lai thoi", tm: 1, ic: "speedboat-emoji.png", imgR: ""))
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 113
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrItem.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! DemoTableViewCell
        
        let data = arrItem[indexPath.row]
        
        cell.imgAvatar.image = UIImage.init(named: data.avatar)
        cell.imgRight.image = UIImage.init(named: data.imageRight)
        cell.lblTime.text = String(data.time) + " mins ago"
        cell.imgIcon.image = UIImage.init(named: data.icon)
        
        let myAttrubute = [NSFontAttributeName: UIFont.boldSystemFontOfSize(17)]
        let myString = NSMutableAttributedString(string: data.username, attributes: myAttrubute)
        let attrString = NSAttributedString(string: " " + data.action)
        myString.appendAttributedString(attrString)
        cell.lblName.attributedText = myString
        
        if cell.imgRight.image == nil {
            cell.trailingWidthSuperView.priority = UILayoutPriorityDefaultHigh + 1
        } else {
            cell.trailingWidthSuperView.priority = UILayoutPriorityDefaultHigh
        }
        
        return cell
    }

}
