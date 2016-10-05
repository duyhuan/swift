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
    
    var arrImage: [ItemModel] = []
    var arrTxtvLbl: [ArrayModel] = []
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var myView: UIView!
    @IBOutlet var btnChooseImage: UIButton!
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var btnShare: UIButton!
    
    var txtv:UITextView = UITextView()
    var label:UILabel = UILabel()
    
    let tapOnImageToCreateTextViewAndLabel: UITapGestureRecognizer = UITapGestureRecognizer()
    let panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer()
    let tapOnLabelToEdit: UITapGestureRecognizer = UITapGestureRecognizer()

    let imagePicker = UIImagePickerController()
    
    let color:[UIColor] = [UIColor.blueColor(), UIColor.redColor(), UIColor.grayColor(), UIColor.greenColor(), UIColor.blackColor()]
    let arrItem:[[String]] = [UIFont.familyNames(), ["blue", "red", "gray", "green", "black"]]
    
    // Declare Button, PanGesTure
    let myBtnTopLeft: UIButton = UIButton()
    let myBtnTopRight: UIButton = UIButton()
    let myBtnBotLeft: UIButton = UIButton()
    let myBtnBotRight: UIButton = UIButton()
    
    let panBtnTopLeftGesture: UIPanGestureRecognizer = UIPanGestureRecognizer()
    let panBtnTopRightGesture: UIPanGestureRecognizer = UIPanGestureRecognizer()
    let panBtnBotLeftGesture: UIPanGestureRecognizer = UIPanGestureRecognizer()
    let panBtnBotRightGesture: UIPanGestureRecognizer = UIPanGestureRecognizer()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        tapOnImageToCreateTextViewAndLabel.addTarget(self, action: #selector(ViewController.tapOnImageToCreateTextViewAndLabel(_:)))
        tapOnImageToCreateTextViewAndLabel.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tapOnImageToCreateTextViewAndLabel)
        
        panGesture.addTarget(self, action: #selector(ViewController.panGesture(_:)))
        
        tapOnLabelToEdit.addTarget(self, action: #selector(ViewController.tapOnLabelToEdit(_:)))
        imageView.addGestureRecognizer(tapOnLabelToEdit)
        
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
        lbl.text = "17"
    }
    
    // MARK: Tap Create txtv
    func tapOnImageToCreateTextViewAndLabel(sender: UITapGestureRecognizer) {
        let point:CGPoint = sender.locationInView(imageView)
        txtv = UITextView()
        label = UILabel()
        
        txtv.scrollEnabled = false
        txtv.backgroundColor = UIColor.redColor()
        txtv.userInteractionEnabled = true
        txtv.delegate = self
        txtv.frame =  CGRect(x: point.x, y: point.y, width: 100, height: 21)
        txtv.becomeFirstResponder()
        txtv.font = txtv.font?.fontWithSize(17)
        
        label.userInteractionEnabled = true
        label.multipleTouchEnabled = true
        label.frame =  CGRect(x: point.x, y: point.y, width: 100, height: 21)
        label.hidden = true
        label.layer.borderColor = UIColor.whiteColor().CGColor
        label.numberOfLines = 0
        label.lineBreakMode = .ByWordWrapping
        label.font = UIFont(name: "Arial", size: 17)
        label.textAlignment = .Left
        label.minimumScaleFactor = 1
        
        arrTxtvLbl.append(ArrayModel.init(txtv: txtv, lbl: label))
        
        imageView.addSubview(txtv)
        imageView.addSubview(label)
        
        for i in (0..<arrTxtvLbl.count).reverse() {
            if point.x >= arrTxtvLbl[i].label.frame.origin.x && point.x <= arrTxtvLbl[i].label.frame.origin.x + arrTxtvLbl[i].label.frame.size.width && point.y >= arrTxtvLbl[i].label.frame.origin.y && point.y <= arrTxtvLbl[i].label.frame.origin.y + arrTxtvLbl[i].label.frame.size.height {
                arrTxtvLbl[i].label.hidden = true
                arrTxtvLbl[i].label.addGestureRecognizer(panGesture)
                arrTxtvLbl[i].textView.frame.origin = arrTxtvLbl[i].label.frame.origin
                arrTxtvLbl[i].textView.hidden = false
                arrTxtvLbl[i].textView.becomeFirstResponder()
                arrTxtvLbl[i].textView.font = arrTxtvLbl[i].label.font
                myBtnTopLeft.hidden = true
                myBtnTopRight.hidden = true
                myBtnBotLeft.hidden = true
                myBtnBotRight.hidden = true
            }
        }
    }
    
    
    //MARK: Tao On Label To Edit Text
    func tapOnLabelToEdit(sender: UITapGestureRecognizer) {
        let point:CGPoint = sender.locationInView(imageView)
        myBtnTopLeft.hidden = true
        myBtnTopRight.hidden = true
        myBtnBotLeft.hidden = true
        myBtnBotRight.hidden = true
        for i in 0..<arrTxtvLbl.count {
            arrTxtvLbl[i].label.tag = 0
            arrTxtvLbl[i].label.layer.borderWidth = 0
            if point.x >= arrTxtvLbl[i].label.frame.origin.x && point.x <= arrTxtvLbl[i].label.frame.origin.x + arrTxtvLbl[i].label.frame.size.width && point.y >= arrTxtvLbl[i].label.frame.origin.y && point.y <= arrTxtvLbl[i].label.frame.origin.y + arrTxtvLbl[i].label.frame.size.height {
                arrTxtvLbl[i].label.layer.borderWidth = 1
                arrTxtvLbl[i].label.tag = 1
                arrTxtvLbl[i].label.addGestureRecognizer(panGesture)
                
                myBtnTopLeft.frame = CGRectMake(arrTxtvLbl[i].label.frame.origin.x - 5, arrTxtvLbl[i].label.frame.origin.y - 5, 10, 10)
                myBtnTopLeft.layer.cornerRadius = myBtnTopLeft.frame.size.width/2
                myBtnTopLeft.layer.borderColor = UIColor.redColor().CGColor
                myBtnTopLeft.layer.borderWidth = 1
                myBtnTopLeft.hidden = false
                imageView.addSubview(myBtnTopLeft)
                panBtnTopLeftGesture.addTarget(self, action: #selector(ViewController.panBtnTopLeftGesture(_:)))
                myBtnTopLeft.addGestureRecognizer(panBtnTopLeftGesture)
                
                myBtnTopRight.frame = CGRectMake(arrTxtvLbl[i].label.frame.origin.x + arrTxtvLbl[i].label.frame.size.width - 5, arrTxtvLbl[i].label.frame.origin.y - 5, 10, 10)
                myBtnTopRight.layer.cornerRadius = myBtnTopRight.frame.size.width/2
                myBtnTopRight.layer.borderColor = UIColor.redColor().CGColor
                myBtnTopRight.layer.borderWidth = 1
                myBtnTopRight.hidden = false
                imageView.addSubview(myBtnTopRight)
                panBtnTopRightGesture.addTarget(self, action: #selector(ViewController.panBtnTopRightGesture(_:)))
                myBtnTopRight.addGestureRecognizer(panBtnTopRightGesture)
                
                myBtnBotLeft.frame = CGRectMake(arrTxtvLbl[i].label.frame.origin.x - 5, arrTxtvLbl[i].label.frame.origin.y + arrTxtvLbl[i].label.frame.size.height - 5, 10, 10)
                myBtnBotLeft.layer.cornerRadius = myBtnBotLeft.frame.size.width/2
                myBtnBotLeft.layer.borderColor = UIColor.redColor().CGColor
                myBtnBotLeft.layer.borderWidth = 1
                myBtnBotLeft.hidden = false
                imageView.addSubview(myBtnBotLeft)
                panBtnBotLeftGesture.addTarget(self, action: #selector(ViewController.panBtnBotLeftGesture(_:)))
                myBtnBotLeft.addGestureRecognizer(panBtnBotLeftGesture)
                
                myBtnBotRight.frame = CGRectMake(arrTxtvLbl[i].label.frame.origin.x + arrTxtvLbl[i].label.frame.size.width - 5, arrTxtvLbl[i].label.frame.origin.y + arrTxtvLbl[i].label.frame.size.height - 5, 10, 10)
                myBtnBotRight.layer.cornerRadius = myBtnBotRight.frame.size.width/2
                myBtnBotRight.layer.borderColor = UIColor.redColor().CGColor
                myBtnBotRight.layer.borderWidth = 1
                myBtnBotRight.hidden = false
                imageView.addSubview(myBtnBotRight)
                panBtnBotRightGesture.addTarget(self, action: #selector(ViewController.panBtnBotRightGesture(_:)))
                myBtnBotRight.addGestureRecognizer(panBtnBotRightGesture)
                
                arrTxtvLbl[i].textView.frame = arrTxtvLbl[i].label.frame
                arrTxtvLbl[i].textView.textColor = arrTxtvLbl[i].label.textColor
                
                slider.value = Float(arrTxtvLbl[i].label.font.pointSize)
                lbl.text = String(Int(arrTxtvLbl[i].label.font.pointSize))
                
                
                for j in 0..<arrItem[1].count {
                    if color[j] == arrTxtvLbl[i].label.textColor {
                        pickerView.selectRow(j, inComponent: 1, animated: true)
                    }
                }
                
                for k in 0..<arrItem[0].count {
                    if arrItem[0][k] == arrTxtvLbl[i].label.font.familyName {
                        pickerView.selectRow(k, inComponent: 0, animated: true)
                    }
                }
                
                if arrTxtvLbl[i].label.textAlignment == .Left {
                    segment.selectedSegmentIndex = 0
                } else if arrTxtvLbl[i].label.textAlignment == .Center {
                    segment.selectedSegmentIndex = 1
                } else if arrTxtvLbl[i].label.textAlignment == .Right {
                    segment.selectedSegmentIndex = 2
                }
            }
        }
        
        for i in (0..<arrTxtvLbl.count).reverse() {
            arrTxtvLbl[i].textView.endEditing(false)
        }
    }
    
    // MARK: Set TextView Font Size
    @IBOutlet var lbl: UILabel!
    @IBOutlet var slider: UISlider!
    @IBAction func change(sender: UISlider) {
        lbl.text = String(Int(slider.value))
        for i in 0..<arrTxtvLbl.count {
            if arrTxtvLbl[i].label.tag == 1  {
                arrTxtvLbl[i].label.font = arrTxtvLbl[i].label.font!.fontWithSize(CGFloat(slider.value))
                arrTxtvLbl[i].textView.frame.size = arrTxtvLbl[i].label.frame.size
                arrTxtvLbl[i].textView.font = arrTxtvLbl[i].label.font
                
//                while arrTxtvLbl[i].label.intrinsicContentSize().height > arrTxtvLbl[i].label.frame.size.height {
//                    arrTxtvLbl[i].label.frame.size.height = arrTxtvLbl[i].label.frame.size.height + 1
//                }
//                
//                while arrTxtvLbl[i].label.intrinsicContentSize().height <= arrTxtvLbl[i].label.frame.size.height {
//                    arrTxtvLbl[i].label.frame.size.height = arrTxtvLbl[i].label.frame.size.height - 1
//                }
            }
        }
    }
    
    // MARK: Aligment TextView
    @IBOutlet var segment: UISegmentedControl!
    
    @IBAction func segmentClick(sender: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0:
            for i in 0..<arrTxtvLbl.count {
                if arrTxtvLbl[i].label.tag == 1 {
                    arrTxtvLbl[i].label.textAlignment = NSTextAlignment.Left
                }
            }
        case 1:
            for i in 0..<arrTxtvLbl.count {
                if arrTxtvLbl[i].label.tag == 1 {
                    arrTxtvLbl[i].label.textAlignment = NSTextAlignment.Center
                }
            }
        default:
            for i in 0..<arrTxtvLbl.count {
                if arrTxtvLbl[i].label.tag == 1 {
                    arrTxtvLbl[i].label.textAlignment = NSTextAlignment.Right
                }
            }
        }
    }
    
    // MARK: Save Button
    @IBAction func btnSaveClicked(sender: AnyObject) {
        for i in 0..<arrTxtvLbl.count {
            arrTxtvLbl[i].textView.endEditing(false)
            arrTxtvLbl[i].label.layer.borderWidth = 0
        }
        myBtnTopLeft.hidden = true
        myBtnTopRight.hidden = true
        myBtnBotLeft.hidden = true
        myBtnBotRight.hidden = true
        let logo:UILabel = UILabel()
        logo.frame = CGRect(x: 10, y: 180, width: 100, height: 100)
        logo.text = "#QuangDog"
        logo.textColor = UIColor.redColor()
        imageView.addSubview(logo)
        UIGraphicsBeginImageContext(imageView.frame.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let imageSave = UIGraphicsGetImageFromCurrentImageContext()
        //UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(imageSave, nil, nil, nil)
        logo.removeFromSuperview()
    }
    
    // MARK: PanGesture
    func panGesture(sender: UIPanGestureRecognizer) {
        let location = sender.locationInView(imageView)
        let someRect = imageView.bounds
        if (CGRectContainsPoint(someRect, location)) {
            let translation = sender.translationInView(self.imageView)
            sender.view?.center = CGPoint(x: translation.x + (sender.view?.center.x)!, y: translation.y + (sender.view?.center.y)!)
            sender.setTranslation(CGPointZero, inView: imageView)
            for i in 0..<arrTxtvLbl.count {
                if arrTxtvLbl[i].label.tag == 1 {
                myBtnTopLeft.frame.origin.x = arrTxtvLbl[i].label.frame.origin.x - myBtnTopLeft.frame.size.width/2
                myBtnTopLeft.frame.origin.y = arrTxtvLbl[i].label.frame.origin.y - myBtnTopLeft.frame.size.height/2
                myBtnTopRight.frame.origin.x = arrTxtvLbl[i].label.frame.origin.x + arrTxtvLbl[i].label.frame.size.width - myBtnTopLeft.frame.size.width/2
                myBtnTopRight.frame.origin.y = arrTxtvLbl[i].label.frame.origin.y - myBtnTopLeft.frame.size.height/2
                myBtnBotLeft.frame.origin.x = arrTxtvLbl[i].label.frame.origin.x - myBtnTopLeft.frame.size.width/2
                myBtnBotLeft.frame.origin.y = arrTxtvLbl[i].label.frame.origin.y + arrTxtvLbl[i].label.frame.size.height - myBtnTopLeft.frame.size.height/2
                myBtnBotRight.frame.origin.x = arrTxtvLbl[i].label.frame.origin.x + arrTxtvLbl[i].label.frame.size.width - myBtnTopLeft.frame.size.width/2
                myBtnBotRight.frame.origin.y = arrTxtvLbl[i].label.frame.origin.y + arrTxtvLbl[i].label.frame.size.height - myBtnTopLeft.frame.size.height/2
                }
            }
        }
    }
    
    // MARK: Pan On Top Left Button
    func panBtnTopLeftGesture(sender: UIPanGestureRecognizer) {
        
        //        let translation = sender.translationInView(self.view)
        //
        //        if let view = sender.view {
        //            view.center = CGPoint(x:view.center.x + translation.x, y:view.center.y + translation.y)
        //        }
        //        sender.setTranslation(CGPointZero, inView: self.view)
        
        let location = sender.locationInView(view)
        let someRect = view.bounds
        if (CGRectContainsPoint(someRect, location)) {
            let translation = sender.translationInView(imageView)
            sender.view?.center = CGPoint(x: translation.x + (sender.view?.center.x)!, y: translation.y + (sender.view?.center.y)!)
            sender.setTranslation(CGPointZero, inView: imageView)
            
            for i in 0..<arrTxtvLbl.count {
                if arrTxtvLbl[i].label.tag == 1 {
                    arrTxtvLbl[i].label.frame.origin.x = (sender.view?.center.x)!
                    arrTxtvLbl[i].label.frame.origin.y = (sender.view?.center.y)!
                    
                    arrTxtvLbl[i].label.frame.size.width = arrTxtvLbl[i].label.frame.size.width - translation.x
                    arrTxtvLbl[i].label.frame.size.height = arrTxtvLbl[i].label.frame.size.height - translation.y
                    
                    let sizeText: CGFloat = arrTxtvLbl[i].label.font.pointSize - translation.y
                    arrTxtvLbl[i].label.font = arrTxtvLbl[i].label.font.fontWithSize(sizeText)
                    
                    let size = self.arrTxtvLbl[i].label.font!.pointSize
                    slider.value = Float(size)
                    lbl.text = String(Int(size))
                    
                    resizeFontLabel(arrTxtvLbl[i].label)
                }
            }
            
            myBtnTopRight.frame.origin.y = myBtnTopLeft.frame.origin.y
            myBtnBotLeft.frame.origin.x = myBtnTopLeft.frame.origin.x
        }
    }
    
    // MARK: Pan On Top Right Button
    func panBtnTopRightGesture(sender: UIPanGestureRecognizer) {
        let location = sender.locationInView(view)
        let someRect = view.bounds
        if (CGRectContainsPoint(someRect, location)) {
            let translation = sender.translationInView(view)
            sender.view?.center = CGPoint(x: translation.x + (sender.view?.center.x)!, y: translation.y + (sender.view?.center.y)!)
            sender.setTranslation(CGPointZero, inView: view)
            
            for i in 0..<arrTxtvLbl.count {
                if arrTxtvLbl[i].label.tag == 1 {
                    arrTxtvLbl[i].label.frame.origin.x = (sender.view?.center.x)! - arrTxtvLbl[i].label.frame.size.width
                    arrTxtvLbl[i].label.frame.origin.y = (sender.view?.center.y)!
                    
                    arrTxtvLbl[i].label.frame.size.width = arrTxtvLbl[i].label.frame.size.width + translation.x
                    arrTxtvLbl[i].label.frame.size.height = arrTxtvLbl[i].label.frame.size.height - translation.y
                    
                    let sizeText:CGFloat = arrTxtvLbl[i].label.font.pointSize - translation.y
                    arrTxtvLbl[i].label.font = arrTxtvLbl[i].label.font.fontWithSize(sizeText)
                    
                    resizeFontLabel(arrTxtvLbl[i].label)
                }
            }
            
            myBtnTopLeft.frame.origin.y = myBtnTopRight.frame.origin.y
            myBtnBotRight.frame.origin.x = myBtnTopRight.frame.origin.x
        }
    }
    
    // MARK: Pan On Bot Left Button
    func panBtnBotLeftGesture(sender: UIPanGestureRecognizer) {
        let location = sender.locationInView(view)
        let someRect = view.bounds
        if (CGRectContainsPoint(someRect, location)) {
            let translation = sender.translationInView(view)
            sender.view?.center = CGPoint(x: translation.x + (sender.view?.center.x)!, y: translation.y + (sender.view?.center.y)!)
            sender.setTranslation(CGPointZero, inView: view)
            
            for i in 0..<arrTxtvLbl.count {
                if arrTxtvLbl[i].label.tag == 1 {
                    arrTxtvLbl[i].label.frame.origin.x = (sender.view?.center.x)!
                    arrTxtvLbl[i].label.frame.origin.y = (sender.view?.center.y)! - arrTxtvLbl[i].label.frame.size.height
                    
                    arrTxtvLbl[i].label.frame.size.width = arrTxtvLbl[i].label.frame.size.width - translation.x
                    arrTxtvLbl[i].label.frame.size.height = arrTxtvLbl[i].label.frame.size.height + translation.y
                    
                    let sizeText:CGFloat = arrTxtvLbl[i].label.font.pointSize + translation.y
                    arrTxtvLbl[i].label.font = arrTxtvLbl[i].label.font.fontWithSize(sizeText)
                    
                    resizeFontLabel(arrTxtvLbl[i].label)
                }
            }
            
            myBtnTopLeft.frame.origin.x = myBtnBotLeft.frame.origin.x
            myBtnBotRight.frame.origin.y = myBtnBotLeft.frame.origin.y
        }
    }
    
    // MARK: Pan On Bot Right Button
    func panBtnBotRightGesture(sender: UIPanGestureRecognizer) {
        let location = sender.locationInView(view)
        let someRect = view.bounds
        if (CGRectContainsPoint(someRect, location)) {
            let translation = sender.translationInView(view)
            sender.view?.center = CGPoint(x: translation.x + (sender.view?.center.x)!, y: translation.y + (sender.view?.center.y)!)
            sender.setTranslation(CGPointZero, inView: view)
            
            for i in 0..<arrTxtvLbl.count {
                if arrTxtvLbl[i].label.tag == 1 {
                    arrTxtvLbl[i].label.frame.origin.x = (sender.view?.center.x)! - arrTxtvLbl[i].label.frame.size.width
                    arrTxtvLbl[i].label.frame.origin.y = (sender.view?.center.y)! - arrTxtvLbl[i].label.frame.size.height
                    
                    arrTxtvLbl[i].label.frame.size.width = translation.x + arrTxtvLbl[i].label.frame.size.width
                    arrTxtvLbl[i].label.frame.size.height = translation.y + arrTxtvLbl[i].label.frame.size.height
                    
                    let sizeText:CGFloat = arrTxtvLbl[i].label.font.pointSize + translation.y
                    arrTxtvLbl[i].label.font = arrTxtvLbl[i].label.font.fontWithSize(sizeText)
                    
                    resizeFontLabel(arrTxtvLbl[i].label)
                }
            }
            
            myBtnTopRight.frame.origin.x = myBtnBotRight.frame.origin.x
            myBtnBotLeft.frame.origin.y = myBtnBotRight.frame.origin.y
        }
    }
    
    // MARK: textViewDidEndEditing
    func textViewDidEndEditing(textView: UITextView) {
        for i in (0..<arrTxtvLbl.count).reverse(){
            if textView == arrTxtvLbl[i].textView && textView.text == "" {
                arrTxtvLbl[i].textView.removeFromSuperview()
                arrTxtvLbl[i].label.removeFromSuperview()
                arrTxtvLbl.removeAtIndex(i)
            } else if textView == arrTxtvLbl[i].textView && textView.text != "" {
                arrTxtvLbl[i].textView.hidden = true
                arrTxtvLbl[i].label.text = arrTxtvLbl[i].textView.text
                arrTxtvLbl[i].label.hidden = false
                arrTxtvLbl[i].label.font = arrTxtvLbl[i].textView.font
                let size = self.arrTxtvLbl[i].textView.font!.pointSize
                slider.value = Float(size)
                lbl.text = String(Int(size))
                
                resizeFontLabel(arrTxtvLbl[i].label)
//                print( arrTxtvLbl[i].label.frame.size.height)
//                print( arrTxtvLbl[i].label.frame.size.width)
//                print(arrTxtvLbl[i].label.intrinsicContentSize())
//                
//                let temp = arrTxtvLbl[i].label.intrinsicContentSize().width / arrTxtvLbl[i].label.frame.size.width
//                if arrTxtvLbl[i].label.intrinsicContentSize().width <= arrTxtvLbl[i].label.frame.size.width * CGFloat(Int(temp + 1)) {
//                    arrTxtvLbl[i].label.frame.size.height = 21 * CGFloat(Int(temp) + 1)
//                } else {
//                    arrTxtvLbl[i].label.frame.size.height = 21 * CGFloat(Int(temp))
//                }
            }
        }
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
            for i in 0..<arrTxtvLbl.count {
                if arrTxtvLbl[i].label.tag == 1 {
                    arrTxtvLbl[i].label.textColor = color[row]
                }
            }
        } else {
            for i in 0..<arrTxtvLbl.count {
                if arrTxtvLbl[i].label.tag == 1 {
                    arrTxtvLbl[i].label.font = UIFont(name: arrItem[0][row], size: CGFloat(slider.value))
                }
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
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
    
    
    // Resize font size label
    func resizeFontLabel(label: UILabel) {
        dispatch_async(dispatch_get_main_queue(), {
            
            var fontsize = label.font?.pointSize
            label.layoutIfNeeded()
            
            while (fontsize > 1.0 &&  label.sizeThatFits(CGSizeMake(label.frame.size.width, CGFloat(FLT_MAX))).height >= label.frame.size.height) {
                fontsize = fontsize! - 0.5
                label.font = label.font!.fontWithSize(fontsize!)
            }
        })
        dispatch_async(dispatch_get_main_queue(), {
            
            var fontsize = label.font?.pointSize
            label.layoutIfNeeded()
            
            while (label.sizeThatFits(CGSizeMake(label.frame.size.width, CGFloat(FLT_MAX))).height < label.frame.size.height ) {
                fontsize = fontsize! + 0.5
                label.font = label.font!.fontWithSize(fontsize!)
            }
        })
    }
}