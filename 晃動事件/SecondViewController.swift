//
//  SecondViewController.swift
//  晃動事件
//
//  Created by 曾偉亮 on 2015/11/21.
//  Copyright © 2015年 TSENG. All rights reserved.
//

import UIKit
import AudioToolbox

class SecondViewController: UIViewController {

    var shakingNow:Bool = true
    var imgView:UIImageView?
    var aryImg:[UIImage] = [UIImage]()
    var showResultLabel:UILabel?

//MARK: - Normal function
//---------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        //動畫圖片陣列
        for appendObj in 1...6 {
            
            aryImg.append(UIImage(named: "point_0\(appendObj).png")!)
        }
        
        
        //螢幕搖晃前的畫面
        //1.顯示搖晃手機擲骰子
        let labelTitle:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 80))
        labelTitle.center = CGPoint(x: self.view.frame.size.width/2, y: 100)
        labelTitle.text = "搖 晃 手 機 擲 骰 子"
        labelTitle.textColor = UIColor.blueColor()
        labelTitle.textAlignment = NSTextAlignment.Center
        labelTitle.font = UIFont.boldSystemFontOfSize(self.view.frame.size.height/25)
        self.view.addSubview(labelTitle)
        
        //2.顯示point01的圖片
        imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 360, height: 360))
        imgView!.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        imgView!.image = UIImage(named: "point_01.png")
        imgView!.animationImages = aryImg
        self.view.addSubview(imgView!);

        
    }
    


    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        
        if motion == UIEventSubtype.MotionShake && shakingNow == true {
            
            if showResultLabel != nil {
                
                showResultLabel?.removeFromSuperview()
                showResultLabel = nil
            }
            
            shakingNow = false
            imgView!.animationDuration = 0.6
            imgView?.startAnimating()
            
            
            //搖晃時允許手機震動
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            NSTimer.scheduledTimerWithTimeInterval(1.2, target: self, selector: #selector(SecondViewController.beforeAnimationStop(_:)), userInfo: nil, repeats: false)
            

        }
        
    }

    
    
//MARK: - beforeAnimationStop
//---------------------------------
    func beforeAnimationStop(sender:NSTimer){
        
        imgView?.stopAnimating()
        let i:Int = Int(arc4random() % 6)
        imgView?.image = aryImg[i]
        
        //showResultLabel
        showResultLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/3, height: self.view.frame.size.width/3))
        showResultLabel?.center = CGPoint(x: self.view.center.x, y: self.view.frame.size.height/10*7.5)
        showResultLabel?.textAlignment = NSTextAlignment.Center
        showResultLabel?.font = UIFont.systemFontOfSize(showResultLabel!.frame.size.width*0.38)
        showResultLabel?.textColor = UIColor.redColor()
        showResultLabel?.text = "\(i+1) 點"
        self.view.addSubview(showResultLabel!)
        
        shakingNow = true
        
    }
    
    

}

