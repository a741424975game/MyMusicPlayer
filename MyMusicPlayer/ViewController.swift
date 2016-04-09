//
//  ViewController.swift
//  MyMusicPlayer
//
//  Created by GuanZhipeng on 16/3/29.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mAlbumImageView: RadioImageView!
    
    @IBOutlet weak var mBgImageView: UIImageView!
    

    @IBOutlet weak var mNeedleImageView: NeedleImageView!
    
    @IBOutlet weak var controlBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
 
        self.mBgImageView.image = UIImage(named: "image")
        
        //毛玻璃效果
        let blurEffect: UIBlurEffect = UIBlurEffect(style: .Light)
        let visualView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        visualView.alpha = 1.0
        visualView.frame = UIScreen.mainScreen().bounds
        self.mBgImageView.addSubview(visualView)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.mAlbumImageView.startRotation()
        self.setControlBtnState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func controlBtnClicked(sender: AnyObject) {
        if self.mAlbumImageView.isRotating! {
            self.mNeedleImageView.moveOutTheNeedle()
            self.mAlbumImageView.pauseRotation()
            self.controlBtn.setTitle("Resume", forState: .Normal)
        }else{
            self.mNeedleImageView.moveInTheNeedle()
            self.mAlbumImageView.resumeRotation()
            self.controlBtn.setTitle("Pause", forState: .Normal)
        }
    }
    
    func setControlBtnState() {
        if self.mAlbumImageView.isRotating! {
            self.controlBtn.setTitle("Pause", forState: .Normal)
        }else{
            self.controlBtn.setTitle("Resume", forState: .Normal)
        }
    }

    
}

