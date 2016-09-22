//
//  ViewController.swift
//  Demo63_TestTextEditor
//
//  Created by BuiDuyTuan on 9/21/16.
//  Copyright © 2016 BuiDuyTuan. All rights reserved.
//

import UIKit

class ViewController1: UIViewController, UITextViewDelegate {
    
    var txtView:UITextView!
    var btnDragRight:UIView!
    var btnDragLeft:UIView!
    var btnDragTop:UIView!
    var btnDragBottom:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtView = UITextView(frame: CGRectMake(0, 0, 200, 30))
        txtView.center = CGPointMake(self.view.center.x, self.view.center.y)
        txtView.textAlignment = NSTextAlignment.Left
        txtView.text = "TEXT"
        txtView.textColor = UIColor.blueColor()
        txtView.backgroundColor = UIColor.clearColor()
        txtView.userInteractionEnabled = true
        view.addSubview(txtView)
        txtView.layer.borderColor = UIColor.grayColor().CGColor
        txtView.layer.borderWidth = 1
        txtView.delegate = self
        
        
        btnDragRight = UIView(frame: CGRectMake(0,0,10,10))
        btnDragRight.center = CGPointMake(self.view.center.x + 100, self.view.center.y)
        btnDragRight.layer.cornerRadius = 5
        btnDragRight.layer.borderWidth = 1
        btnDragRight.layer.borderColor = UIColor.blueColor().CGColor
        btnDragRight.backgroundColor = UIColor.redColor()
        self.view.addSubview(btnDragRight)
        //self.view.bringSubviewToFront(btnDragRight)
        btnDragLeft = UIView(frame: CGRectMake(0,0,10,10))
        btnDragLeft.center = CGPointMake(self.view.center.x - 100, self.view.center.y)
        btnDragLeft.layer.cornerRadius = 5
        btnDragLeft.layer.borderWidth = 1
        btnDragLeft.layer.borderColor = UIColor.blueColor().CGColor
        btnDragLeft.backgroundColor = UIColor.redColor()
        self.view.addSubview(btnDragLeft)
        self.view.bringSubviewToFront(btnDragLeft)
        btnDragTop = UIView(frame: CGRectMake(0,0,10,10))
        btnDragTop.center = CGPointMake(self.view.center.x, self.view.center.y - 15)
        btnDragTop.layer.cornerRadius = 5
        btnDragTop.layer.borderWidth = 1
        btnDragTop.layer.borderColor = UIColor.blueColor().CGColor
        btnDragTop.backgroundColor = UIColor.redColor()
        self.view.addSubview(btnDragTop)
        self.view.bringSubviewToFront(btnDragTop)
        btnDragBottom = UIView(frame: CGRectMake(0,0,10,10))
        btnDragBottom.center = CGPointMake(self.view.center.x , self.view.center.y + 15)
        btnDragBottom.layer.cornerRadius = 5
        btnDragBottom.layer.borderWidth = 1
        btnDragBottom.layer.borderColor = UIColor.blueColor().CGColor
        btnDragBottom.backgroundColor = UIColor.redColor()
        self.view.addSubview(btnDragBottom)
        self.view.bringSubviewToFront(btnDragBottom)

    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            
            let position = touch.locationInView(self.view)
            let prevous = touch.previousLocationInView(self.view)
            let dis = position.x - prevous.x
            let dis_y = position.y - prevous.y
            if touch.view === self.btnDragRight{
                
                txtView.frame.size.width += dis
                btnDragRight.frame.origin.x += dis
                btnDragTop.frame.origin.x += dis/2
                btnDragBottom.frame.origin.x += dis/2
            } else if touch.view === self.btnDragLeft{
                txtView.frame.size.width -= dis
                txtView.frame.origin.x += dis
                btnDragLeft.frame.origin.x += dis
                btnDragTop.frame.origin.x += dis/2
                btnDragBottom.frame.origin.x += dis/2
            } else if touch.view === self.btnDragTop{
                txtView.frame.size.height -= dis_y
                txtView.frame.origin.y += dis_y
                btnDragTop.frame.origin.y += dis_y
                btnDragRight.frame.origin.y += dis_y/2
                btnDragLeft.frame.origin.y += dis_y/2
            }else if touch.view === self.btnDragBottom{
                txtView.frame.size.height += dis_y
                btnDragBottom.frame.origin.y += dis_y
                btnDragRight.frame.origin.y += dis_y/2
                btnDragLeft.frame.origin.y += dis_y/2
            }

        }
    }
}

