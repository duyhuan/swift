//
//  TermsViewController.swift
//  AlamofireSwiftyJSONSample
//
//  Created by huan huan on 11/17/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = Bundle.main.url(forResource: "terms", withExtension: "html")
        let request = NSURLRequest(url: url!)
        webView.loadRequest(request as URLRequest)
    }

}
