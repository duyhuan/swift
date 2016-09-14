//
//  ViewController.swift
//  EditImage
//
//  Created by huan huan on 9/13/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, DataEnterDelegate {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    
    let imagePicker = UIImagePickerController()
    
    
    @IBAction func loadImageButtonTapped(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    
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
    
    //truyen bien thong qua segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSecondVC" {
            let secondVC:ViewController2 = segue.destinationViewController as! ViewController2
            secondVC.delegate = self
        }
    }

    @IBAction func btnSaveClicked(sender: AnyObject) {
        UIGraphicsBeginImageContext(imageView.frame.size)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    
    
    
    
}