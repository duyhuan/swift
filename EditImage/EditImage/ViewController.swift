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
    
    var arrItem: [ItemModel] = []
    var arrBackgroundColor: [BackgroundColorModel] = []
    var arrBackgroundImage: [BackgroundImageModel] = []
    var arrPattern: [PatternModel] = []
    let imagePicker = UIImagePickerController()
    let userDF: NSUserDefaults = NSUserDefaults()
    let imgItem: UIImageView = UIImageView()
    let gradientLayer: CAGradientLayer = CAGradientLayer()
    
    var indexItem = [NSIndexPath]() {
        didSet {
            colViewBackgroundColor.reloadData()
        }
    }
    
    var indexBackground = [NSIndexPath]()
        {
        didSet {
            //colViewItem.reloadData()
        }
    }
    
    let arrFont: [String] = UIFont.familyNames()
    
    @IBOutlet var colViewItem: UICollectionView!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var colViewBackgroundColor: UICollectionView!
    @IBOutlet var colFont: UICollectionView!
    @IBOutlet var slider: UISlider!
    @IBOutlet var gradientLayerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colViewItem.delegate = self
        colViewItem.dataSource = self
        colViewBackgroundColor.delegate = self
        colViewBackgroundColor.dataSource = self
        colViewBackgroundColor.backgroundColor = UIColor.darkGrayColor()
        colViewBackgroundColor.hidden = true
        
        arrItemAppend()
        arrBackgroundColorAppend()
        arrPatternAppend()
        arrBackgroundImageAppend()
        
        imgItem.image = UIImage(named: "CP_Selected")
        imgView.image = UIImage(named: "1FA6SEYFHF.jpg")
        
        colFont.delegate = self
        colFont.dataSource = self
        
        processGradientLayer()
        colorTemplate()
    }
    
    // MARK: Add Text
    @IBAction func btnAddTextClicked(sender: UIButton) {
        let lblText: UILabel = UILabel()
        lblText.text = "Double tap to quote"
        lblText.layer.borderColor = UIColor.whiteColor().CGColor
        lblText.layer.borderWidth = 1
        lblText.frame.size = CGSize(width: 150, height: 70)
        lblText.textAlignment = .Center
        lblText.textColor = UIColor.whiteColor()
        imgView.addSubview(lblText)
        
        lblText.autoresizesSubviews = false
        lblText.translatesAutoresizingMaskIntoConstraints = false
        
        let h = (imgView.frame.size.height - lblText.frame.size.height)/2
        let w = (imgView.frame.size.width - lblText.frame.size.width)/2
        print(w)
        imgView.addConstraint(NSLayoutConstraint(item: lblText, attribute: .Top, relatedBy: .Equal, toItem: imgView, attribute: .Top, multiplier: 1, constant: h))
        imgView.addConstraint(NSLayoutConstraint(item: lblText, attribute: .Leading, relatedBy: .Equal, toItem: imgView, attribute: .Leading, multiplier: 1, constant: w))
    }
    
    // MARK: Share on the face
    @IBAction func btnShareOnFaceClicked(sender: UIButton) {
        let composeSheet = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        composeSheet.addImage(imgView.image)
        presentViewController(composeSheet, animated: true, completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colViewItem {
            return arrItem.count
        } else if collectionView == colFont {
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
        if collectionView == colViewItem {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! OptionsCollectionViewCell
            let data = arrItem[indexPath.row]
            cell.imageOption.image = UIImage(named: data.items)
            
            if indexPath.row == 0 && indexPath.row == indexItem.first?.row {
                cell.imageOption.image = nil
                cell.imageOption.backgroundColor = imgView.backgroundColor
            } else if indexPath.row == 1 &&  indexPath.row == indexItem.first?.row {
                cell.imageOption.image = imgView.image
            } else if indexPath.row == 2 && indexPath.row == indexItem.first?.row {
                cell.imageOption.image = imgView.image
            }
            
            return cell
        } else if collectionView == colFont {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! FontCollectionViewCell
            cell.lblFont.text = arrFont[indexPath.row]
            cell.lblFont.font = UIFont(name: arrFont[indexPath.row], size: (cell.lblFont.font?.pointSize)!)
            return cell
        }else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! BackgroundCollectionViewCell
            if indexItem.first?.row == 0{
                let data = arrBackgroundColor[indexPath.row]
                cell.bgColorImage.image = nil
                cell.bgColorImage.backgroundColor = data.bgroundColor
                cell.bgColorImage.layer.borderColor = UIColor.whiteColor().CGColor
                cell.bgColorImage.layer.borderWidth = 1
            } else if indexItem.first?.row == 1{
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
        if collectionView == colViewItem {
            indexItem.removeAll()
            indexItem.append(indexPath)
            
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as! OptionsCollectionViewCell
            imgItem.frame = cell.imageOption.frame
            cell.addSubview(imgItem)
            colViewBackgroundColor.hidden = false
            if indexPath.row == 3 {
                colViewBackgroundColor.hidden = true
            } else if indexPath.row == 4 {
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .PhotoLibrary
                presentViewController(imagePicker, animated: true, completion: nil)
                colViewBackgroundColor.hidden = true
            }
        } else if collectionView == colViewBackgroundColor {
            indexBackground.removeAll()
            indexBackground.append(indexPath)
            
            if indexItem.first?.row == 0 {
                imgView.image = nil
                let data = arrBackgroundColor[indexPath.row]
                imgView.backgroundColor = data.bgroundColor
            } else if indexItem.first?.row == 1 {
                imgView.image = nil
                let data = arrPattern[indexPath.row]
                imgView.image = UIImage(named: data.pattern)
            } else if indexItem.first?.row == 2 {
                imgView.image = nil
                let data = arrBackgroundImage[indexPath.row]
                imgView.image = UIImage(named: data.backgroundImage)
            }
        }
    }
    
    // MARK: arrItem
    func arrItemAppend(){
        arrItem.append(ItemModel.init(item: "FF0000.jpg"))
        arrItem.append(ItemModel.init(item: "smoke4.jpg"))
        arrItem.append(ItemModel.init(item: "0CUCBJX4FZ.jpg"))
        arrItem.append(ItemModel.init(item: "CP_Camera"))
        arrItem.append(ItemModel.init(item: "CP_Photo"))
    }
    
    // MARK: arrBackgroundColor
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
    
    // MARK: arrPattern
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
    
    // MARK: arrBackgroundImage
    func arrBackgroundImageAppend() {
        arrBackgroundImage.append(BackgroundImageModel.init(bgImg: "0CUCBJX4FZ.jpg"))
        arrBackgroundImage.append(BackgroundImageModel.init(bgImg: "1FA6SEYFHF.jpg"))
        arrBackgroundImage.append(BackgroundImageModel.init(bgImg: "2A1RBTLS50.jpg"))
        arrBackgroundImage.append(BackgroundImageModel.init(bgImg: "GEJ6ML9NHQ.jpg"))
        arrBackgroundImage.append(BackgroundImageModel.init(bgImg: "ZOL7UI7UE6.jpg"))
    }
    
    // MARK: processGradientLayer
    func processGradientLayer() {
        gradientLayer.frame = gradientLayerView.bounds
        let whiteColorTop = UIColor.whiteColor().CGColor as CGColorRef
        let blackColorBottom = UIColor.lightGrayColor().CGColor as CGColorRef
        gradientLayer.colors = [whiteColorTop, blackColorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayerView.layer.addSublayer(gradientLayer)
    }
    
    // MARK: colorTemplate
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
}

// MARK:
internal protocol HSBColorPickerDelegate : NSObjectProtocol {
    func HSBColorColorPickerTouched(sender:HSBColorPicker, color:UIColor, point:CGPoint, state:UIGestureRecognizerState)
}
@IBDesignable class HSBColorPicker : UIView {
    
    weak internal var delegate: HSBColorPickerDelegate?
    let saturationExponentTop:Float = 2.0
    let saturationExponentBottom:Float = 1.3
    
    @IBInspectable var elementSize: CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private func initialize() {
        self.clipsToBounds = true
        let touchGesture = UILongPressGestureRecognizer(target: self, action: #selector(HSBColorPicker.touchedColor(_:)))
        touchGesture.minimumPressDuration = 0
        touchGesture.allowableMovement = CGFloat.max
        self.addGestureRecognizer(touchGesture)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        for y in (0 as CGFloat).stride(to: rect.height, by: elementSize) {
            
            var saturation = y < rect.height / 2.0 ? CGFloat(2 * y) / rect.height : 2.0 * CGFloat(rect.height - y) / rect.height
            saturation = CGFloat(powf(Float(saturation), y < rect.height / 2.0 ? saturationExponentTop : saturationExponentBottom))
            let brightness = y < rect.height / 2.0 ? CGFloat(1.0) : 2.0 * CGFloat(rect.height - y) / rect.height
            
            for x in (0 as CGFloat).stride(to: rect.width, by: elementSize) {
                let hue = x / rect.width
                let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
                CGContextSetFillColorWithColor(context, color.CGColor)
                CGContextFillRect(context, CGRect(x:x, y:y, width:elementSize,height:elementSize))
            }
        }
    }
    
    func getColorAtPoint(point:CGPoint) -> UIColor {
        let roundedPoint = CGPoint(x:elementSize * CGFloat(Int(point.x / elementSize)),
                                   y:elementSize * CGFloat(Int(point.y / elementSize)))
        var saturation = roundedPoint.y < self.bounds.height / 2.0 ? CGFloat(2 * roundedPoint.y) / self.bounds.height
            : 2.0 * CGFloat(self.bounds.height - roundedPoint.y) / self.bounds.height
        saturation = CGFloat(powf(Float(saturation), roundedPoint.y < self.bounds.height / 2.0 ? saturationExponentTop : saturationExponentBottom))
        let brightness = roundedPoint.y < self.bounds.height / 2.0 ? CGFloat(1.0) : 2.0 * CGFloat(self.bounds.height - roundedPoint.y) / self.bounds.height
        let hue = roundedPoint.x / self.bounds.width
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
    
    func getPointForColor(color:UIColor) -> CGPoint {
        var hue:CGFloat=0;
        var saturation:CGFloat=0;
        var brightness:CGFloat=0;
        color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil);
        
        var yPos:CGFloat = 0
        let halfHeight = (self.bounds.height / 2)
        
        if (brightness >= 0.99) {
            let percentageY = powf(Float(saturation), 1.0 / saturationExponentTop)
            yPos = CGFloat(percentageY) * halfHeight
        } else {
            //use brightness to get Y
            yPos = halfHeight + halfHeight * (1.0 - brightness)
        }
        
        let xPos = hue * self.bounds.width
        
        return CGPoint(x: xPos, y: yPos)
    }
    
    func touchedColor(gestureRecognizer: UILongPressGestureRecognizer){
        let point = gestureRecognizer.locationInView(self)
        let color = getColorAtPoint(point)
        
        self.delegate?.HSBColorColorPickerTouched(self, color: color, point: point, state:gestureRecognizer.state)
    }
}

