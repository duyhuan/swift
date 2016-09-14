//
//  ViewController2.swift
//  EditImage
//
//  Created by huan huan on 9/14/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit

protocol DataEnterDelegate {
    func userDidEnterInfomation(info:NSString)
}

class ViewController2: UIViewController {
    
    @IBOutlet var textField: UITextField!
    
    var delegate:DataEnterDelegate? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: btnSecon
    @IBAction func btnSecon(sender: AnyObject) {
        if (delegate != nil){
            let information:NSString = textField.text!
            delegate!.userDidEnterInfomation(information)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
