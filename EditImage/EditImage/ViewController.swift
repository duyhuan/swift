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
    
    var arrImage:[ItemModel] = []
    
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var pickerView: UIPickerView!
    
    @IBOutlet var myView: UIView!
    
    @IBOutlet var btnChooseImage: UIButton!
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var btnShare: UIButton!
    
    var txtv:UITextView = UITextView()
    var arrTxtv:[UITextView] = []
    
    let panGesture:UIPanGestureRecognizer = UIPanGestureRecognizer()
    let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer()
    let tapGesture1:UITapGestureRecognizer = UITapGestureRecognizer()

    let imagePicker = UIImagePickerController()
    
    let color:[UIColor] = [UIColor.blueColor(), UIColor.redColor(), UIColor.grayColor(), UIColor.greenColor(), UIColor.blackColor()]
    let arrItem:[[String]] = [UIFont.familyNames(), ["blue", "red", "gray", "green", "black"]]
    
    // MARK: Button Share
    @IBAction func btnShare(sender: AnyObject) {
        let composeSheet = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        composeSheet.addImage(imageView.image)
        
        presentViewController(composeSheet, animated: true, completion: nil)
    }
    
    // MARK: Button Choose Image
    @IBAction func loadImageButtonTapped(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: Aligment TextView
    
    @IBOutlet var aligment: UISegmentedControl!
    
    @IBAction func alignment(sender: UISegmentedControl) {
        switch aligment.selectedSegmentIndex {
        case 0:
            for i in 0..<arrTxtv.count {
                if arrTxtv[i].tag == 1 {
                    arrTxtv[i].textAlignment = NSTextAlignment.Left
                }
            }
        case 1:
            for i in 0..<arrTxtv.count {
                if arrTxtv[i].tag == 1 {
                    arrTxtv[i].textAlignment = NSTextAlignment.Center
                }
            }
        case 2:
            for i in 0..<arrTxtv.count {
                if arrTxtv[i].tag == 1 {
                    arrTxtv[i].textAlignment = NSTextAlignment.Right
                }
            }
        default:
            print("a")
        }
    }
    
    // MARK: Set TextView Font Size
    @IBOutlet var lbl: UILabel!
    @IBOutlet var slider: UISlider!
    @IBAction func change(sender: UISlider) {
        lbl.text = String(Int(slider.value))
        for i in 0..<arrTxtv.count {
            if arrTxtv[i].tag == 1  {
                arrTxtv[i].font = arrTxtv[i].font!.fontWithSize(CGFloat(slider.value))
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        tapGesture.addTarget(self, action: #selector(ViewController.tapGesture(_:)))
        tapGesture.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tapGesture)
        
        tapGesture1.addTarget(self, action: #selector(ViewController.tapGesture1(_:)))
        imageView.addGestureRecognizer(tapGesture1)
        
        panGesture.addTarget(self, action: #selector(ViewController.panGesture(_:)))
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        arrImage.append(ItemModel.init(img: "1.jpg"))
        arrImage.append(ItemModel.init(img: "2.jpg"))
        arrImage.append(ItemModel.init(img: "3.jpg"))
        arrImage.append(ItemModel.init(img: "4.jpg"))
        arrImage.append(ItemModel.init(img: "5.jpg"))

        btnChooseImage.layer.cornerRadius = 5
        btnSave.layer.cornerRadius = 5
        btnShare.layer.cornerRadius = 5
        
        slider.minimumValue = 1
        slider.maximumValue = 100
        slider.value = 1
        lbl.text = "1"
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

    // MARK: Button Save
    @IBAction func btnSaveClicked(sender: AnyObject) {
        txtv.endEditing(false)
        UIGraphicsBeginImageContext(imageView.frame.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        imageView.image = image
        for i in 0..<arrTxtv.count {
            arrTxtv[i].removeFromSuperview()
        }
    }
    
    // MARK: Tap Create txtv
    func tapGesture(sender: UITapGestureRecognizer) {
        let point:CGPoint = sender.locationInView(imageView)
        txtv = UITextView()
        txtv.backgroundColor = UIColor.redColor()
        txtv.userInteractionEnabled = true
        txtv.delegate = self
        txtv.frame =  CGRect(x: point.x, y: point.y, width: 100, height: 30)
        txtv.becomeFirstResponder()
        arrTxtv.append(txtv)
        imageView.addSubview(txtv)
    }
    
    // MARK: PanGesture
    func panGesture(sender: UIPanGestureRecognizer) {
        
        let location = sender.locationInView(imageView)
        let someRect = imageView.bounds
        if (CGRectContainsPoint(someRect, location)) {
            let translation = sender.translationInView(self.imageView)
            sender.view?.center = CGPoint(x: translation.x + (sender.view?.center.x)!, y: translation.y + (sender.view?.center.y)!)
            sender.setTranslation(CGPointZero, inView: imageView)
        }
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        for i in 0..<arrTxtv.count {
            arrTxtv[i].tag = 0
            if textView == arrTxtv[i] {
                arrTxtv[i].tag = 1
                arrTxtv[i].addGestureRecognizer(panGesture)
            }
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        for i in (0..<arrTxtv.count).reverse(){
            if textView == arrTxtv[i] && textView.text == "" {
                arrTxtv[i].removeFromSuperview()
                arrTxtv.removeAtIndex(i)
            }
        }
    }
    
    // MARK: PickerView
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
            for i in 0..<arrTxtv.count {
                if arrTxtv[i].tag == 1 {
                    arrTxtv[i].textColor = color[row]
                }
            }
        } else {
            for i in 0..<arrTxtv.count {
                if arrTxtv[i].tag == 1 {
                    arrTxtv[i].font = UIFont(name: arrItem[0][row], size: 14)
                }
            }
        }
    }
    
    // MARK: CollectionView
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
    
    // MARK: Func tapGesture1
    func tapGesture1(sender: UITapGestureRecognizer) {
        for i in 0..<arrTxtv.count {
            arrTxtv[i].endEditing(false)
        }
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