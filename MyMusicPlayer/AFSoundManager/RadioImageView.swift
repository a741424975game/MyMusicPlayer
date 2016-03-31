//
//  RadioImageView.swift
//  MyMusicPlayer
//
//  Created by GuanZhipeng on 16/3/29.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class RadioImageView: UIImageView {

    private var albumView: UIImageView?
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.albumView = UIImageView(frame: CGRectMake(self.frame.size.width / 2 - 75, self.frame.size.height / 2 - 75, 150, 150))
        albumView?.clipsToBounds = true
        self.albumView?.layer.cornerRadius = 75
        self.albumView?.image = UIImage(named: "image")
        self.addSubview(self.albumView!)
    }
    
    func startRotation() {
        let rotateAnimate = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimate.fromValue = 0.0
        rotateAnimate.toValue = 2.0 * M_PI
        rotateAnimate.duration = 20.0
        rotateAnimate.repeatCount = MAXFLOAT
        self.albumView?.layer.addAnimation(rotateAnimate, forKey: nil)
    }
    
    func pauseRotation() {
        if self.layer.speed != 0.0 {
            let pausedTime = self.layer.convertTime(CACurrentMediaTime(), toLayer: nil)
            self.layer.speed = 0.0
            self.layer.timeOffset = pausedTime
        }
    }
    
    func resumeRotation() {
            let pausedTime = self.layer.convertTime(CACurrentMediaTime(), toLayer: nil)
            self.layer.speed = 1.0
            self.layer.timeOffset = pausedTime
    }
    
}
