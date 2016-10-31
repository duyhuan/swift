//
//  ViewController.swift
//  EditImage
//
//  Created by huan huan on 10/5/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var arrBackgroundColor: [BackgroundColorModel] = []
    var arrBackgroundImage: [BackgroundImageModel] = []
    var arrPattern: [PatternModel] = []
    let imagePicker = UIImagePickerController()
    let arrFont: [String] = UIFont.familyNames
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
    
    var indexItem = [IndexPath]() {
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
        
        imagePicker.delegate = self
        
        colViewBackground.delegate = self
        colViewBackground.dataSource = self
        colViewBackground.backgroundColor = UIColor.darkGray
        colViewBackground.isHidden = true
        arrBackgroundColorAppend()
        arrPatternAppend()
        arrBackgroundImageAppend()
        
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
        
        setImgViewBackground("1FA6SEYFHF.jpg")
        
        setupSlider()
        imgSmallSize.image = UIImage(named: "CP_SizeSmall")
        imgSmallSize.contentMode = .scaleAspectFit
        imgBigSize.image = UIImage(named: "CP_SizeBig")
        imgBigSize.contentMode = .scaleAspectFit
        addTapGestureOnImgView()
        setupTextColor()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colFont {
            return arrFont.count
        } else {
            if indexItem.first == nil {
                return 0
            }
            if (indexItem.first as NSIndexPath?)?.row == 0 {
                return arrBackgroundColor.count
            } else if (indexItem.first as NSIndexPath?)?.row == 1 {
                return arrPattern.count
            } else if (indexItem.first as NSIndexPath?)?.row == 2 {
                return arrBackgroundImage.count
            } else {
                return 0
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == colFont {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FontCollectionViewCell
            cell.frame.size.width = colFont.frame.size.width / 3
            cell.lblFont.text = arrFont[(indexPath as NSIndexPath).row]
            
            if cell.lblFont.text!.characters.count > 10 {
                cell.lblFont.text = (cell.lblFont.text! as NSString).substring(to: 10)
                cell.lblFont.font = UIFont(name: arrFont[(indexPath as NSIndexPath).row], size: (cell.lblFont.font?.pointSize)!)
            }
            
            if indexFont.index(of: indexPath) == nil {
                cell.lblFont.textColor = UIColor.lightGray
            } else if (indexFont.first as NSIndexPath?)?.row == (indexPath as NSIndexPath).row {
                cell.lblFont.textColor = UIColor.black
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! BackgroundCollectionViewCell
            if (indexItem.first as NSIndexPath?)?.row == 0 {
                let data = arrBackgroundColor[(indexPath as NSIndexPath).row]
                cell.bgColorImage.image = nil
                cell.bgColorImage.backgroundColor = data.bgroundColor
                cell.bgColorImage.layer.borderColor = UIColor.white.cgColor
                cell.bgColorImage.layer.borderWidth = 1
            } else if (indexItem.first! as NSIndexPath).row == 1 {
                let data = arrPattern[(indexPath as NSIndexPath).row]
                cell.bgColorImage.image = nil
                cell.bgColorImage.image = UIImage(named: data.pattern)
                cell.bgColorImage.layer.borderColor = UIColor.white.cgColor
                cell.bgColorImage.layer.borderWidth = 1
            } else if (indexItem.first as NSIndexPath?)?.row == 2 {
                let data = arrBackgroundImage[(indexPath as NSIndexPath).row]
                cell.bgColorImage.image = nil
                cell.bgColorImage.image = UIImage(named: data.backgroundImage)
                cell.bgColorImage.layer.borderColor = UIColor.white.cgColor
                cell.bgColorImage.layer.borderWidth = 1
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == colViewBackground {
            if (indexItem.first as NSIndexPath?)?.row == 0 {
                let data = arrBackgroundColor[(indexPath as NSIndexPath).row]
                imgView.backgroundColor = data.bgroundColor
                btnBackroundColor.backgroundColor = data.bgroundColor
                stSelectBackroundColor.setChosen(true)
                stSelectPattern.setChosen(false)
                stSelectBackgroundTemplate.setChosen(false)
            } else if (indexItem.first as NSIndexPath?)?.row == 1 {
                let data = arrPattern[(indexPath as NSIndexPath).row]
                setImgViewBackground(data.pattern)
                btnPattern.setBackgroundImage(UIImage(named: data.pattern), for: UIControlState())
                stSelectPattern.setChosen(true)
                stSelectBackroundColor.setChosen(false)
                stSelectBackgroundTemplate.setChosen(false)
            } else if (indexItem.first as NSIndexPath?)?.row == 2 {
                let data = arrBackgroundImage[(indexPath as NSIndexPath).row]
                setImgViewBackground(data.backgroundImage)
                btnBackgroundTemplate.setBackgroundImage(UIImage(named: data.backgroundImage), for: UIControlState())
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
                    lbltv.textLbl.font = UIFont(name: arrFont[indexPath.row], size: lblTextView.textLbl.font.pointSize)
                }
            }
        }
    }
    
    // MARK: Actions
    @IBAction func btnAddTextClicked(_ sender: UIButton) {
        lblTextView = LabelTextView()
        lblTextView.frame.size = CGSize(width: 210, height: 40)
        lblTextView.frame.origin = CGPoint(x: (imgView.frame.size.width - lblTextView.frame.size.width) / 2, y: (imgView.frame
            .size.height - lblTextView.frame.size.height) / 2)
        imgView.addSubview(lblTextView)
        
        let panGestureLblTextView: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.lblTextViewPangesture(_:)))
        lblTextView.textLbl.isUserInteractionEnabled = true
        lblTextView.addGestureRecognizer(panGestureLblTextView)
        imgView.isUserInteractionEnabled = true
        
        let tapGestureLblTextView: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.lblTextViewTapgesture(_:)))
        lblTextView.addGestureRecognizer(tapGestureLblTextView)
        arrLblTextView.append(lblTextView)
    }
    
    func lblTextViewPangesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.imgView)
        sender.view?.center = CGPoint(x: translation.x + (sender.view?.center.x)!, y: translation.y + (sender.view?.center.y)!)
        sender.setTranslation(CGPoint.zero, in: imgView)
    }
    
    func lblTextViewTapgesture(_ sender: UITapGestureRecognizer) {
        let point: CGPoint = sender.location(in: imgView)
        for i in 0..<arrLblTextView.count {
            let lbltv = arrLblTextView[i] as! LabelTextView
            if lbltv.textView.isHidden == false {
                lbltv.textView.isHidden = true
                lbltv.textLbl.isHidden = false
                lbltv.topLeftBtn.isHidden = false
                lbltv.topRightBtn.isHidden = false
                lbltv.botRightBtn.isHidden = false
                lbltv.botLeftBtn.isHidden = false
            }
            lbltv.tag = 0
            if point.x >= lbltv.frame.origin.x && point.x <= lbltv.frame.origin.x + lbltv.frame.size.width && point.y >= lbltv.frame.origin.y && point.y <= lbltv.frame.origin.y + lbltv.frame.size.height {
                lbltv.tag = 1
                slider.value = Float(lbltv.textLbl.font.pointSize)
            }
        }
    }
    
    func addTapGestureOnImgView() {
        let tapGestureImgView: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.imgViewTapGesture(_:)))
        imgView.addGestureRecognizer(tapGestureImgView)
    }
    
    func imgViewTapGesture(_ sender: UITapGestureRecognizer) {
        for i in 0..<arrLblTextView.count {
            let a = arrLblTextView[i] as! LabelTextView
            if a.textView.isHidden == false {
                a.textView.isHidden = true
                a.textLbl.isHidden = false
                a.topLeftBtn.isHidden = false
                a.topRightBtn.isHidden = false
                a.botRightBtn.isHidden = false
                a.botLeftBtn.isHidden = false
            }
        }
    }
    
    func setupSlider() {
        slider.minimumValue = 5.0
        slider.maximumValue = 50.0
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
    
    @IBAction func btnBackroundColorClicked(_ sender: UIButton) {
        indexItem.removeAll()
        indexItem.append(IndexPath(row: 0, section: 0))
        colViewBackground.isHidden = false
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
            
            UIGraphicsBeginImageContext(imgView.frame.size)
            imgView.layer.render(in: UIGraphicsGetCurrentContext()!)
            let imageSave = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            UIImageWriteToSavedPhotosAlbum(imageSave!, nil, nil, nil)
            
            lblLogo.removeFromSuperview()
            
            let composeSheet = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            composeSheet?.add(imageSave)
            present(composeSheet!, animated: true, completion: nil)
        }
    }
    
    func setupViewButton() {
        btnBackroundColor.backgroundColor = UIColor.lightGray
        btnPattern.setBackgroundImage(UIImage(named: "smoke4.jpg"), for: UIControlState())
        btnBackgroundTemplate.setBackgroundImage(UIImage(named: "1FA6SEYFHF.jpg"), for: UIControlState())
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
    
    @IBAction func btnPatternClicked(_ sender: UIButton) {
        indexItem.removeAll()
        indexItem.append(IndexPath(row: 1, section: 0))
        colViewBackground.isHidden = false
    }
    
    @IBAction func btnBackgroundTemplateClicked(_ sender: UIButton) {
        indexItem.removeAll()
        indexItem.append(IndexPath(row: 2, section: 0))
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
    
    func setImgViewBackground(_ str: String) {
        let imgViewBackground = UIImageView()
        imgViewBackground.frame = imgView.frame
        imgViewBackground.contentMode =  UIViewContentMode.scaleAspectFill
        imgViewBackground.clipsToBounds = true
        imgViewBackground.image = UIImage(named: str)
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
    func trunc(_ length: Int, trailing: String? = "") -> String {
        if self.characters.count > length {
            return self.substring(to: self.characters.index(self.startIndex, offsetBy: length))
        } else {
            return self
        }
    }
}
