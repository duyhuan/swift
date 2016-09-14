//
//  ViewController.swift
//  DemoTableView2
//
//  Created by   huan on 8/31/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    @IBOutlet var txtvText: UITextView!
    @IBOutlet var myAvatar: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var imgCamera: UIImageView!
    let placeHolderLabel = UILabel()
    
    var arrItem: [DemoItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        txtvText.delegate = self
        
        //
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        // bo tron myAvatar
        myAvatar.image = UIImage(named: "1.png")
        myAvatar.layer.cornerRadius = myAvatar.frame.height / 2
        myAvatar.clipsToBounds = true
        
        //
        imgCamera.image = UIImage(named: "camera.png")
        
        arrItem.append(DemoItemModel.init(avt: "1.png", nm: "Phuong Trinh", tm: "10 hours ago", ic: "location.png", tx: "", img: "danang.jpg", like: "Like"))
        arrItem.append(DemoItemModel.init(avt: "2.png", nm: "Ngoc Trinh", tm: "9 hours ago", ic: "location.png", tx: "Co biet chang noi day anh van dung doi Co biet chang noi day anh van dung doi Co biet chang noi day anh van dung doi Co biet chang noi day anh van dung doi", img: "", like: "2 Likes"))
        arrItem.append(DemoItemModel.init(avt: "3.png", nm: "Kieu Trinh", tm: "8 hours ago", ic: "location.png", tx: "", img: "hochiminh.jpg", like: "2 Likes"))
        arrItem.append(DemoItemModel.init(avt: "4.png", nm: "Con Trinh", tm: "7 hours ago", ic: "location.png", tx: "Cam bong hoa tren tay nuoc mat roi", img: "", like: "2 Likes"))
        arrItem.append(DemoItemModel.init(avt: "5.png", nm: "Mat Trinh", tm: "6 hours ago", ic: "location.png", tx: "Anh nho em", img: "yenbai.jpg", like: "2 Likes"))
        arrItem.append(DemoItemModel.init(avt: "1.png", nm: "Phuong Trinh", tm: "10 hours ago", ic: "location.png", tx: "", img: "danang.jpg", like: "2 Likes"))
        arrItem.append(DemoItemModel.init(avt: "2.png", nm: "Ngoc Trinh", tm: "9 hours ago", ic: "location.png", tx: "Co biet chang noi day anh van dung doi", img: "", like: "2 Likes"))
        arrItem.append(DemoItemModel.init(avt: "3.png", nm: "Kieu Trinh", tm: "8 hours ago", ic: "location.png", tx: "", img: "hochiminh.jpg", like: "2 Likes"))
        arrItem.append(DemoItemModel.init(avt: "4.png", nm: "Con Trinh", tm: "7 hours ago", ic: "location.png", tx: "Cam bong hoa tren tay nuoc mat roi", img: "", like: "2 Likes"))
        arrItem.append(DemoItemModel.init(avt: "5.png", nm: "Mat Trinh", tm: "6 hours ago", ic: "location.png", tx: "Anh nho em", img: "1.png", like: "2 Likes"))
        
        // Set label placeHolder for txtvText
        let placeHolderLabelX: CGFloat = 5
        let placeHolderLabelY: CGFloat = 0
        let placeHolderLabelWidth = txtvText.bounds.width - placeHolderLabelX
        let placeHolderLabelHeight = txtvText.bounds.height - placeHolderLabelY
        let placeHolderLabelFontSize = self.view.frame.size.width/25
        placeHolderLabel.frame = CGRectMake(placeHolderLabelX, placeHolderLabelY, placeHolderLabelWidth, placeHolderLabelHeight)
        placeHolderLabel.text = "What do you fancy or think?"
        placeHolderLabel.font = UIFont(name: "HelveticaNeue", size: placeHolderLabelFontSize)
        placeHolderLabel.textColor = UIColor.lightGrayColor()
        placeHolderLabel.adjustsFontSizeToFitWidth = true
        txtvText.addSubview(placeHolderLabel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrItem.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! Demo1TableViewCell
        
        let data = arrItem[indexPath.row]
        
        cell.imgAvatar.image = UIImage(named: data.avatar)
        cell.lblName.text = data.name
        cell.lblTime.text = data.time
        cell.imgIcon.image = UIImage(named: data.icon)
        cell.lblText.text = data.text
        cell.imgImage.image = UIImage(named: data.image)
        cell.lblLike.text = data.numberOfLike
        
        // set lblName bold
        let myAttrubute = [NSFontAttributeName: UIFont.boldSystemFontOfSize(16)]
        let myString = NSMutableAttributedString(string: data.name, attributes: myAttrubute)
        cell.lblName.attributedText = myString
        
        // set constraint lblText voi protocol.png khi co hoac khong co imgImage
        if cell.imgImage.image == nil && cell.lblText.text != nil {
            cell.lblTextBottomWithImgImage.active = false
            cell.imgImageTopWithImgAvatar.active = false
            cell.lblTextBottomWithImgConversation.active = true
        } else if cell.imgImage.image != nil && cell.lblText.text == nil {
            cell.lblTextBottomWithImgConversation.active = false
            cell.lblTextBottomWithImgImage.active = false
            cell.imgImageTopWithImgAvatar.active = true
        } else if cell.imgImage.image != nil && cell.lblText.text != nil {
            cell.imgImageTopWithImgAvatar.active = false
            cell.lblTextBottomWithImgConversation.active = false
            cell.lblTextBottomWithImgImage.active = true
        }
        
        return cell
    }
    
    // Ham set placeHolderLabel an hien khi type text
    func textViewDidChange(textView: UITextView) {
        let spacing = NSCharacterSet.whitespaceAndNewlineCharacterSet()
        if !txtvText.text.stringByTrimmingCharactersInSet(spacing).isEmpty {
            placeHolderLabel.hidden = true
        } else {
            placeHolderLabel.hidden = false
        }
    }
    
}


