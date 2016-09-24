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
    var arrTxtvLbl:[ArrayModel] = []
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var pickerView: UIPickerView!
    
    @IBOutlet var myView: UIView!
    
    @IBOutlet var btnChooseImage: UIButton!
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var btnShare: UIButton!
    
    var txtv:UITextView = UITextView()
    var label:UILabel = UILabel()
    
    let tapOnImageToCreateTextViewAndLabel:UITapGestureRecognizer = UITapGestureRecognizer()
    let panGesture:UIPanGestureRecognizer = UIPanGestureRecognizer()
    let tapOnLabelToEdit:UITapGestureRecognizer = UITapGestureRecognizer()

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
        slider.value = 1
        lbl.text = "1"
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
        txtv.frame =  CGRect(x: point.x, y: point.y, width: 100, height: 30)
        txtv.becomeFirstResponder()
        
        label.backgroundColor = UIColor.blueColor()
        label.userInteractionEnabled = true
        label.multipleTouchEnabled = true
        label.frame =  CGRect(x: point.x, y: point.y, width: 100, height: 30)
        label.hidden = true
        
        arrTxtvLbl.append(ArrayModel.init(txtv: txtv, lbl: label))
        
        imageView.addSubview(txtv)
        imageView.addSubview(label)
        
        for i in (0..<arrTxtvLbl.count).reverse() {
            if point.x >= arrTxtvLbl[i].label.frame.origin.x && point.x <= arrTxtvLbl[i].label.frame.origin.x + arrTxtvLbl[i].label.frame.size.width && point.y >= arrTxtvLbl[i].label.frame.origin.y && point.y <= arrTxtvLbl[i].label.frame.origin.y + arrTxtvLbl[i].label.frame.size.height {
                arrTxtvLbl[i].label.hidden = true
                arrTxtvLbl[i].label.addGestureRecognizer(panGesture)
                arrTxtvLbl[i].textView.frame.origin.x = arrTxtvLbl[i].label.frame.origin.x
                arrTxtvLbl[i].textView.frame.origin.y = arrTxtvLbl[i].label.frame.origin.y
                arrTxtvLbl[i].textView.hidden = false
                arrTxtvLbl[i].textView.becomeFirstResponder()
            }
        }
    }
    
    
    //MARK: Tao On Label To Edit Text
    func tapOnLabelToEdit(sender: UITapGestureRecognizer) {
        let point:CGPoint = sender.locationInView(imageView)
        for i in 0..<arrTxtvLbl.count {
            if point.x >= arrTxtvLbl[i].label.frame.origin.x && point.x <= arrTxtvLbl[i].label.frame.origin.x + arrTxtvLbl[i].label.frame.size.width && point.y >= arrTxtvLbl[i].label.frame.origin.y && point.y <= arrTxtvLbl[i].label.frame.origin.y + arrTxtvLbl[i].label.frame.size.height {
                arrTxtvLbl[i].label.tag = 1
                arrTxtvLbl[i].label.addGestureRecognizer(panGesture)
            } else {
                arrTxtvLbl[i].label.tag = 0
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
                arrTxtvLbl[i].label.sizeToFit()
                arrTxtvLbl[i].textView.frame.size.width = arrTxtvLbl[i].label.frame.size.width
                arrTxtvLbl[i].textView.frame.size.height = arrTxtvLbl[i].label.frame.size.height
                arrTxtvLbl[i].textView.font = arrTxtvLbl[i].label.font
            }
        }
    }
    
    // MARK: Aligment TextView
    @IBOutlet var aligment: UISegmentedControl!
    
    @IBAction func alignment(sender: UISegmentedControl) {
        switch aligment.selectedSegmentIndex {
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
    
    // MARK: Button Save
    @IBAction func btnSaveClicked(sender: AnyObject) {
        txtv.endEditing(false)
        UIGraphicsBeginImageContext(imageView.frame.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        let logo:UILabel = UILabel()
        logo.frame = CGRect(x: 30, y: 180, width: 100, height: 100)
        logo.text = "#QuangDog"
        logo.textColor = UIColor.redColor()
        imageView.addSubview(logo)
        imageView.image = image
        for i in 0..<arrTxtvLbl.count {
            arrTxtvLbl[i].textView.removeFromSuperview()
            arrTxtvLbl[i].label.removeFromSuperview()
        }
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
                    arrTxtvLbl[i].label.font = UIFont(name: arrItem[0][row], size: 14)
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

}