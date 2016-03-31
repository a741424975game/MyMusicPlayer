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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mAlbumImageView.startRotation()
    }
    
    override func viewDidAppear(animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pauseBtnClicked(sender: AnyObject) {
        mAlbumImageView.pauseRotation()
    }

    @IBAction func resumeBtnClicked(sender: AnyObject) {
        mAlbumImageView.resumeRotation()
    }
}

