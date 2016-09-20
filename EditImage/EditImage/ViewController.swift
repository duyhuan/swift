//
//  ViewController.swift
//  EditImage
//
//  Created by huan huan on 9/13/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UITextViewDelegate {
    
    @IBOutlet var imageView: UIImageView!
    var txtv:UITextView = UITextView()
    let panGesture:UIPanGestureRecognizer = UIPanGestureRecognizer()
    let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer()
    let tapGesture1:UITapGestureRecognizer = UITapGestureRecognizer()
    @IBOutlet var collectionView: UICollectionView!
    
    let imagePicker = UIImagePickerController()
    @IBOutlet var pickerView: UIPickerView!
    
    let arrItem:[[String]] = [UIFont.familyNames(), ["blue", "red", "gray", "green", "black"]]
    let color:[UIColor] = [UIColor.blueColor(), UIColor.redColor(), UIColor.grayColor(), UIColor.greenColor(), UIColor.blackColor()]
    
    var arrImage:[ItemModel] = []
    @IBOutlet var myView: UIView!
    
    @IBAction func btn(sender: AnyObject) {
        let composeSheet = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
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
        
        txtv.delegate = self
        
        tapGesture.addTarget(self, action: #selector(ViewController.tapGesture(_:)))
        tapGesture.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tapGesture)
        
        tapGesture1.addTarget(self, action: #selector(ViewController.tapGesture1(_:)))
        imageView.addGestureRecognizer(tapGesture1)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        arrImage.append(ItemModel.init(img: "1.jpg"))
        arrImage.append(ItemModel.init(img: "2.jpg"))
        arrImage.append(ItemModel.init(img: "3.jpg"))
        arrImage.append(ItemModel.init(img: "4.jpg"))
        arrImage.append(ItemModel.init(img: "5.jpg"))

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

    @IBAction func btnSaveClicked(sender: AnyObject) {
        txtv.endEditing(false)
        UIGraphicsBeginImageContext(imageView.frame.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        //imageView.image = image
        txtv.removeFromSuperview()
    }
    
    // MARK: Tap Create txtv
    func tapGesture(sender: UITapGestureRecognizer) {
        txtv = UITextView()
        txtv.userInteractionEnabled = true
        txtv.multipleTouchEnabled = true
        txtv.delegate = self
        txtv.becomeFirstResponder()
        let point:CGPoint = sender.locationInView(imageView)
        txtv.frame =  CGRect(x: point.x, y: point.y, width: 100, height: 30)
        txtv.backgroundColor = UIColor.redColor()
        panGesture.addTarget(self, action: #selector(ViewController.panGesture(_:)))
        txtv.addGestureRecognizer(panGesture)
        imageView.addSubview(txtv)
    }
    
    func panGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(self.view)
        sender.view?.center = CGPoint(x: translation.x + (sender.view?.center.x)!, y: translation.y + (sender.view?.center.y)!)
        sender.setTranslation(CGPointZero, inView: view)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrItem[component].count
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        if component == 1 {
        
            let textColor:UIView = UIView(frame: CGRectMake(0, 0, 50, 50))
            textColor.backgroundColor = color[row]
            return textColor

        } else {
            let textFont:UILabel = UILabel(frame: CGRectMake(0, 0, 200 , 50))
            textFont.text = arrItem[0][row]
            textFont.textAlignment = NSTextAlignment.Center
            return textFont
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 1 {
            txtv.textColor = color[row]
        } else {
            txtv.font = UIFont(name: arrItem[0][row], size: 14)
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImage.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionViewCell
        let data = arrImage[indexPath.row]
        UIGraphicsBeginImageContext(self.myView.frame.size)
        UIImage(named: data.image)?.drawInRect(self.myView.bounds)
        let imageView = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        cell.myView.backgroundColor = UIColor(patternImage: imageView)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let data = arrImage[indexPath.row]
        UIGraphicsBeginImageContext(self.myView.frame.size)
        UIImage(named: data.image)?.drawInRect(self.myView.bounds)
        let imageView = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.imageView.backgroundColor = UIColor(patternImage: imageView)
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text == "" {
            textView.removeFromSuperview()
        }
    }
    
    func tapGesture1(sender: UITapGestureRecognizer) {
        txtv.endEditing(false)
    }
    
}

//extension UIImage {
//    class func imageWithLabel( image: UIImageView) -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(image.bounds.size, false, 0.0)
//        image.layer.renderInContext(UIGraphicsGetCurrentContext()!)
//        let img = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return img
//    }
//}