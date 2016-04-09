//
//  NeedleImageView.swift
//  MyMusicPlayer
//
//  Created by GuanZhipeng on 16/4/9.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class NeedleImageView: UIImageView {
    
    var needleOriginTransform: CGAffineTransform!
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setAnchorPoint(CGPointMake(0.25, 0.16), forView: self)
        self.needleOriginTransform = self.transform
    }

    
    func moveInTheNeedle() {
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.transform = self.needleOriginTransform
            
            }, completion: nil)
    }
    
    func moveOutTheNeedle() {
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI / 4))
            
            }, completion: nil)
    }
    
    //设置锚点不改变位置
    private func setAnchorPoint(anchorPoint: CGPoint , forView view: UIView) {
        let frame = view.layer.frame
        view.layer.anchorPoint = anchorPoint
        view.layer.frame = frame
    }
    
}
