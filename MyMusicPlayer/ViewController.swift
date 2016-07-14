//
//  ViewController.swift
//  MyMusicPlayer
//
//  Created by GuanZhipeng on 16/3/29.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
import Alamofire
import MediaPlayer

class ViewController: UIViewController, ChannelProtocal {

    @IBOutlet weak var mAlbumImageView: RadioImageView!
    
    @IBOutlet weak var mBgImageView: UIImageView!

    @IBOutlet weak var mNeedleImageView: NeedleImageView!
    
    @IBOutlet weak var mTime: UILabel!
    
    @IBOutlet weak var mProcess: UISlider!

    @IBOutlet weak var controlBtn: UIButton!
    
    @IBOutlet weak var mTitle: UILabel!
    
    var musicPlayer: MPMoviePlayerController = MPMoviePlayerController()
    
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
        self.loadMusic()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func controlBtnClicked(sender: AnyObject) {
        if !self.mAlbumImageView.isStarted! {
            self.mNeedleImageView.moveInTheNeedle()
            self.mAlbumImageView.startRotation()
            self.controlBtn.setImage(UIImage(named: "cm2_mv_btn_pause_ver"), forState: .Normal)
            self.musicPlayer.play()
        }else{
            if self.mAlbumImageView.isRotating! {
                self.mNeedleImageView.moveOutTheNeedle()
                self.mAlbumImageView.pauseRotation()
                self.controlBtn.setImage(UIImage(named: "cm2_mv_btn_play_ver"), forState: .Normal)
                self.musicPlayer.pause()
            }else{
                self.mNeedleImageView.moveInTheNeedle()
                self.mAlbumImageView.resumeRotation()
                self.controlBtn.setImage(UIImage(named: "cm2_mv_btn_pause_ver"), forState: .Normal)
                self.musicPlayer.play()
            }
        }
    }
    
    @IBAction func listBtnClicked(sender: AnyObject) {
        let appdelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdelegate.toggleRightDrawer(sender, animated: true)
    }
    
    func onChangeChannel(channelId: Int32) {
        self.loadMusic()
    }
    
    @IBAction func mProcessController(sender: AnyObject) {
    }
    
    func loadMusic() {
        let appdelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let channelId = appdelegate.channelId
        Alamofire.request(.GET, "https://douban.fm/j/mine/playlist", parameters: ["channel":String(channelId)]).responseJSON { (response) in
            let musicInfo = response.result.value?.valueForKey("song")![0]
            let title = musicInfo!.valueForKey("title") as! String
            let musicUrl = musicInfo!.valueForKey("url")! as! String
            let imageUrl = musicInfo!.valueForKey("picture") as! String
            dispatch_async(dispatch_get_main_queue(), { 
                self.mTitle.text = title
            })
            print(musicInfo)
            Alamofire.request(.GET, imageUrl).responseData(completionHandler: { (response) in
                let image:UIImage = UIImage(data: response.result.value!)!
                dispatch_async(dispatch_get_main_queue(), {
                    self.mAlbumImageView.albumView?.image = image
                    self.mBgImageView.image = image
                })
            })
            self.musicPlayer.stop()
            self.musicPlayer.contentURL = NSURL(string: musicUrl)
        }
    }


}

