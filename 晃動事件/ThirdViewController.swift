//
//  ThirdViewController.swift
//  晃動事件
//
//  Created by 曾偉亮 on 2015/11/21.
//  Copyright © 2015年 TSENG. All rights reserved.
//

import UIKit
import AudioToolbox

class ThirdViewController: UIViewController {
    
    //MARK: - Property & Variable
    var m_topLabel:UILabel?
    var m_ropeImgView:UIImageView? //顯示擲筊
    var m_swipGestureUp:UISwipeGestureRecognizer? //向上滑動手勢
    var m_aryAnimationImgViewUp = [UIImage]() //向上動畫陣列
    var m_aryAnimationImgViewDown = [UIImage]() //向下動畫陣列
    var m_aryAnmationImgGround = [UIImage]() //落地動畫陣列

    //MARK: - 重力及碰撞行為 相關宣告
    var m_dynamicAnimator:UIDynamicAnimator? //動力動畫
    var m_grivaty:UIGravityBehavior? //重力行為
    var m_collision:UICollisionBehavior? //碰撞行為
    var m_boundary:UIView?
    
    //MARK: - decree 聖旨
    var m_decree01:UIImageView?
    var m_decree02:UIImageView?
    var m_decreeButtom:UIView?
    var m_decreePaper:UIView?
    var m_decreeText:UILabel?
    
    var m_originPosition:CGPoint?
    var m_midPosition:CGPoint?
    var m_topPostion:CGPoint?
    
    var m_timer:NSTimer?
    
//MARK: - Normal function
//-------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        //m_topLabel
        m_topLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height/18))
        m_topLabel?.center = CGPoint(x: self.view.frame.size.width/2, y: m_topLabel!.frame.size.height*2)
        m_topLabel?.textAlignment = NSTextAlignment.Center
        m_topLabel?.textColor = UIColor.blueColor()
        m_topLabel?.font = UIFont.boldSystemFontOfSize(m_topLabel!.frame.size.height * 0.68)
        m_topLabel?.adjustsFontSizeToFitWidth = true
        m_topLabel?.text = "向 上 滑 動 擲 筊 ⬆︎ "
        self.view.addSubview(m_topLabel!)
        
        //Positions
        m_originPosition = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/8*6)
        m_midPosition = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/8*4)
        m_topPostion = CGPoint(x: self.view.frame.size.width/2, y:self.view.frame.size.height/8*2)
        
        //ropeImgView 顯示擲筊
        let ropeWidth:CGFloat = self.view.frame.size.width/2.5
        m_ropeImgView = UIImageView(frame: CGRect(x: 0, y: 0, width: ropeWidth, height: ropeWidth))
        m_ropeImgView?.center = CGPoint(x: m_originPosition!.x, y: m_originPosition!.y)
        m_ropeImgView?.image = UIImage(named: "rope03.png")
        //m_ropeImgView?.backgroundColor = UIColor.blueColor()
        self.view.addSubview(m_ropeImgView!)
        
        //swipGestureUp 向上滑動手勢
        m_swipGestureUp = UISwipeGestureRecognizer(target: self, action: #selector(ThirdViewController.onSwipGestureUpAction(_:)))
        m_swipGestureUp?.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(m_swipGestureUp!)
        
        //boundary 碰撞行為的邊界
        let boundaryH = self.view.frame.size.height/8
        m_boundary = UIView(frame: CGRect(x: 0, y: self.view.frame.size.height - boundaryH/2, width: self.view.frame.size.width, height: boundaryH))
        self.view.addSubview(m_boundary!)
        
        //m_aryAnimationImgViewUp 向上動畫圖片陣列
        m_aryAnimationImgViewUp =
            [UIImage(named: "rope03.png")!,
             UIImage(named: "rope04.png")!,
             UIImage(named: "rope05.png")!]
        
        //m_aryAnimationImgViewDown 向下動畫圖片陣列
        m_aryAnimationImgViewDown =
            [UIImage(named: "rope05.png")!,
             UIImage(named: "rope05.png")!,
             UIImage(named: "rope05.png")!,
             UIImage(named: "rope05.png")!,
             UIImage(named: "rope04.png")!,
             UIImage(named: "rope06.png")!,
             UIImage(named: "rope03.png")!]
        
        //m_aryAnmationImgGround 落地動畫圖片陣列
        m_aryAnmationImgGround = [UIImage(named: "rope07.png")!,
                                  UIImage(named: "rope06.png")!,
                                  UIImage(named: "rope03.png")!,
                                  UIImage(named: "rope02.png")!,
                                  UIImage(named: "rope00.png")!,
                                  UIImage(named: "rope01.png")!]
    }

    

    
