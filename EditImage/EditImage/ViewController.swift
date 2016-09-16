//
//  ViewController.swift
//  EditImage
//
//  Created by huan huan on 9/13/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit
//import FBSDKLoginKit
//import FBSDKCoreKit
//import FBSDKShareKit
import Social

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    let txtv:UITextView = UITextView()
    let panGesture1:UIPanGestureRecognizer = UIPanGestureRecognizer()
    let pinchGesture:UIPinchGestureRecognizer = UIPinchGestureRecognizer()
    
    let imagePicker = UIImagePickerController()
    
    @IBAction func btn(sender: AnyObject) {
        let composeSheet = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        composeSheet.setInitialText("Hello, Facebook!")
        composeSheet.addImage(imageView.image)
        
        presentViewController(composeSheet, animated: true, completion: nil)
    }
    
    @IBAction func loadImageButtonTapped(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        panGesture1.addTarget(self, action: #selector(ViewController.panGesture(_:)))
        txtv.addGestureRecognizer(panGesture1)
        
        pinchGesture.addTarget(self, action: #selector(ViewController.pinchGesture(_:)))
        txtv.addGestureRecognizer(pinchGesture)
    }
    
    func pinchGesture(sender: UIPinchGestureRecognizer) {
        txtv.transform = CGAffineTransformMakeScale(sender.scale, sender.scale)

    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func userDidEnterInfomation(info: NSString) {
        label.text = info as String
    }

    @IBAction func btnSaveClicked(sender: AnyObject) {
        UIGraphicsBeginImageContext(imageView.frame.size)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        imageView.image = image
        txtv.removeFromSuperview()
    }
    
    func panGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(self.view)
        sender.view?.center = CGPoint(x: translation.x + (sender.view?.center.x)!, y: translation.y + (sender.view?.center.y)!)
        sender.setTranslation(CGPointZero, inView: view)
    }
    
    @IBAction func tapGesture(sender: UITapGestureRecognizer) {
        let point:CGPoint = sender.locationInView(imageView)
        txtv.frame =  CGRect(x: point.x, y: point.y, width: 50, height: 30)
        txtv.backgroundColor = UIColor.clearColor()
        imageView.addSubview(txtv)
    }
    
}