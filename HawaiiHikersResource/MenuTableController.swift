//
//  MenuTableController.swift
//  HawaiiHikersResource
//
//  Created by Ray Manzano on 4/6/16.
//  Copyright © 2016 Kenneth Nagata. All rights reserved.
//

import UIKit

class MenuTableController: UITableViewController {
    
    var menuTableData: NSMutableArray = []
    
    @IBAction func menuTable(sender: AnyObject) {
        let attributedStringTitle = NSAttributedString(string: "Select an Option", attributes: [
            NSFontAttributeName : UIFont.systemFontOfSize(22),
            NSForegroundColorAttributeName : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            ])
        
        let menuAlert = UIAlertController(title: "", message: "", preferredStyle: .Alert)
        
        menuAlert.setValue(attributedStringTitle, forKey: "attributedTitle")
        
        menuAlert.view.tintColor = UIColor.whiteColor()
        
        menuAlert.addAction(UIAlertAction(title: "User Info", style: .Default, handler: { (action) -> Void in }))
    }
    /*@IBAction func menuTable(sender: AnyObject) {
        let attributedStringTitle = NSAttributedString(string: "Select an Option", attributes: [
            NSFontAttributeName : UIFont.systemFontOfSize(22),
            NSForegroundColorAttributeName : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            ])
        
        let menuAlert = UIAlertController(title: "", message: "", preferredStyle: .Alert)
        
        menuAlert.setValue(attributedStringTitle, forKey: "attributedTitle")
        
        menuAlert.view.tintColor = UIColor.whiteColor()
        
        menuAlert.addAction(UIAlertAction(title: "User Info", style: .Default, handler: { (action) -> Void in }))
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableData.addObject("Trails")
        loadTrailName("akaka001")
        //passedCoord = CLLocationCoordinate2D(latitude: 19.865850, longitude: -155.116115)
        loadTrailName("lavatree001")
        loadTrailName("uh")
        loadTrailName("havo001")
        loadTrailName("king001")
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(MenuTableController.handleSwipes(_:)))
        
        leftSwipe.direction = .Left
        
        view.addGestureRecognizer(leftSwipe)
    }
    
    func handleSwipes(sender: UISwipeGestureRecognizer) {
        
        if (sender.direction == .Left){
            performSegueWithIdentifier("mapSwipeSegue", sender: self)
        }
    }
    
    func loadTrailName(trailId: String) {
        
        let parksURL: NSURL = [#FileReference(fileReferenceLiteral: "trailInfo.json")#]
        let parkData = NSData(contentsOfURL: parksURL)!
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(parkData, options: NSJSONReadingOptions(rawValue: 0)) as? NSDictionary
            
            if let trails = json?.objectForKey(trailId) {
                if let trailName = trails.objectForKey("trailName") as? String{
                    menuTableData.addObject("\(trailName)")
                }
            }
        } catch {
            print("error serializing JSON: \(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuTableData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("menuCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = menuTableData[indexPath.row] as? String
        
        if indexPath.row == 0 {
            //tableView.userInteractionEnabled = false
            cell.selectionStyle = .None
            
            cell.textLabel?.textAlignment = NSTextAlignment.Center
            cell.textLabel?.font = UIFont.boldSystemFontOfSize(18)
        }
        
        return cell
    }
}
