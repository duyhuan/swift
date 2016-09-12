//
//  DemoViewController.swift
//  Demo
//
//  Created by huan huan on 9/7/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var segmentdControl: UISegmentedControl!
    
    var arrItem:[Table3] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        segmentdControl.tintColor = UIColor.whiteColor()
        
        arrItem.append(Table3.init(avt: "1.png", name: "Phuong Trinh", mutual: "0 mutual friends"))
        arrItem.append(Table3.init(avt: "2.png", name: "Ngoc Trinh", mutual: "0 mutual friends"))
        arrItem.append(Table3.init(avt: "1.png", name: "Phuong Trinh", mutual: "0 mutual friends"))
        arrItem.append(Table3.init(avt: "2.png", name: "Ngoc Trinh", mutual: "0 mutual friends"))
        arrItem.append(Table3.init(avt: "1.png", name: "Phuong Trinh", mutual: "0 mutual friends"))
        arrItem.append(Table3.init(avt: "2.png", name: "Ngoc Trinh", mutual: "0 mutual friends"))
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return arrItem.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell3
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell2", forIndexPath: indexPath) as! TableViewCell3_2
            let data = arrItem[indexPath.row]
            cell.imgAvatar.image = UIImage(named: data.avatar)
            cell.imgAvatar.layer.cornerRadius = cell.imgAvatar.frame.size.width / 2
            cell.imgAvatar.clipsToBounds = true
            cell.lblName.text = data.username
            cell.lblMutualFriend.text = data.mutualFriend
            return cell
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "People You Might Know"
        } else {
            return "Friend Request"
        }
    }
}
