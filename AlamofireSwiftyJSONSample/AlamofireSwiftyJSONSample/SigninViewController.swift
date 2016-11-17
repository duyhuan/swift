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

class SigninViewController: UIViewController {

    @IBOutlet var sView: UIView!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var lblSignup: UILabel!
    var json: JSON = nil
    var error: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLogin.layer.cornerRadius = 5
        lblSignup.isUserInteractionEnabled = true
        
        customLabel()
    }
    
    func alert(title1: String, title2: String, message: String) {
        let alert = UIAlertController(title: title1, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: title2, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func btnLoginClicked(_ sender: UIButton) {
        let parameters: Parameters = [
            "email" : self.email.text ?? "",
            "password" : self.password.text ?? ""
        ]
        Alamofire.request(Router.login(parameters: parameters)).responseJSON { (response) in
            guard let data = response.result.value else{
                self.lblSignup.text = "Request failed"
                return
            }
            self.json = JSON(data)
            self.error = String(describing: self.json["error"])
            if self.json["error"] == nil {
                self.alert(title1: "", title2: "OK", message: "Sign In success")
            } else {
                self.alert(title1: "", title2: "OK", message: self.error!)
            }
        }
    }
    
    func customLabel(){
        let str = "Don't have an account? #<li>Sign up#"
        let strPieces = str.components(separatedBy: "#")
        var ptWordLocation = CGPoint(x: 0.0, y: 0.0)
        if (strPieces.count > 1) {
            //Loop the parts of the string
            for s in strPieces{
                //Check for empty string
                if (s.isEmpty == false) {
                    let lbl = UILabel()
                    lbl.textColor = UIColor(colorLiteralRed: 111/255, green: 126/255, blue: 148/255, alpha: 1)
                    lbl.isUserInteractionEnabled = s.contains("<li>")
                    lbl.text = s.replacingOccurrences(of: "<li>", with: "")
                    if (s.contains("<li>")) {
                        lbl.textColor = UIColor.white
                        //Set tap gesture for this clickable text:
                        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(SigninViewController.tapOn(_:)))
                        gesture.minimumPressDuration = 0.001
                        lbl.addGestureRecognizer(gesture)
                    }
                    lbl.sizeToFit()
                    
                    //Lay out the labels so it forms a complete sentence again
                    if (self.view.frame.width < ptWordLocation.x + lbl.bounds.size.width) {
                        ptWordLocation.x = 0.0
                        ptWordLocation.y += lbl.frame.size.height;
                        lbl.text = lbl.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    }
                    lbl.frame = CGRect(x: ptWordLocation.x, y: ptWordLocation.y, width: lbl.frame.size.width, height: lbl.frame.size.height)
                    self.lblSignup.addSubview(lbl)
                    //Update the horizontal width
                    ptWordLocation.x += lbl.frame.size.width
                }
            }
        }
    }
    
    func tapOn(_ recognizer : UILongPressGestureRecognizer){
        if let label = recognizer.view as? UILabel {
            if recognizer.state == .began {
                label.textColor = UIColor.lightGray
                let signupVC = storyboard?.instantiateViewController(withIdentifier: "SignupVC")
                present(signupVC!, animated: true, completion: nil)
            }
            if recognizer.state == .ended {
                label.textColor = UIColor.white
            }
        }
    }
}

