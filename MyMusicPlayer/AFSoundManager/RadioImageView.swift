//
//  RadioImageView.swift
//  MyMusicPlayer
//
//  Created by GuanZhipeng on 16/3/29.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class RadioImageView: UIImageView {

    var albumView: UIImageView?
    
    var isStarted: Bool!
    
    var isRotating: Bool!
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isStarted = false
        self.isRotating = false
        self.albumView = UIImageView(frame: CGRectMake(self.frame.size.width / 2 - 69, self.frame.size.height / 2 - 69, 138, 138))
        albumView?.clipsToBounds = true
        self.albumView?.layer.cornerRadius = 69
        self.albumView?.image = UIImage(named: "image")
        self.addSubview(self.albumView!)
    }
    
    func startRotation() {
        self.isStarted = true
        let rotateAnimate = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimate.fromValue = 0.0
        rotateAnimate.toValue = 2.0 * M_PI
        rotateAnimate.duration = 60.0
        rotateAnimate.repeatCount = MAXFLOAT
        self.albumView?.layer.addAnimation(rotateAnimate, forKey: nil)
        self.isRotating = true
    }
    
    func pauseRotation() {
        if self.isRotating! {
            let pausedTime = (self.albumView?.layer.convertTime(CACurrentMediaTime(), toLayer: self.albumView?.layer))! - (self.albumView?.layer.beginTime)!
            self.albumView?.layer.timeOffset = pausedTime
            self.albumView?.layer.speed = 0.0
            self.isRotating = false
        }
    }
    
    func resumeRotation() {
        if !self.isRotating! {
            let pausedTime = self.albumView?.layer.timeOffset
            self.albumView?.layer.speed = 1.0
            self.albumView?.layer.timeOffset	 = 0.0
            self.albumView?.layer.beginTime = 0.0
            let timeSincePaused = (self.albumView?.layer.convertTime(CACurrentMediaTime(), toLayer:  self.albumView?.layer))! - pausedTime!
            self.albumView?.layer.beginTime = timeSincePaused
            self.isRotating = true
        }
    }
    
}
