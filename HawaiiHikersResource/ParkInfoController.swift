//
//  ParkInfoController.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 11/24/15.
//  Copyright © 2015 Kenneth Nagata. All rights reserved.
//
//


class ParkInfoController: UITableViewController {
    
    // Declaration of variables
    var toPass: CLLocationCoordinate2D!
    var passedCoord: CLLocationCoordinate2D!
    var tableData : NSMutableArray = []
    
    //interface builder swipe gesture recognizer
    @IBAction func swipeClose(sender: AnyObject) {
        closeSwipe()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if user allows tranparency sets blur and transparency
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            
            //set tableview color and background
            self.tableView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
            self.tableView.opaque = false
            self.tableView.backgroundView = blurEffectView
        }
        else {
            self.view.backgroundColor = UIColor.blackColor()
        }
        
        var parkId: String!
        parkId = "001"

        // Variable being passed in
        passedCoord = toPass
        
        // Selects correct park info to be diasplayed according to latitude passed in
        if passedCoord.latitude == 19.865850 && passedCoord.longitude == -155.116115{loadParkInfo("001")}
        else if passedCoord.latitude == 19.482842 && passedCoord.longitude == -154.904300{loadParkInfo("002")}
        else if passedCoord.latitude == 19.703202 && passedCoord.longitude == -155.079461{loadParkInfo("uh")}
        else if passedCoord.latitude == 19.416333 && passedCoord.longitude == -155.242834{loadParkInfo("003")}
        else if passedCoord.latitude == 19.670625 && passedCoord.longitude == -156.026178{loadParkInfo("004")}
        else {loadParkInfo(parkId)}
    }
    
    //TODO: Can delete later probably not needed
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func loadParkInfo(parkId: String){
        
        //select json file to load data
        let parksURL: NSURL = [#FileReference(fileReferenceLiteral: "parkInfo.json")#]
        let parkData = NSData(contentsOfURL: parksURL)!
        
        //Add data from json to table
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(parkData, options: NSJSONReadingOptions(rawValue: 0)) as? NSDictionary
            
            if let parks = json?.objectForKey(parkId){
                
                tableData.addObject(" ")
                
                if let parkName = parks.objectForKey("parkName") as? String{
                    tableData.addObject("Name: \(parkName)")
                }
                if let activities = parks.objectForKey("activities") as? String{
                    tableData.addObject("Activities: \(activities)")
                }
                if let regulations = parks.objectForKey("regulations") as? String{
                    tableData.addObject("Regulations: \(regulations)")
                }
                if let parkLocation = parks.objectForKey("location") as? String{
                    tableData.addObject("Location: \(parkLocation)")
                }
                if let ammenities = parks.objectForKey("ammenities") as? String{
                    tableData.addObject("Ammenities: \(ammenities)")
                }
                if let fees = parks.objectForKey("fees") as? String{
                    tableData.addObject("Fees: \(fees)")
                }
                if let contact = parks.objectForKey("contact") as? String{
                    tableData.addObject("Contact: \(contact)")
                }
            }
        } catch {
            print("error serializing JSON: \(error)")
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    //create cells for table
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = tableData[indexPath.row] as? String
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = NSTextAlignment.Center
 
        //add blur effect for cell background
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //always fill the view
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        //set cell colors
        cell.backgroundColor = UIColor.clearColor()
        cell.backgroundView = blurEffectView
        cell.opaque = false
        cell.textLabel?.textColor = UIColor(white:0.8, alpha: 1.0)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    //close view controller when swiped
    func closeSwipe() {
        self.dismissViewControllerAnimated(true, completion: {})
    }

}