//MARK: - onSwipGestureUpAction
//-------------------------------
    func onSwipGestureUpAction(sender:UISwipeGestureRecognizer) {
        
        if m_swipGestureUp!.direction == UISwipeGestureRecognizerDirection.Up {
        
            self.view.removeGestureRecognizer(m_swipGestureUp!)
            self.animationPoisitionUp(CGPoint(x: m_originPosition!.x, y: m_originPosition!.y), firstImg: UIImage(named: "rope03.png")!, toPositon: CGPoint(x: m_topPostion!.x, y: m_topPostion!.y), secondImg: UIImage(named: "rope05.png")!, time: 0.58)
            m_topLabel?.text = ""
        }
    }
    
//MARK: - animationPoisitionUp
//-------------------------------
    func animationPoisitionUp(fromPosision:CGPoint, firstImg:UIImage, toPositon:CGPoint, secondImg:UIImage,time:NSTimeInterval) {
        
        
        m_ropeImgView?.center = CGPoint(x: fromPosision.x, y: fromPosision.y)
        m_ropeImgView?.image = firstImg
        
        UIView.beginAnimations("ropeAnimation", context: nil)
        UIView.setAnimationDuration(time)
        m_ropeImgView?.center = CGPoint(x: toPositon.x, y: toPositon.y)
        m_ropeImgView?.animationImages = m_aryAnimationImgViewUp
        m_ropeImgView?.animationDuration = time
        m_ropeImgView?.startAnimating()
        UIView.commitAnimations()
        
        NSTimer.scheduledTimerWithTimeInterval(time - 0.1, target: self, selector: #selector(ThirdViewController.fromButtomToTopStopAnimation(_:)), userInfo: nil, repeats: false)
    
    }
    
//MARK: - fromButtomToTopStopAnimation
//-------------------------------
    func fromButtomToTopStopAnimation(sneder:NSTimer){
        
        m_ropeImgView?.stopAnimating()
        m_ropeImgView?.animationImages = m_aryAnimationImgViewDown
        self.onGravityAction()
    }
    
    
//MARK: - onGrivatyAction
//-------------------------------
    func onGravityAction() {
        
        let time:Double = 0.88
        
        m_ropeImgView?.animationDuration = time
        m_ropeImgView?.startAnimating()
        
        //重力行為
        m_grivaty = UIGravityBehavior()
        m_grivaty?.addItem(m_ropeImgView!)
        
        
        //碰撞行為
        m_collision = UICollisionBehavior()
        m_collision?.addItem(m_ropeImgView!)
        m_collision?.addBoundaryWithIdentifier("m_boundary", forPath: UIBezierPath(rect: m_boundary!.frame))
        
        //動力動畫
        m_dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        m_dynamicAnimator?.addBehavior(m_grivaty!)
        m_dynamicAnimator?.addBehavior(m_collision!)
        
        NSTimer.scheduledTimerWithTimeInterval(time - 0.1, target: self, selector: #selector(ThirdViewController.fromTopToButtomStopAnimation), userInfo: nil, repeats: false)
    }
    
//MARK: - fromTopToButtomStopAnimation
//-------------------------------
    func fromTopToButtomStopAnimation() {
        
        m_ropeImgView?.stopAnimating()
        m_ropeImgView?.animationImages = m_aryAnmationImgGround
        self.onGroundAction()
    }
    
//MARK: - onGroundAction
//-------------------------------
    func onGroundAction() {
        
        m_ropeImgView?.animationDuration = 0.38
        m_ropeImgView?.startAnimating()
        NSTimer.scheduledTimerWithTimeInterval(0.68, target: self, selector: #selector(ThirdViewController.stopGroundAction), userInfo: nil, repeats: false)
    }
    
//MARK: - stopGroundAction
//-------------------------------
    func stopGroundAction() {
        
        m_ropeImgView?.stopAnimating()
        self.result()
    }
    
//MARK: - result
//-------------------------------
    var m_value:Int?
    func result() {
        
        let value:Int = Int (arc4random() % 4 )
        m_ropeImgView?.image = UIImage(named: "rope0\(value).png")
        m_value = value
        self.showDecree()
        
    }
    

//MARK: - showDecree 顯示聖旨
//-------------------------------
    
    func showDecree() {
        
        let m_viewFrameW = self.view.frame.size.width
        let m_viewFrameH = self.view.frame.size.height
        
        //m_decreeButtom
        m_decreeButtom = UIView(frame: CGRect(x: 0, y: 0, width: m_viewFrameW/5, height: m_viewFrameW*0.55))
        m_decreeButtom?.center = CGPoint(x: m_viewFrameW/2, y: m_viewFrameH/4)
        m_decreeButtom?.backgroundColor = UIColor(red: 0.95, green: 0.5, blue: 0, alpha: 1.0)
        self.view.addSubview(m_decreeButtom!)
        
        //m_decreePaper
        m_decreePaper = UIView(frame: CGRect(x: 0, y: 0, width: m_decreeButtom!.frame.size.width * 0.8, height: m_decreeButtom!.frame.size.height * 0.8))
        m_decreePaper?.center = m_decreeButtom!.center
        m_decreePaper?.backgroundColor = UIColor(red: 1.0, green: 0.9, blue: 0.38, alpha: 1.0)
        self.view.addSubview(m_decreePaper!)
        
        
        //decree01
        m_decree01 = UIImageView(frame: CGRect(x: 0, y: 0, width: m_viewFrameW / 12, height: m_viewFrameW*0.68))
        m_decree01?.center = CGPoint(x: m_viewFrameW/2 - m_viewFrameW/5/2, y: m_decreeButtom!.center.y)
        m_decree01?.image = UIImage(named: "decree.png")
        self.view.addSubview(m_decree01!)
        
        //m_decree02
        m_decree02 = UIImageView(frame: m_decree01!.frame)
        m_decree02?.center = CGPoint(x: m_viewFrameW/2 + m_viewFrameW/5/2, y: m_decreeButtom!.center.y)
        m_decree02?.image = UIImage(named: "decree.png")
        self.view.addSubview(m_decree02!)
        
        UIView.beginAnimations("decreeOpen", context: nil)
        UIView.setAnimationDuration(1.58)
        m_decreeButtom?.transform = CGAffineTransformMakeScale(4.0, 1.0)
        m_decreePaper?.transform = CGAffineTransformMakeScale(4.0, 1.0)
        m_decree01?.center = CGPoint(x: m_viewFrameW/2 - m_viewFrameW/5*2, y:  m_decreeButtom!.center.y)
        m_decree02?.center = CGPoint(x: m_viewFrameW/2 + m_viewFrameW/5*2, y:  m_decreeButtom!.center.y)
        UIView.commitAnimations()
        
        self.performSelector(#selector(ThirdViewController.showDecreeText), withObject: nil, afterDelay: 0.88)
        
        
    }
    
//MARK: - showDecreeText 顯示聖旨裡的文字
//-------------------------------
    var reatrtBt:UIButton? //重新開始按鈕
    
    func showDecreeText() {
        
        //m_decreeText
        m_decreeText = UILabel(frame: CGRect(x: 0, y: 0 , width: self.view.frame.size.width/5*4*0.8, height: m_decreePaper!.frame.size.height))
        m_decreeText?.center = m_decreePaper!.center
        m_decreeText?.backgroundColor = UIColor.clearColor()
        m_decreeText?.numberOfLines = 0
        m_decreeText?.textAlignment = NSTextAlignment.Center
        m_decreeText?.font = UIFont.boldSystemFontOfSize(m_decreeText!.frame.size.height * 0.38)
        m_decreeText?.adjustsFontSizeToFitWidth = true
        self.view.addSubview(m_decreeText!)
        
        if m_value != nil {
            
            switch m_value! {
                
            case 0:
                m_decreeText?.text = "聖筊\n ====== \n\n神明保佑,有求必應!"
            case 1:
                m_decreeText?.text = "無筊\n ====== \n\n又稱蓋筊,表示神明不認同!"
            case 2:
                m_decreeText?.text = "聖筊\n ====== \n\n神明保佑,有求必應!"
            case 3:
                m_decreeText?.text = "笑筊\n ====== \n\n神明笑而不答,請重新請示神明!"
            
            default:
                break
            }
            
        }
        
        self.performSelector(#selector(ThirdViewController.afterDecreeShow), withObject: nil, afterDelay: 0.68)
    }
    
//MARK: - afterdecreeShow
//-------------------------------
    func afterDecreeShow() {
        
        //reatrtBt
        reatrtBt = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/4, height: self.view.frame.size.width/1.8))
        reatrtBt?.center = CGPoint(x: self.view.frame.size.width/2, y: m_decreeButtom!.center.y + m_decreeButtom!.frame.size.height)
        reatrtBt?.setBackgroundImage(UIImage(named: "candle.png"), forState: UIControlState.Normal)
        reatrtBt?.addTarget(self, action: #selector(ThirdViewController.onRestartBtAction), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(reatrtBt!)
        
    }
    
//MARK: - onRestartBtAction 重新開始方法
//-------------------------------
    func onRestartBtAction() {
        
        reatrtBt?.enabled = false
        
        m_decreeText?.text = ""
        
        UIView.beginAnimations("decreeClose", context: nil)
        UIView.setAnimationDuration(1.38)
        m_decreeButtom?.transform = CGAffineTransformMakeScale(1.0, 1.0)
        m_decreePaper?.transform = CGAffineTransformMakeScale(1.0, 1.0)
        m_decree01?.center = CGPoint(x: self.view.frame.size.width/2 -  self.view.frame.size.width/5/2, y:  m_decreeButtom!.center.y)
        m_decree02?.center = CGPoint(x: self.view.frame.size.width/2 + self.view.frame.size.width/5/2, y:  m_decreeButtom!.center.y)
        UIView.commitAnimations()
        
        NSTimer.scheduledTimerWithTimeInterval(1.4, target: self, selector: #selector(ThirdViewController.hiddenDecree), userInfo: nil, repeats: false)
        
    }
    
//MARK: - hiddenDecree 重新開始方法
//-------------------------------
    func hiddenDecree() {
        
        reatrtBt?.removeFromSuperview()
        m_decreeButtom?.removeFromSuperview()
        m_decreePaper?.removeFromSuperview()
        m_decreeText?.removeFromSuperview()
        m_decree01?.removeFromSuperview()
        m_decree02?.removeFromSuperview()
        m_topLabel?.text =  "向 上 滑 動 擲 筊 ⬆︎ "
        m_ropeImgView?.image = UIImage(named: "rope03.png")
        self.view.addGestureRecognizer(m_swipGestureUp!)
        
    }
    
    
    
}//end class



