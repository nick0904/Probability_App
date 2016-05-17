//
//  FourthViewController.swift
//  晃動事件
//
//  Created by 曾偉亮 on 2015/12/2.
//  Copyright © 2015年 TSENG. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {

//MARK: - Property & Variable
//---------------------------------------
    var aryImgs = [UIImage]() //圖片陣列
    var imgView:UIImageView?
    var swipeGesture:UISwipeGestureRecognizer? //滑動手勢
    var swipe:Bool?
    var label:UILabel?
    
    
//MARK: - Normal function
//---------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        //aryImgs & imgView
        for appendObj in 0 ... 7 {
            
            aryImgs.append(UIImage(named: "yesno_\(appendObj).png")!)
        }
        
        
        imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 390 , height: 400))
        imgView?.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        imgView?.image = UIImage(named: "yesno_2")
        imgView?.animationImages = aryImgs
        self.view.addSubview(imgView!)
        
        //swipeGesture
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(FourthViewController.swipeAction))
        swipeGesture?.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeGesture!)
        
        //swipe:Bool
        swipe = false
        
        //tip
        let tip:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 280, height: 50))
        tip.center = CGPoint(x: self.view.frame.size.width/2, y: 100)
        tip.text = "向右滑動旋轉 ➡︎ ➡︎"
        tip.textAlignment = NSTextAlignment.Center
        tip.textColor = UIColor.whiteColor()
        tip.font = UIFont.systemFontOfSize(25.0)
        self.view.addSubview(tip)
    }
    

//MARK: - swipeAction
//------------------------------
    func swipeAction(){
        
        if swipe == false {
        
            if label != nil {
                
                label?.removeFromSuperview()
                label?.text = nil
            }
            
            swipe = true
            imgView?.animationDuration = 0.18
            imgView?.startAnimating()
            
            NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(FourthViewController.result), userInfo: nil, repeats: false)
        
        }
    }
    
    
//MARK: - stopAnimation(停止轉動並顯示結果)
//------------------------------
    func result(){
        
        imgView?.stopAnimating()
        
        //label
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        label?.center = CGPoint(x: self.view.frame.size.width/2 + 20, y:self.view.frame.size.height - 125)
        label?.textAlignment = NSTextAlignment.Center
        label?.font = UIFont.systemFontOfSize(35.0)
        
        var i:Int?
        i = Int (arc4random() % 4)
        
        switch i! {
            
        case 0:
            imgView?.image = UIImage(named: "yesno_0.png")
            label?.text = "YES"
            label?.textColor = UIColor.whiteColor()
        case 1:
            imgView?.image = UIImage(named: "yesno_3.png")
            label?.text = "NO"
            label?.textColor = UIColor.redColor()
        case 2:
            imgView?.image = UIImage(named: "yesno_1.png")
            label?.text = "YES"
            label?.textColor = UIColor.whiteColor()
        case 3:
            imgView?.image = UIImage(named: "yesno_4.png")
            label?.text = "NO"
            label?.textColor = UIColor.redColor()
        default:
            break
        }
        
        self.view.addSubview(label!)
        
        NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(FourthViewController.swipeReaction), userInfo: nil, repeats: false)
        
    }

//MARK: - swipeReaction
//------------------------------
    func swipeReaction(){
        
        swipe = false
    }

}
