//
//  ViewController.swift
//  EditImage
//
//  Created by huan huan on 10/5/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit
import Social

enum QBLBackgroundType: String{
    case Color
    case Pattern
    case Image
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var arrBackgroundColor: [BackgroundColorModel] = []
    let imagePicker = UIImagePickerController()
    var arrFont: [FontModel] = []
    let tapOnImgViewToHiddenColBackGroundGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    let selectedBackgroundColor: UIImageView = UIImageView()
    let selectedPattern: UIImageView = UIImageView()
    let selectedBackgroundTemplate: UIImageView = UIImageView()
    let imgGradient: UIImageView = UIImageView()
    let colorPicker: HSBColorPicker = HSBColorPicker()
    var stSelectBackroundColor = SelectButton()
    var stSelectPattern = SelectButton()
    var stSelectBackgroundTemplate = SelectButton()
    var lblTextView = LabelTextView()
    var arrLblTextView: [UIView] = []
    
    var arrImagePatternBundleImages: [UIImage] = []
    var arrImageBackgroundTemplateBundleImages: [UIImage] = []
    var arrImagePatternBundleThumb: [UIImage] = []
    var arrImageBackgroundTemplateBundleThumb: [UIImage] = []
    
//    var indexItem = [IndexPath]() {
//        didSet {
//            colViewBackground.reloadData()
//        }
//    }

    var backgroundType: QBLBackgroundType = .Color {
        didSet {
            colViewBackground.reloadData()
        }
    }
    
