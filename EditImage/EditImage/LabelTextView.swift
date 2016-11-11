//
//  ResizeButton.swift
//  EditImage
//
//  Created by huan huan on 10/19/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit

class LabelTextView: UIView, UITextViewDelegate{
    
    var textLbl: UILabel = UILabel()
    var topLeftBtn: UIButton = UIButton()
    var topRightBtn: UIButton = UIButton()
    var botRightBtn: UIButton = UIButton()
    var botLeftBtn: UIButton = UIButton()
    let textView: UITextView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    init() {
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        textLbl.text = "Double tap to quote"
        textLbl.layer.borderColor = UIColor.white.cgColor
        textLbl.layer.borderWidth = 0
        textLbl.textAlignment = .center
        textLbl.textColor = UIColor.white
        textLbl.frame = CGRect(x: 5, y: 5, width: 200, height: 30)
        textLbl.isHidden = false
        textLbl.numberOfLines = 0
        textLbl.lineBreakMode = .byWordWrapping
        textLbl.textAlignment = .left
        addSubview(textLbl)
        
        let tapGestureLabel: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LabelTextView.textLblDoubleTapGesture(_:)))
        tapGestureLabel.numberOfTapsRequired = 2
        textLbl.isUserInteractionEnabled = true
        textLbl.addGestureRecognizer(tapGestureLabel)
        
        textView.frame = textLbl.frame
        textView.isHidden = true
        addSubview(textView)
        textView.isScrollEnabled = false
        textView.font = textView.font?.withSize(textLbl.font.pointSize)
        textView.delegate = self
        
        let panTopLeftBtn: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LabelTextView.panTopLeft(_:)))
        addSubview(topLeftBtn)
        topLeftBtn.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: topLeftBtn, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: topLeftBtn, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: topLeftBtn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 10.0))
        addConstraint(NSLayoutConstraint(item: topLeftBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 10.0))
        layoutIfNeeded()
        topLeftBtn.layer.cornerRadius = topLeftBtn.frame.size.width / 2
        topLeftBtn.layer.backgroundColor = UIColor.white.cgColor
        topLeftBtn.layer.borderWidth = 1
        topLeftBtn.isHidden = true
        topLeftBtn.isUserInteractionEnabled = true
        topLeftBtn.addGestureRecognizer(panTopLeftBtn)
        
        let panTopRightBtn: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LabelTextView.panTopRight(_:)))
        addSubview(topRightBtn)
        topRightBtn.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: topRightBtn, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: topRightBtn, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: topRightBtn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 10.0))
        addConstraint(NSLayoutConstraint(item: topRightBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 10.0))
        layoutIfNeeded()
        topRightBtn.layer.cornerRadius = topRightBtn.frame.size.width / 2
        topRightBtn.layer.backgroundColor = UIColor.white.cgColor
        topRightBtn.layer.borderWidth = 1
        topRightBtn.isHidden = true
        topRightBtn.isUserInteractionEnabled = true
        topRightBtn.addGestureRecognizer(panTopRightBtn)
        
        let panBotRightBtn: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LabelTextView.panBotRight(_:)))
        addSubview(botRightBtn)
        botRightBtn.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: botRightBtn, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: botRightBtn, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: botRightBtn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 10.0))
        addConstraint(NSLayoutConstraint(item: botRightBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 10.0))
        layoutIfNeeded()
        botRightBtn.layer.cornerRadius = botRightBtn.frame.size.width / 2
        botRightBtn.layer.backgroundColor = UIColor.white.cgColor
        botRightBtn.layer.borderWidth = 1
        botRightBtn.isHidden = true
        botRightBtn.isUserInteractionEnabled = true
        botRightBtn.addGestureRecognizer(panBotRightBtn)
        
        let panBotLeftBtn: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LabelTextView.panBotLeft(_:)))
        addSubview(botLeftBtn)
        botLeftBtn.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: botLeftBtn, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: botLeftBtn, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: botLeftBtn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 10.0))
        addConstraint(NSLayoutConstraint(item: botLeftBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 10.0))
        layoutIfNeeded()
        botLeftBtn.layer.cornerRadius = botLeftBtn.frame.size.width / 2
        botLeftBtn.layer.backgroundColor = UIColor.white.cgColor
        botLeftBtn.layer.borderWidth = 1
        botLeftBtn.isHidden = true
        botLeftBtn.isUserInteractionEnabled = true
        botLeftBtn.addGestureRecognizer(panBotLeftBtn)
        
        topLeftBtn.frame.origin.x = textLbl.frame.origin.x - topLeftBtn.frame.size.width/2
        topLeftBtn.frame.origin.y = textLbl.frame.origin.y - topLeftBtn.frame.size.height/2
        topRightBtn.frame.origin.x = textLbl.frame.origin.x + textLbl.frame.size.width - topRightBtn.frame.size.width/2
        topRightBtn.frame.origin.y = textLbl.frame.origin.y - topLeftBtn.frame.size.height/2
        botLeftBtn.frame.origin.x = textLbl.frame.origin.x - topLeftBtn.frame.size.width/2
        botLeftBtn.frame.origin.y = textLbl.frame.origin.y + textLbl.frame.size.height - topLeftBtn.frame.size.height/2
        botRightBtn.frame.origin.x = textLbl.frame.origin.x + textLbl.frame.size.width - topLeftBtn.frame.size.width/2
        botRightBtn.frame.origin.y = textLbl.frame.origin.y + textLbl.frame.size.height - topLeftBtn.frame.size.height/2
    }
    
    func panTopLeft(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        sender.view?.center = CGPoint(x: translation.x + (sender.view?.center.x)!, y: translation.y + (sender.view?.center.y)!)
        sender.setTranslation(CGPoint.zero, in: self)
        
        if topLeftBtn.frame.origin.x < topRightBtn.frame.origin.x && topLeftBtn.frame.origin.y < botLeftBtn.frame.origin.y {
            self.frame.origin = CGPoint(x: self.frame.origin.x + translation.x, y: self.frame.origin.y + translation.y)
            self.frame.size = CGSize(width: textLbl.frame.size.width - translation.x + topLeftBtn.frame.size.width, height: textLbl.frame.size.height - translation.y + topLeftBtn.frame.size.height)
        } else if topLeftBtn.frame.origin.x >= topRightBtn.frame.origin.x {
            self.frame.origin = CGPoint(x: self.frame.origin.x - translation.x, y: self.frame.origin.y)
            self.frame.size = CGSize(width: textLbl.frame.size.width + translation.x + topLeftBtn.frame.size.width, height: textLbl.frame.size.height - translation.y + topLeftBtn.frame.size.height)
        } else if topLeftBtn.frame.origin.y >= botLeftBtn.frame.origin.y {
            self.frame.origin = CGPoint(x: self.frame.origin.x, y: self.frame.origin.y - translation.y)
            self.frame.size = CGSize(width: textLbl.frame.size.width - translation.x + topLeftBtn.frame.size.width, height: textLbl.frame.size.height + translation.y + topLeftBtn.frame.size.height)
        }
        setFontLabel()
    }
    
    func panTopRight(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        sender.view?.center = CGPoint(x: translation.x + (sender.view?.center.x)!, y: translation.y + (sender.view?.center.y)!)
        sender.setTranslation(CGPoint.zero, in: self)
        
        if topRightBtn.frame.origin.x > topLeftBtn.frame.origin.x && topRightBtn.frame.origin.y < botRightBtn.frame.origin.y {
            self.frame.origin = CGPoint(x: self.frame.origin.x, y: self.frame.origin.y + translation.y)
            self.frame.size = CGSize(width: textLbl.frame.size.width + translation.x + topLeftBtn.frame.size.width, height: textLbl.frame.size.height - translation.y + topLeftBtn.frame.size.height)
        } else if topRightBtn.frame.origin.x <= topLeftBtn.frame.origin.x {
            self.frame.origin = CGPoint(x: self.frame.origin.x, y: self.frame.origin.y - translation.y)
            self.frame.size = CGSize(width: textLbl.frame.size.width - translation.x + topLeftBtn.frame.size.width, height: textLbl.frame.size.height - translation.y + topLeftBtn.frame.size.height)
        } else if topRightBtn.frame.origin.y >= botRightBtn.frame.origin.y {
            self.frame.origin = CGPoint(x: self.frame.origin.x, y: self.frame.origin.y - translation.y)
            self.frame.size = CGSize(width: textLbl.frame.size.width + translation.x + topLeftBtn.frame.size.width, height: textLbl.frame.size.height + translation.y + topLeftBtn.frame.size.height)
        }
        setFontLabel()
    }
    
    func panBotRight(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        sender.view?.center = CGPoint(x: translation.x + (sender.view?.center.x)!, y: translation.y + (sender.view?.center.y)!)
        sender.setTranslation(CGPoint.zero, in: self)
        
        if botRightBtn.frame.origin.x > botLeftBtn.frame.origin.x && botRightBtn.frame.origin.y > topRightBtn.frame.origin.y {
            self.frame.size = CGSize(width: textLbl.frame.size.width + translation.x + topLeftBtn.frame.size.width, height: textLbl.frame.size.height + translation.y + topLeftBtn.frame.size.height)
        } else if botRightBtn.frame.origin.x <= botLeftBtn.frame.origin.x {
            self.frame.origin = CGPoint(x: self.frame.origin.x, y: self.frame.origin.y + translation.y)
            self.frame.size = CGSize(width: textLbl.frame.size.width - translation.x + topLeftBtn.frame.size.width, height: textLbl.frame.size.height + translation.y + topLeftBtn.frame.size.height)
        } else if botRightBtn.frame.origin.y <= topRightBtn.frame.origin.y {
            self.frame.origin = CGPoint(x: self.frame.origin.x + translation.x, y: self.frame.origin.y)
            self.frame.size = CGSize(width: textLbl.frame.size.width + translation.x + topLeftBtn.frame.size.width, height: textLbl.frame.size.height - translation.y + topLeftBtn.frame.size.height)
        }
        setFontLabel()
    }
    
    func panBotLeft(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        sender.view?.center = CGPoint(x: translation.x + (sender.view?.center.x)!, y: translation.y + (sender.view?.center.y)!)
        sender.setTranslation(CGPoint.zero, in: self)
        
        if botLeftBtn.frame.origin.x < botRightBtn.frame.origin.x && botLeftBtn.frame.origin.y > topLeftBtn.frame.origin.y {
            self.frame.origin = CGPoint(x: self.frame.origin.x + translation.x, y: self.frame.origin.y)
            self.frame.size = CGSize(width: textLbl.frame.size.width - translation.x + topLeftBtn.frame.size.width, height: textLbl.frame.size.height + translation.y + topLeftBtn.frame.size.height)
            
        } else if botLeftBtn.frame.origin.x >= botRightBtn.frame.origin.x {
            self.frame.origin = CGPoint(x: self.frame.origin.x - translation.x, y: self.frame.origin.y)
            self.frame.size = CGSize(width: textLbl.frame.size.width + translation.x + topLeftBtn.frame.size.width, height: textLbl.frame.size.height + translation.y + topLeftBtn.frame.size.height)
        } else if botLeftBtn.frame.origin.y <= topLeftBtn.frame.origin.y {
            self.frame.origin = CGPoint(x: self.frame.origin.x + translation.x, y: self.frame.origin.y)
            self.frame.size = CGSize(width: textLbl.frame.size.width - translation.x + topLeftBtn.frame.size.width, height: textLbl.frame.size.height - translation.y + topLeftBtn.frame.size.height)
        }
        setFontLabel()
    }
    
    func setFontLabel() {
        textView.frame = textLbl.frame
        textLbl.frame.size = CGSize(width: self.frame.size.width - 10, height: self.frame.size.height - 10)
        
        let markerSize: CGFloat = 25
        let width = frame.size.width - markerSize
        let height = frame.size.height - markerSize
        var fontSize: CGFloat = 200
        let minFontSize: CGFloat = 5
        let constrainSize = CGSize(width: width, height: CGFloat(MAXFLOAT))
        while fontSize > minFontSize {
            textLbl.font = UIFont.init(name: (textLbl.font?.fontName)!, size: fontSize)
            let rect = (textLbl.text! as NSString).boundingRect(with: constrainSize, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: textLbl.font!], context: nil)
            if rect.size.height < height{
                break
            }
            fontSize -= 1
        }
        textLbl.center = CGPoint(x: frame.width/2, y: frame.height/2)
    }
    
    func textLblDoubleTapGesture(_ sender: UITapGestureRecognizer) {
        textLbl.isHidden = true
        textView.isHidden = false
        textView.becomeFirstResponder()
        textView.font = textView.font?.withSize(textLbl.font.pointSize)
        topLeftBtn.isHidden = true
        topRightBtn.isHidden = true
        botRightBtn.isHidden = true
        botLeftBtn.isHidden = true
    }
    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        textLbl.isHidden = false
//        textView.isHidden = true
//        if textView.text != "" {
//            textLbl.text = textView.text
//        } else {
//            textLbl.text = "Double tap to quote"
//        }
////        topLeftBtn.isHidden = false
////        topRightBtn.isHidden = false
////        botRightBtn.isHidden = false
////        botLeftBtn.isHidden = false
//    }
}
