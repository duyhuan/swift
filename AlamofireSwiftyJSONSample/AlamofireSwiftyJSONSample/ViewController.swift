//
//  ViewController.swift
//  AlamofireSwiftyJSONSample
//
//  Created by huan huan on 11/15/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet var sView: UIView!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLogin.layer.cornerRadius = 5
    }

    @IBAction func btnLoginClicked(_ sender: UIButton) {
        let parameters: Parameters = [
            "email" : self.email.text ?? "",
            "password" : self.password.text ?? ""
        ]
        
        Alamofire.request("http://api-dev.sab247.com/v2/account/login", method: .post, parameters: parameters).responseJSON { (response) in
            
            guard let data = response.result.value else {
                return
            }
            print(data)
        }
    }
    
}

