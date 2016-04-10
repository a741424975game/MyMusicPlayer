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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func controlBtnClicked(sender: AnyObject) {
        if self.mAlbumImageView.isRotating! {
            self.mNeedleImageView.moveOutTheNeedle()
            self.mAlbumImageView.pauseRotation()
            self.controlBtn.setImage(UIImage(named: "cm2_mv_btn_pause_ver"), forState: .Normal)
        }else{
            self.mNeedleImageView.moveInTheNeedle()
            self.mAlbumImageView.resumeRotation()
            self.controlBtn.setImage(UIImage(named: "cm2_mv_btn_play_ver"), forState: .Normal)
        }
    }
    
    @IBAction func listBtnClicked(sender: AnyObject) {
        print("test")
        let appdelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdelegate.toggleRightDrawer(sender, animated: true)
    }
    
    
}

