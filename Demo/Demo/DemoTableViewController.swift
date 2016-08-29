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
        arrItem.append(ItemModel.init(avt: "2.png", name: "Phuong Trinh", act: "nho lam ky uc anh va em", tm: 9, ic: "eight-8-ball.png", imgR: "hanoi.jpg"))
        arrItem.append(ItemModel.init(avt: "3.png", name: "Kieu Trinh", act: "tra lai anh yeu thuong ay em se bay ve noi dau", tm: 8, ic: "sailboat-symbol.png", imgR: "hochiminh.jpg"))
        arrItem.append(ItemModel.init(avt: "4.png", name: "Mat Trinh", act: "ban tay yeu duoi niu giu em o lai", tm: 7, ic: "ship-symbol.png", imgR: "nhatrang.jpg"))
        arrItem.append(ItemModel.init(avt: "5.png", name: "Con Trinh", act: "em di xa qua em di xa anh qua chac ai do cung se quay ve thoi chac ai do cung se quay lai thoi", tm: 6, ic: "speedboat-emoji.png", imgR: "yenbai.jpg"))
        arrItem.append(ItemModel.init(avt: "1.png", name: "Ngoc Trinh", act: "anh tim noi nho anh tim qua khu", tm: 10, ic: "airplane-symbol.png", imgR: "danang.jpg"))
        arrItem.append(ItemModel.init(avt: "2.png", name: "Phuong Trinh", act: "nho lam ky uc anh va em", tm: 9, ic: "eight-8-ball.png", imgR: "hanoi.jpg"))
        arrItem.append(ItemModel.init(avt: "3.png", name: "Kieu Trinh", act: "tra lai anh yeu thuong ay em se bay ve noi dau", tm: 8, ic: "sailboat-symbol.png", imgR: "hochiminh.jpg"))
        arrItem.append(ItemModel.init(avt: "4.png", name: "Mat Trinh", act: "ban tay yeu duoi niu giu em o lai", tm: 7, ic: "ship-symbol.png", imgR: "nhatrang.jpg"))
        arrItem.append(ItemModel.init(avt: "5.png", name: "Con Trinh", act: "em di xa qua em di xa anh qua chac ai do cung se quay ve thoi chac ai do cung se quay lai thoi", tm: 6, ic: "speedboat-emoji.png", imgR: "yenbai.jpg"))
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
        cell.lblName.text = data.username + " " + data.action
        cell.imgRight.image = UIImage.init(named: data.imageRight)
        cell.lblTime.text = String(data.time) + " mins ago"
        cell.imgIcon.image = UIImage.init(named: data.icon)
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
