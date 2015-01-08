//
//  MainViewController.swift
//  ParseMash
//
//  Created by Don Miller on 1/1/15.
//  Copyright (c) 2015 GroundSpeed. All rights reserved.
//

import UIKit
import Parse

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tblWhiskey: UITableView!
    let c = Constants()
    var whiskeys = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            var query = PFQuery(className:c.kParseClassName)
            query.findObjectsInBackgroundWithBlock({(NSArray objects, NSError error) in
                if (error != nil) {
                    NSLog("error " + error.localizedDescription)
                }
                else {
                    NSLog("objects %@", objects as NSArray)
                    var whiskeyNames = NSArray(array: objects)

                    for whiskey in whiskeyNames {
                        self.whiskeys.append(whiskey.objectForKey("description") as String);
                    }
                    self.tblWhiskey.reloadData()
                }
            })
        } else {
            self.performSegueWithIdentifier("showLogin", sender: self)
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        tblWhiskey.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.whiskeys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        // Configure the cell...
        cell.textLabel?.text = self.whiskeys[indexPath.row]
        
        return cell
    }
    
    @IBAction func btnLogout(sender: AnyObject) {
        PFUser.logOut()
        PFUser.currentUser().save()
        self.performSegueWithIdentifier("showLogin", sender: self)
    }

}
