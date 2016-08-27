//
//  ViewController.swift
//  DemoTableView
//
//  Created by huan huan on 8/27/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var arrImgAvatar:[String] = []
    var arrImgView:[String] = []
    var arrName:[String] = []
    var arrIcon:[String] = []
    var arrTime:[Int] = []
    var arrAction:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        
        arrImgAvatar = ["1.png", "2.png", "3.png", "4.png", "5.png"]
        arrImgView = ["danang.jpg", "hanoi.jpg", "hochiminh.jpg", "nhatrang.jpg", "yenbai.jpg"]
        arrName = ["Ngoc Trinh", "Phuong Trinh", "Kieu Trinh", "Yen Trinh", "Hai Trinh"]
        arrIcon = ["airplane-symbol", "eight-8-ball", "sailboat-symbol", "ship-symbol", "speedboat-emoji"]
        arrTime = [10, 9, 8, 7, 6, 5, 4, 3, 3, 2, 1]
        arrAction = ["di choi lung tung ngoai duong", "di bat pokemon go", "di choi ngoai cong vien ngam gai va choi gai", "chuan bi di ngu", "ahihi do cho"]
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
        cell.imgView.image = UIImage(named: arrImgView[indexPath.row])
        cell.lblName.text = arrName[indexPath.row] + " " + arrAction[indexPath.row]
        cell.imgIcon.image = UIImage(named: arrIcon[indexPath.row])
        cell.lblTime.text = String(arrTime[indexPath.row]) + " mins ago"
        return cell
    }

}