    var indexFont = [IndexPath](){
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
    @IBOutlet var imgSmallSize: UIImageView!
    @IBOutlet var imgBigSize: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPatternFromBundleThumbs()
        getBackgroundTemplateFromBundleThumbs()
        getPatternFromBundleImages()
        getBackgroundTemplateFromBundleImages()
        
        imagePicker.delegate = self
        
        colViewBackground.delegate = self
        colViewBackground.dataSource = self
        colViewBackground.backgroundColor = UIColor.darkGray
        colViewBackground.isHidden = true
        arrBackgroundColorAppend()
        arrFontAppend()
        
        colFont.delegate = self
        colFont.dataSource = self
        
        imgView.addGestureRecognizer(tapOnImgViewToHiddenColBackGroundGesture)
        tapOnImgViewToHiddenColBackGroundGesture.addTarget(self, action: #selector(ViewController.tapOnImgViewToHiddenColBackGround(_:)))
        imgView.isUserInteractionEnabled = true
        imgView.isMultipleTouchEnabled = true
        
        setupViewButton()
        setSelectBackground()
        stSelectBackgroundTemplate.setChosen(true)
        setGradient()
        colorTemplate()
        
        setupSlider()
        imgSmallSize.image = UIImage(named: "CP_SizeSmall")
        imgSmallSize.contentMode = .scaleAspectFit
        imgBigSize.image = UIImage(named: "CP_SizeBig")
        imgBigSize.contentMode = .scaleAspectFit
        addTapGestureOnImgView()
        setupTextColor()
        setImgViewBackground(arrImageBackgroundTemplateBundleImages[1])
    }
    
    func getPatternFromBundleImages() {
        let path = Bundle.main.bundlePath.appendingFormat("/Pattern.bundle/images")
        self.arrImagePatternBundleImages = []
        if let enumerator = FileManager.default.enumerator(atPath: path){
            while let element = enumerator.nextObject() as? String {
                //self.arrPatternBundle.append(element)
                if let image = UIImage.init(named: element, in: Bundle(path: path), compatibleWith: nil){
                    self.arrImagePatternBundleImages.append(image)
                }
            }
        }
    }
    
    func getBackgroundTemplateFromBundleImages() {
        let path = Bundle.main.bundlePath.appendingFormat("/BackgroundTemplate.bundle/images")
        self.arrImageBackgroundTemplateBundleImages = []
        if let enumerator = FileManager.default.enumerator(atPath: path){
            while let element = enumerator.nextObject() as? String {
                //self.arrBackgroundTemplateBundle.append(element)
                if let image = UIImage.init(named: element, in: Bundle(path: path), compatibleWith: nil){
                    self.arrImageBackgroundTemplateBundleImages.append(image)
                }
            }
        }
    }
    
    func getPatternFromBundleThumbs() {
        let path = Bundle.main.bundlePath.appendingFormat("/Pattern.bundle/thumbs")
        self.arrImagePatternBundleThumb = []
        if let enumerator = FileManager.default.enumerator(atPath: path){
            while let element = enumerator.nextObject() as? String {
                //self.arrPatternBundle.append(element)
                if let image = UIImage.init(named: element, in: Bundle(path: path), compatibleWith: nil){
                    self.arrImagePatternBundleThumb.append(image)
                }
            }
        }
    }
    
    func getBackgroundTemplateFromBundleThumbs() {
        let path = Bundle.main.bundlePath.appendingFormat("/BackgroundTemplate.bundle/thumbs")
        self.arrImageBackgroundTemplateBundleThumb = []
        if let enumerator = FileManager.default.enumerator(atPath: path){
            while let element = enumerator.nextObject() as? String {
                //self.arrBackgroundTemplateBundle.append(element)
                if let image = UIImage.init(named: element, in: Bundle(path: path), compatibleWith: nil){
                    self.arrImageBackgroundTemplateBundleThumb.append(image)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colFont {
            return arrFont.count
        } else {
//            if indexItem.first == nil {
//                return 0
//            }
            //colViewBackground.reloadData()
            if backgroundType == .Color { //(indexItem.first as NSIndexPath?)?.row == 0 {
                return arrBackgroundColor.count
            } else if backgroundType == .Pattern  { //(indexItem.first as NSIndexPath?)?.row == 1 {
                return arrImagePatternBundleImages.count
            } else if backgroundType == .Image { //(indexItem.first as NSIndexPath?)?.row == 2 {
                return arrImageBackgroundTemplateBundleImages.count
            } else {
                return 0
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == colFont {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FontCollectionViewCell
            cell.frame.size.width = colFont.frame.size.width / 3
            let data = arrFont[(indexPath as NSIndexPath).row]
            cell.lblFont.text = data.listFont as String?
            
            if cell.lblFont.text!.characters.count > 10 {
                cell.lblFont.text = (cell.lblFont.text! as NSString).substring(to: 10)
                let data = arrFont[(indexPath as NSIndexPath).row]
                cell.lblFont.font = UIFont(name: data.listFont as String, size: (cell.lblFont.font?.pointSize)!)
            }
            
            if indexFont.index(of: indexPath) == nil {
                cell.lblFont.textColor = UIColor.lightGray
            } else if (indexFont.first as NSIndexPath?)?.row == (indexPath as NSIndexPath).row {
                cell.lblFont.textColor = UIColor.black
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! BackgroundCollectionViewCell
            if backgroundType == .Color {//(indexItem.first as NSIndexPath?)?.row == 0 {
                let data = arrBackgroundColor[(indexPath as NSIndexPath).row]
                cell.bgColorImage.image = nil
                cell.bgColorImage.backgroundColor = data.bgroundColor
                cell.bgColorImage.layer.borderColor = UIColor.white.cgColor
                cell.bgColorImage.layer.borderWidth = 1

            } else if backgroundType == .Pattern {//(indexItem.first! as NSIndexPath).row == 1 {
                cell.bgColorImage.image = nil
                cell.bgColorImage.backgroundColor = nil
                cell.bgColorImage.image = arrImagePatternBundleThumb[indexPath.row]
                cell.bgColorImage.layer.borderColor = UIColor.white.cgColor
                cell.bgColorImage.layer.borderWidth = 1
//                let imgData: NSData = NSData(data: UIImageJPEGRepresentation(cell.bgColorImage.image!, 1)!)
//                let imageSize: Int = imgData.length
//                print("size of image in KB: %f ", imageSize / 1024)
            } else if backgroundType == .Image {//(indexItem.first as NSIndexPath?)?.row == 2 {
                cell.bgColorImage.image = nil
                cell.bgColorImage.backgroundColor = nil
                cell.bgColorImage.image = arrImageBackgroundTemplateBundleThumb[indexPath.row]
                cell.bgColorImage.layer.borderColor = UIColor.white.cgColor
                cell.bgColorImage.layer.borderWidth = 1
//                let imgData: NSData = NSData(data: UIImageJPEGRepresentation(cell.bgColorImage.image)!, 1)!)
//                let imageSize: Int = imgData.length
//                print("size of image in KB: %f ", imageSize / 1024)
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == colViewBackground {
            if backgroundType == .Color { //(indexItem.first as NSIndexPath?)?.row == 0 {
                let data = arrBackgroundColor[(indexPath as NSIndexPath).row]
                imgView.backgroundColor = data.bgroundColor
                btnBackroundColor.backgroundColor = data.bgroundColor
                stSelectBackroundColor.setChosen(true)
                stSelectPattern.setChosen(false)
                stSelectBackgroundTemplate.setChosen(false)
            } else if backgroundType == .Pattern { //(indexItem.first as NSIndexPath?)?.row == 1 {
                setImgViewBackground(arrImagePatternBundleImages[(indexPath as NSIndexPath).row])
                btnPattern.setBackgroundImage(arrImagePatternBundleImages[indexPath.row], for: UIControlState())
                stSelectPattern.setChosen(true)
                stSelectBackroundColor.setChosen(false)
                stSelectBackgroundTemplate.setChosen(false)
            } else if backgroundType == .Image {//(indexItem.first as NSIndexPath?)?.row == 2 {
                setImgViewBackground(arrImageBackgroundTemplateBundleImages[(indexPath as NSIndexPath).row])
                btnBackgroundTemplate.setBackgroundImage(arrImageBackgroundTemplateBundleImages[indexPath.row], for: UIControlState())
                stSelectBackgroundTemplate.setChosen(true)
                stSelectBackroundColor.setChosen(false)
                stSelectPattern.setChosen(false)
            }
        } else if collectionView == colFont {
            indexFont.removeAll()
            indexFont.append(indexPath)
            
            for i in 0..<arrLblTextView.count {
                let lbltv = arrLblTextView[i] as! LabelTextView
                if lbltv.tag == 1 {
                    let data = arrFont[indexPath.row]
                    lbltv.textLbl.font = UIFont(name: data.listFont as String, size: lblTextView.textLbl.font.pointSize)
                }
            }
        }
    }
    
    // MARK: Actions
    var temp = 0
    @IBAction func btnAddTextClicked(_ sender: UIButton) {
        lblTextView = LabelTextView()
        lblTextView.frame.size = CGSize(width: 210, height: 40)
        imgView.addSubview(lblTextView)
        arrLblTextView.append(lblTextView)
        temp += 1
        if temp%3 == 1 {
            lblTextView.frame.origin = CGPoint(x: (imgView.frame.size.width - lblTextView.frame.size.width) / 2 - 50, y: (imgView.frame.size.height - lblTextView.frame.size.height) / 2 - 50)
        } else if temp%3 == 2 {
            lblTextView.frame.origin = CGPoint(x: (imgView.frame.size.width - lblTextView.frame.size.width) / 2, y: (imgView.frame.size.height - lblTextView.frame.size.height) / 2)
        } else if temp%3 == 0 {
            lblTextView.frame.origin = CGPoint(x: (imgView.frame.size.width - lblTextView.frame.size.width) / 2 + 50, y: (imgView.frame.size.height - lblTextView.frame.size.height) / 2 + 50)
        }
        let panGestureLblTextView: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.lblTextViewPangesture(_:)))
        lblTextView.textLbl.isUserInteractionEnabled = true
        lblTextView.addGestureRecognizer(panGestureLblTextView)
        imgView.isUserInteractionEnabled = true
        
        let tapGestureLblTextView: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.lblTextViewTapgesture(_:)))
        lblTextView.addGestureRecognizer(tapGestureLblTextView)
    }
    
    func lblTextViewPangesture(_ sender: UIPanGestureRecognizer) {
        if lblTextView.frame.origin.x >= 0 && lblTextView.frame.origin.y >= 0 && lblTextView.frame.origin.x + lblTextView.frame.size.width <= imgView.frame.size.width && lblTextView.frame.origin.y + lblTextView.frame.size.height <= imgView.frame.size.height {
            let translation = sender.translation(in: self.imgView)
            sender.view?.center = CGPoint(x: translation.x + (sender.view?.center.x)!, y: translation.y + (sender.view?.center.y)!)
            sender.setTranslation(CGPoint.zero, in: imgView)
        } else if lblTextView.frame.origin.x < 0 {
            lblTextView.frame.origin.x = 0
        } else if lblTextView.frame.origin.y < 0 {
            lblTextView.frame.origin.y = 0
        } else if lblTextView.frame.origin.x + lblTextView.frame.size.width > imgView.frame.size.width {
            lblTextView.frame.origin.x = imgView.frame.size.width - lblTextView.frame.size.width
        } else if lblTextView.frame.origin.y + lblTextView.frame.size.height > imgView.frame.size.height {
            lblTextView.frame.origin.y = imgView.frame.size.height - lblTextView.frame.size.height
        }
    }
    
    func lblTextViewTapgesture(_ sender: UITapGestureRecognizer) {
        let point: CGPoint = sender.location(in: imgView)
        for i in 0..<arrLblTextView.count {
            let lbltv = arrLblTextView[i] as! LabelTextView
            lbltv.topLeftBtn.isHidden = true
            lbltv.topRightBtn.isHidden = true
            lbltv.botRightBtn.isHidden = true
            lbltv.botLeftBtn.isHidden = true
            lbltv.textLbl.layer.borderWidth = 0
            if lbltv.textView.isHidden == false {
                lbltv.textView.isHidden = true
                lbltv.textLbl.isHidden = false
                
                if lbltv.textView.text != "" {
                    lbltv.textLbl.text = lbltv.textView.text
                } else {
                    lbltv.textLbl.text = "Double tap to quote"
                }
            }
            lbltv.tag = 0
            
            if lbltv.frame.contains(point) {
                lbltv.tag = 1
                slider.value = Float(lbltv.textLbl.font.pointSize)
                lbltv.topLeftBtn.isHidden = false
                lbltv.topRightBtn.isHidden = false
                lbltv.botRightBtn.isHidden = false
                lbltv.botLeftBtn.isHidden = false
                lbltv.textLbl.layer.borderWidth = 1
            }
        }
    }
    
    func addTapGestureOnImgView() {
        let tapGestureImgView: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.imgViewTapGesture(_:)))
        imgView.addGestureRecognizer(tapGestureImgView)
    }
    
    func imgViewTapGesture(_ sender: UITapGestureRecognizer) {
        for i in 0..<arrLblTextView.count {
            let lbltv = arrLblTextView[i] as! LabelTextView
            lbltv.textLbl.layer.borderWidth = 0
            lbltv.topLeftBtn.isHidden = true
            lbltv.topRightBtn.isHidden = true
            lbltv.botRightBtn.isHidden = true
            lbltv.botLeftBtn.isHidden = true
            if lbltv.textView.isHidden == false {
                lbltv.textView.isHidden = true
                lbltv.textLbl.isHidden = false
                if lbltv.textView.text != "" {
                    lbltv.textLbl.text = lbltv.textView.text
                } else {
                    lbltv.textLbl.text = "Double tap to quote"
                }
            }
        }
    }
    
    func setupSlider() {
        slider.minimumValue = 5.0
        slider.maximumValue = 100.0
        slider.value = 10.0
        slider.setThumbImage(UIImage(named: "CP_Point"), for: UIControlState())
    }
    
    @IBAction func changeFontSizeSlider(_ sender: UISlider) {
        for i in 0..<arrLblTextView.count {
            let lbltv = arrLblTextView[i] as! LabelTextView
            if lbltv.tag == 1 {
                lbltv.textLbl.font = lbltv.textLbl.font.withSize(CGFloat(slider.value))
            }
        }
    }
    
    func setupTextColor() {
        let longGestureColorPicker: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longGestureColorPicker(_:)))
        longGestureColorPicker.minimumPressDuration = 0
        colorPicker.addGestureRecognizer(longGestureColorPicker)
    }
    
    func longGestureColorPicker(_ sender: UILongPressGestureRecognizer) {
        let location = sender.location(in: self.colorPicker)
        let textColor = colorPicker.getColorAtPoint(location)
        for i in 0..<arrLblTextView.count {
            let lbltv = arrLblTextView[i] as! LabelTextView
            if lbltv.tag == 1 {
                lbltv.textLbl.textColor = textColor
            }
        }
    }
    
    @IBAction func btnShareOnFaceClicked(_ sender: UIButton) {
        if imgView.image != nil {
            let lblLogo: UILabel = UILabel()
            lblLogo.translatesAutoresizingMaskIntoConstraints = false
            lblLogo.autoresizesSubviews = false
            imgView.addSubview(lblLogo)
            lblLogo.text = "#SonTungAC&M"
            lblLogo.textColor = UIColor.red
            imgView.addConstraint(NSLayoutConstraint(item: lblLogo, attribute: .leading, relatedBy: .equal, toItem: imgView, attribute: .leading, multiplier: 1.0, constant: 20.0))
            imgView.addConstraint(NSLayoutConstraint(item: lblLogo, attribute: .bottom, relatedBy: .equal, toItem: imgView, attribute: .bottom, multiplier: 1.0, constant: -20.0))
            
            for i in 0..<arrLblTextView.count {
                let lbltv = arrLblTextView[i] as! LabelTextView
                lbltv.topLeftBtn.isHidden = true
                lbltv.topRightBtn.isHidden = true
                lbltv.botRightBtn.isHidden = true
                lbltv.botLeftBtn.isHidden = true
                lbltv.textLbl.layer.borderWidth = 0
                if lbltv.textLbl.text == "Double tap to quote" {
                    lbltv.isHidden = true
                }
            }
            
            UIGraphicsBeginImageContext(imgView.frame.size)
            imgView.layer.render(in: UIGraphicsGetCurrentContext()!)
            let imageSave = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            UIImageWriteToSavedPhotosAlbum(imageSave!, nil, nil, nil)
            
            lblLogo.removeFromSuperview()
            for i in 0..<arrLblTextView.count {
                let lbltv = arrLblTextView[i] as! LabelTextView
                lbltv.isHidden = false
            }
            
            let composeSheet = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            composeSheet?.add(imageSave)
            present(composeSheet!, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "No photos will be selected", message: "Please select any image", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func setupViewButton() {
        btnBackroundColor.backgroundColor = UIColor.lightGray
        btnPattern.setBackgroundImage(arrImagePatternBundleThumb[4], for: UIControlState())
        btnBackgroundTemplate.setBackgroundImage(arrImageBackgroundTemplateBundleImages[1], for: UIControlState())
        btnCamera.setBackgroundImage(UIImage(named: "CP_Camera"), for: UIControlState())
        btnGallery.setBackgroundImage(UIImage(named: "CP_Photo"), for: UIControlState())
    }
    
    func setSelectBackground() {
        view.layoutIfNeeded()
        stSelectBackroundColor.frame = btnBackroundColor.frame
        viewButton.addSubview(stSelectBackroundColor)
        
        stSelectPattern.frame = btnPattern.frame
        viewButton.addSubview(stSelectPattern)
        
        stSelectBackgroundTemplate.frame = btnBackgroundTemplate.frame
        viewButton.addSubview(stSelectBackgroundTemplate)
    }
    
    @IBAction func btnBackroundColorClicked(_ sender: UIButton) {
        //indexItem.removeAll()
        //indexItem.append(IndexPath(row: 0, section: 0))
        backgroundType = QBLBackgroundType.Color
        colViewBackground.isHidden = false
    }
    
    @IBAction func btnPatternClicked(_ sender: UIButton) {
        //indexItem.removeAll()
        //indexItem.append(IndexPath(row: 1, section: 0))
        backgroundType = QBLBackgroundType.Pattern
        colViewBackground.isHidden = false
    }
    
    @IBAction func btnBackgroundTemplateClicked(_ sender: UIButton) {
        //indexItem.removeAll()
        //indexItem.append(IndexPath(row: 2, section: 0))
        backgroundType = QBLBackgroundType.Image
        colViewBackground.isHidden = false
    }
    
    @IBAction func btnCameraClicked(_ sender: UIButton) {
        colViewBackground.isHidden = true
    }
    
    @IBAction func btnGalleryClicked(_ sender: UIButton) {
        colViewBackground.isHidden = true
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgView.contentMode = .scaleAspectFit
            imgView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func setImgViewBackground(_ img: UIImage) {
        let imgViewBackground = UIImageView()
        imgViewBackground.frame = imgView.frame
        imgViewBackground.contentMode =  UIViewContentMode.scaleAspectFill
        imgViewBackground.clipsToBounds = true
        imgViewBackground.image = img
        imgViewBackground.center = view.center
        
        UIGraphicsBeginImageContext(imgViewBackground.frame.size)
        imgViewBackground.layer.render(in: UIGraphicsGetCurrentContext()!)
        let imageSave = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        imgView.backgroundColor = UIColor(patternImage: imageSave!)
    }
    
    func tapOnImgViewToHiddenColBackGround(_ sender: UITapGestureRecognizer) {
        colViewBackground.isHidden = true
    }
    
    func setGradient() {
        imgGradient.image = UIImage(named: "CP_Gradient")
        self.view.addSubview(imgGradient)
        
        imgGradient.autoresizesSubviews = false
        imgGradient.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(NSLayoutConstraint(item: imgGradient, attribute: .top, relatedBy: .equal, toItem: slider, attribute: .bottom, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: imgGradient, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: imgGradient, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: imgGradient, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 10))
//        gradientLayer.frame = gradientLayerView.bounds
//        let whiteColorTop = UIColor.whiteColor().CGColor as CGColorRef
//        let blackColorBottom = UIColor.lightGrayColor().CGColor as CGColorRef
//        gradientLayer.colors = [whiteColorTop, blackColorBottom]
//        gradientLayer.locations = [0.0, 1.0]
//        gradientLayerView.layer.addSublayer(gradientLayer)
    }
    
    func colorTemplate() {
        self.view.addSubview(colorPicker)
        
        colorPicker.autoresizesSubviews = false
        colorPicker.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(NSLayoutConstraint(item: colorPicker, attribute: .top, relatedBy: .equal, toItem: imgGradient, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: colorPicker, attribute: .bottom , relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: colorPicker, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: colorPicker, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0))
    }
    
    // MARK: Array source
    func arrBackgroundColorAppend() {
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.black))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.darkGray))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.lightGray))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.white))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.gray))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.red))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.green))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.blue))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.cyan))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.yellow))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.magenta))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.orange))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.purple))
        arrBackgroundColor.append(BackgroundColorModel.init(bgColor: UIColor.brown))
    }
    
    func arrFontAppend() {
        arrFont.append(FontModel.init(listFont: "Copperplate"))
        arrFont.append(FontModel.init(listFont: "Heiti SC"))
        arrFont.append(FontModel.init(listFont: "Avenir"))
        arrFont.append(FontModel.init(listFont: "Thonburi"))
        arrFont.append(FontModel.init(listFont: "Heiti TC"))
        arrFont.append(FontModel.init(listFont: "Courier New"))
        arrFont.append(FontModel.init(listFont: "Gill Sans"))
        arrFont.append(FontModel.init(listFont: "Marker Felt"))
        arrFont.append(FontModel.init(listFont: "Gurmukhi MN"))
        arrFont.append(FontModel.init(listFont: "Georgia"))
        arrFont.append(FontModel.init(listFont: "Kailasa"))
        arrFont.append(FontModel.init(listFont: "Damascus"))
        arrFont.append(FontModel.init(listFont: "Noteworthy"))
        arrFont.append(FontModel.init(listFont: "Geeza Pro"))
    }
}

extension String {
    func trunc(_ length: Int, trailing: String? = "") -> String {
        if self.characters.count > length {
            return self.substring(to: self.characters.index(self.startIndex, offsetBy: length))
        } else {
            return self
        }
    }
}

extension UIImage {
    func resizeWith(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    func resizeWith(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}
