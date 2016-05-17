//
//  FirstViewController.swift
//  晃動事件
//
//  Created by 曾偉亮 on 2015/11/21.
//  Copyright © 2015年 TSENG. All rights reserved.
//

import UIKit
import AudioToolbox

class FirstViewController: UIViewController  {

    
    var shaking:Bool = true //可否搖晃
    var imgView:UIImageView?
    var aryImgs:[UIImage] = [UIImage]()
    
    
//MARK: - Normal function
//---------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //動畫圖片陣列
        for appendObj in 1...3 {
            
            aryImgs.append(UIImage(named: "g\(appendObj).png")!)
        }
        
        //動畫開始前
        //1.顯示晃動手機
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 80))
        label.center = CGPoint(x: self.view.frame.size.width/2, y: 100)
        label.text = "搖 晃 手 機 猜 拳"
        label.textColor = UIColor.blueColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.boldSystemFontOfSize(self.view.frame.size.height/25)
        self.view.addSubview(label)
        
        
        //2.顯示初始畫面
        imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        imgView?.image = UIImage(named: "g1.png")
        imgView?.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        imgView!.animationImages = aryImgs
        self.view.addSubview(imgView!)

    }
    
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        
        if motion == UIEventSubtype.MotionShake && shaking == true {
            
            shaking = false //答案揭曉前不可重覆搖晃
            
            imgView!.animationDuration = 0.3
            imgView!.startAnimating()
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            NSTimer.scheduledTimerWithTimeInterval(1.2, target: self, selector: #selector(FirstViewController.beforeAnimationStop(_:)), userInfo: nil, repeats: false)
            
        }
        
    }
    

//MARK: - beforeAnimationStop
//------------------------------
    func beforeAnimationStop(sender:NSTimer){
        
        imgView?.stopAnimating()
        let i:Int = Int(arc4random() % 3)
        imgView?.image = aryImgs[i]
        
        shaking = true //答案揭曉同時可再次搖
        
    }
    

}

