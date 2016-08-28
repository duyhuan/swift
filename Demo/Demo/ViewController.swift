//
//  ViewController.swift
//  Demo
//
//  Created by huan huan on 8/27/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var arrImgAvatar:[String] = []
    var arrImgView:[String] = []
    var arrImgIcon:[String] = []
    var arrLblName:[String] = []
    var arrLblTime:[Int] = []
    var arrAction:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        arrImgAvatar = ["1.png" , "2.png", "3.png", "4.png", "5.png", "1.png" , "2.png", "3.png", "4.png", "5.png"]
        arrImgView = ["danang.jpg", "hanoi.jpg", "hochiminh.jpg", "nhatrang.jpg", "yenbai.jpg", "danang.jpg", "hanoi.jpg", "hochiminh.jpg", "nhatrang.jpg", "yenbai.jpg"]
        arrImgIcon = ["airplane-symbol.png", "eight-8-ball.png", "sailboat-symbol.png", "ship-symbol.png", "speedboat-emoji.png", "airplane-symbol.png", "eight-8-ball.png", "sailboat-symbol.png", "ship-symbol.png", "speedboat-emoji.png"]
        arrLblName = ["Ngoc Trinh", "Phuong Trinh", "Kieu Trinh", "Hap Trinh", "Thinh Trinh", "Ngoc Trinh", "Phuong Trinh", "Kieu Trinh", "Hap Trinh", "Thinh Trinh"]
        arrLblTime = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
        arrAction = ["vua di xem da bong ve", "thich mot anh ma ban vua dang", "vua dang nhap vao facebook", "dang di bat pokemon go", "ahihi do cho lam sao de no dai ra bay gio", "vua di xem da bong ve", "thich mot anh ma ban vua dang", "vua dang nhap vao facebook", "dang di bat pokemon go", "ahihi do cho lam sao de no dai ra bay gio ahihi do cho lam sao de no dai ra bay gio ahihi do cho lam sao de no dai ra bay gio ahihi do cho lam sao de no dai ra bay gio"]
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 153
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrImgAvatar.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! DemoTableViewCell
        cell.imgAvatar.image = UIImage(named: arrImgAvatar[indexPath.row])
        cell.imgRight.image = UIImage(named: arrImgView[indexPath.row])
        cell.imgIcon.image = UIImage(named: arrImgIcon[indexPath.row])
        cell.lblName.text = arrLblName[indexPath.row] + " " + arrAction[indexPath.row]
        cell.lblTime.text = String(arrLblTime[indexPath.row]) + " mins ago"
        return cell
    }

}

