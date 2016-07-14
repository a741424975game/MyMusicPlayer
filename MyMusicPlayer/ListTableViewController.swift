//
//  ListTableViewController.swift
//  MyMusicPlayer
//
//  Created by GuanZhipeng on 16/4/10.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
import Alamofire

protocol ChannelProtocal {
    func onChangeChannel(channelId: Int32)
}

class ListTableViewController: UITableViewController {
    
    var channelList = Array<NSDictionary>()
    var appdelegate: AppDelegate! = nil
    var delegate: ChannelProtocal?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadChannelList()
        self.appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.channelList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("channel", forIndexPath: indexPath)
        cell.textLabel?.text = channelList[indexPath.row].valueForKey("name")?.description
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let channelId = (channelList[indexPath.row].valueForKey("channel_id") as! NSString).intValue
        let channelId = channelList[indexPath.row].valueForKey("channel_id")?.intValue
        appdelegate.channelId = channelId!
        self.delegate = self.appdelegate.centerViewController as! ViewController
        self.delegate?.onChangeChannel(channelId!)
        self.appdelegate.toggleRightDrawer(tableView, animated: true)
    }
    
    func loadChannelList() {
        Alamofire.request(.GET, "https://www.douban.com/j/app/radio/channels").responseJSON { (response) in
            if response.result.value != nil{
                self.channelList = response.result.value?.valueForKey("channels") as! [NSDictionary]
                self.tableView.reloadData()
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
