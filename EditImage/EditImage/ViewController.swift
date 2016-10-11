//
//  ViewController.swift
//  EditImage
//
//  Created by huan huan on 10/5/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate {
    
    var arrBackgroundColor: [BackgroundColorModel] = []
    var arrBackgroundImage: [BackgroundImageModel] = []
    var arrPattern: [PatternModel] = []
    let imagePicker = UIImagePickerController()
    let userDF: NSUserDefaults = NSUserDefaults()
    let gradientLayer: CAGradientLayer = CAGradientLayer()
    let item: UIImageView = UIImageView()
    let arrFont: [String] = UIFont.familyNames()
    let tapOnImgViewToHiddenColBackGroundGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    let selectedBackgroundColor: UIImageView = UIImageView()
    let selectedPattern: UIImageView = UIImageView()
    let selectedBackgroundTemplate: UIImageView = UIImageView()
    
    var indexItem = [NSIndexPath]() {
        didSet {
            colViewBackground.reloadData()
        }
    }
    
    var indexFont = [NSIndexPath](){
        didSet {
            colFont.reloadData()
        }
    }
    
    @IBOutlet var viewButton: UIView!
    @IBOutlet var btnBackroundColor: UIButton!
    @IBOutlet var btnPattern: UIButton!
    @IBOutlet var btnBackgroundTemplate: UIButton!
    @IBOutlet var btnCamera: UIButton!
    @IBOutlet var btnGallery: UIButton!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var colViewBackground: UICollectionView!
    @IBOutlet var colFont: UICollectionView!
    @IBOutlet var slider: UISlider!
    @IBOutlet var gradientLayerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colViewBackground.delegate = self
        colViewBackground.dataSource = self
        colViewBackground.backgroundColor = UIColor.darkGrayColor()
        colViewBackground.hidden = true
        arrBackgroundColorAppend()
        arrPatternAppend()
        arrBackgroundImageAppend()
        
        imgView.image = UIImage(named: "0CUCBJX4FZ.jpg")
        
        colFont.delegate = self
        colFont.dataSource = self
        
        imgView.addGestureRecognizer(tapOnImgViewToHiddenColBackGroundGesture)
        tapOnImgViewToHiddenColBackGroundGesture.addTarget(self, action: #selector(ViewController.tapOnImgViewToHiddenColBackGround(_:)))
        imgView.userInteractionEnabled = true
        imgView.multipleTouchEnabled = true
        
        setViewButton()
        processGradientLayer()
        colorTemplate()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colFont {
            return arrFont.count
        } else {
            if indexItem.first == nil {
                return 0
            }
            if indexItem.first?.row == 0 {
                return arrBackgroundColor.count
            } else if indexItem.first?.row == 1 {
                return arrPattern.count
            } else if indexItem.first?.row == 2 {
                return arrBackgroundImage.count
            } else {
                return 0
            }
        }
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == colFont {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! FontCollectionViewCell
            cell.frame.size.width = colFont.frame.size.width / 3
            cell.lblFont.text = arrFont[indexPath.row]
            
            if cell.lblFont.text!.characters.count > 10 {
                cell.lblFont.text = (cell.lblFont.text! as NSString).substringToIndex(10)
                cell.lblFont.font = UIFont(name: arrFont[indexPath.row], size: (cell.lblFont.font?.pointSize)!)
            }
            
            if indexFont.indexOf(indexPath) == nil {
                cell.lblFont.textColor = UIColor.lightGrayColor()
            } else if indexFont.first?.row == indexPath.row {
                cell.lblFont.textColor = UIColor.blackColor()
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! BackgroundCollectionViewCell
            if indexItem.first?.row == 0 {
                let data = arrBackgroundColor[indexPath.row]
                cell.bgColorImage.image = nil
                cell.bgColorImage.backgroundColor = data.bgroundColor
                cell.bgColorImage.layer.borderColor = UIColor.whiteColor().CGColor
                cell.bgColorImage.layer.borderWidth = 1
            } else if indexItem.first!.row == 1 {
                let data = arrPattern[indexPath.row]
                cell.bgColorImage.image = nil
                cell.bgColorImage.image = UIImage(named: data.pattern)
                cell.bgColorImage.layer.borderColor = UIColor.whiteColor().CGColor
                cell.bgColorImage.layer.borderWidth = 1
            } else if indexItem.first?.row == 2 {
                let data = arrBackgroundImage[indexPath.row]
                cell.bgColorImage.image = nil
                cell.bgColorImage.image = UIImage(named: data.backgroundImage)
                cell.bgColorImage.layer.borderColor = UIColor.whiteColor().CGColor
                cell.bgColorImage.layer.borderWidth = 1
            }
            return cell
        }
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView == colViewBackground {
            if indexItem.first?.row == 0 {
                let data = arrBackgroundColor[indexPath.row]
                imgView.backgroundColor = data.bgroundColor
                btnBackroundColor.backgroundColor = data.bgroundColor
                setSelectedBackground()
            } else if indexItem.first?.row == 1 {imgView.image = nil
                let data = arrPattern[indexPath.row]
                setImgViewBackground(data.pattern)
                btnPattern.setBackgroundImage(UIImage(named: data.pattern), forState: .Normal)
                setSelectedBackground()
            } else if indexItem.first?.row == 2 {imgView.image = nil
                let data = arrBackgroundImage[indexPath.row]
                setImgViewBackground(data.backgroundImage)
                btnBackgroundTemplate.setBackgroundImage(UIImage(named: data.backgroundImage), forState: .Normal)
                setSelectedBackground()
            }
        } else if collectionView == colFont {
            indexFont.removeAll()
            indexFont.append(indexPath)
        }
    }
    
    // MARK: Actions
    @IBAction func btnAddTextClicked(sender: UIButton) {
        let lblText: UILabel = UILabel()
        lblText.text = "Double tap to quote"
        lblText.layer.borderColor = UIColor.whiteColor().CGColor
        lblText.layer.borderWidth = 1
        lblText.frame.size = CGSize(width: 200, height: 30)
        lblText.textAlignment = .Center
        lblText.textColor = UIColor.whiteColor()
        lblText.center.x = imgView.frame.size.width / 2
        lblText.center.y = imgView.frame.size.height / 2
        imgView.addSubview(lblText)
    }
    
    func setViewButton() {
        btnBackroundColor.backgroundColor = UIColor.lightGrayColor()
        btnPattern.setBackgroundImage(UIImage(named: "smoke4.jpg"), forState: .Normal)
        btnBackgroundTemplate.setBackgroundImage(UIImage(named: "0CUCBJX4FZ.jpg"), forState: .Normal)
        btnCamera.setBackgroundImage(UIImage(named: "CP_Camera"), forState: .Normal)
        btnGallery.setBackgroundImage(UIImage(named: "CP_Photo"), forState: .Normal)
        
        let widthButton = (viewButton.frame.size.width - 60) / 5
        btnBackroundColor.autoresizesSubviews = false
        btnBackroundColor.translatesAutoresizingMaskIntoConstraints = false
        viewButton.addConstraint(NSLayoutConstraint(item: btnBackroundColor, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1, constant: widthButton))
        
        let widthViewButton = widthButton + 20
        viewButton.autoresizesSubviews = false
        viewButton.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: viewButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1, constant: widthViewButton))
    }
    
    @IBAction func btnShareOnFaceClicked(sender: UIButton) {
        let composeSheet = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        composeSheet.addImage(imgView.image)
        presentViewController(composeSheet, animated: true, completion: nil)
    }
    
    @IBAction func btnBackroundColorClicked(sender: UIButton) {
        indexItem.removeAll()
        indexItem.append(NSIndexPath(forRow: 0, inSection: 0))
        colViewBackground.hidden = false
    }
    
    func setSelectedBackground() {
        selectedBackgroundColor.frame = btnBackroundColor.frame
        selectedBackgroundColor.image = UIImage(named: "CP_Selected")
        viewButton.addSubview(selectedBackgroundColor)
        selectedBackgroundColor.hidden = true
        
        selectedPattern.frame = btnPattern.frame
        selectedPattern.image = UIImage(named: "CP_Selected")
        viewButton.addSubview(selectedPattern)
        selectedPattern.hidden = true
        
        selectedBackgroundTemplate.frame = btnBackgroundTemplate.frame
        selectedBackgroundTemplate.image = UIImage(named: "CP_Selected")
        viewButton.addSubview(selectedBackgroundTemplate)
        selectedBackgroundTemplate.hidden = true
        
        if indexItem.first?.row == 0 {
            selectedBackgroundColor.hidden = false
            selectedPattern.hidden = true
            selectedBackgroundTemplate.hidden = true
        } else if indexItem.first?.row == 1 {
            selectedPattern.hidden = false
            selectedBackgroundColor.hidden = true
            selectedBackgroundTemplate.hidden = true
        } else if indexItem.first?.row == 2 {
            selectedBackgroundTemplate.hidden = false
            selectedBackgroundColor.hidden = true
            selectedPattern.hidden = true
        }
    }
    
    @IBAction func btnPatternClicked(sender: UIButton) {
        indexItem.removeAll()
        indexItem.append(NSIndexPath(forRow: 1, inSection: 0))
        colViewBackground.hidden = false
    }
    
    @IBAction func btnBackgroundTemplateClicked(sender: UIButton) {
        indexItem.removeAll()
        indexItem.append(NSIndexPath(forRow: 2, inSection: 0))
        colViewBackground.hidden = false
    }
    
    @IBAction func btnCameraClicked(sender: UIButton) {
        colViewBackground.hidden = true
    }
    
    @IBAction func btnGalleryClicked(sender: UIButton) {
        colViewBackground.hidden = true
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func setImgViewBackground(str: String) {
        imgView.contentMode =  UIViewContentMode.ScaleAspectFill
        imgView.clipsToBounds = true
        imgView.image = UIImage(named: str)
        imgView.center = view.center
        
        UIGraphicsBeginImageContext(imgView.frame.size)
        imgView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let imageSave = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        imgView.backgroundColor = UIColor(patternImage: imageSave)
    }
    
    func tapOnImgViewToHiddenColBackGround(sender: UITapGestureRecognizer) {
        colViewBackground.hidden = true
    }
    
    func processGradientLayer() {
        gradientLayer.frame = gradientLayerView.bounds
        let whiteColorTop = UIColor.whiteColor().CGColor as CGColorRef
        let blackColorBottom = UIColor.lightGrayColor().CGColor as CGColorRef
        gradientLayer.colors = [whiteColorTop, blackColorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayerView.layer.addSublayer(gradientLayer)
    }
    
    func colorTemplate() {
        let color: HSBColorPicker = HSBColorPicker()
        self.view.addSubview(color)
        
        color.autoresizesSubviews = false
        color.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(NSLayoutConstraint(item: color, attribute: .Top, relatedBy: .Equal, toItem: gradientLayerView, attribute: .Bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: color, attribute: .Bottom , relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: color, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: color, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: 0))
    }
    
    // MARK: Array source
    func arrBackgroundColorAppend() {
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.blackColor()))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.darkGrayColor()))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.lightGrayColor()))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.whiteColor()))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.grayColor()))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.redColor()))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.greenColor()))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.blueColor()))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.cyanColor()))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.yellowColor()))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.magentaColor()))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.orangeColor()))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.purpleColor()))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.brownColor()))
    }
    
    func arrPatternAppend() {
        arrPattern.append(PatternModel.init(pat: "2.jpg"))
        arrPattern.append(PatternModel.init(pat: "galaxy-bg-3.jpg"))
        arrPattern.append(PatternModel.init(pat: "galaxy-bg-8.jpg"))
        arrPattern.append(PatternModel.init(pat: "grunge2_4.jpg"))
        arrPattern.append(PatternModel.init(pat: "smoke4.jpg"))
        arrPattern.append(PatternModel.init(pat: "vintage_clouds_3.jpg"))
        arrPattern.append(PatternModel.init(pat: "vintage_clouds_7.jpg"))
        arrPattern.append(PatternModel.init(pat: "wg_blurred_worn_bg8.jpg"))
        arrPattern.append(PatternModel.init(pat: "wg_gemstone_10.jpg"))
    }
    
    func arrBackgroundImageAppend() {
        arrBackgroundImage.append(BackgroundImageModel.init(bgImg: "0CUCBJX4FZ.jpg"))
        arrBackgroundImage.append(BackgroundImageModel.init(bgImg: "1FA6SEYFHF.jpg"))
        arrBackgroundImage.append(BackgroundImageModel.init(bgImg: "2A1RBTLS50.jpg"))
        arrBackgroundImage.append(BackgroundImageModel.init(bgImg: "GEJ6ML9NHQ.jpg"))
        arrBackgroundImage.append(BackgroundImageModel.init(bgImg: "ZOL7UI7UE6.jpg"))
    }
    
}

extension String {
    func trunc(length: Int, trailing: String? = "") -> String {
        if self.characters.count > length {
            return self.substringToIndex(self.startIndex.advancedBy(length))
        } else {
            return self
        }
    }
}
