//
//  ParkInfoController.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 11/24/15.
//  Copyright © 2015 Kenneth Nagata. All rights reserved.
//



class ParkInfoController: UITableViewController {
    
    // Declaration of variables
    var toPass: CLLocationCoordinate2D!
    var passedCoord: CLLocationCoordinate2D!
    var tableData : NSMutableArray = []
    
    @IBAction func swipeClose(sender: AnyObject) {
        closeSwipe()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            //self.view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.7)
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            
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
        //print(passedCoord)
        
        // Selects correct park info to be diasplayed according to latitude passed in
        if passedCoord.latitude == 19.865850{loadParkInfo("001")}
        else if passedCoord.latitude == 19.482842{loadParkInfo("002")}
        else if passedCoord.latitude == 19.703202{loadParkInfo("uh")}
        else if passedCoord.latitude == 19.416333{loadParkInfo("003")}
        else if passedCoord.latitude == 19.670625{loadParkInfo("004")}
        else {loadParkInfo(parkId)}
    }
    
    //TODO: Can delete later probably not needed
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func loadParkInfo(parkId: String){
        
        let parksURL: NSURL = [#FileReference(fileReferenceLiteral: "parkInfo.json")#]
        let parkData = NSData(contentsOfURL: parksURL)!
        
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(parkData, options: NSJSONReadingOptions(rawValue: 0)) as? NSDictionary
            
            if let parks = json![parkId]{
                
                if let parkName = parks["parkName"] as? String{
                    print(parkName)
                    //parkNameLabel.text = parkName
                    tableData.addObject("Name: \(parkName)")
                }
                if let activities = parks["activities"] as? String{
                    print(activities)
                    //activityLabel.text = activities
                    tableData.addObject("Activities: \(activities)")
                }
                if let regulations = parks["regulations"] as? String{
                    print(regulations)
                    //regulationsLabel.text = regulations
                    tableData.addObject("Regulations: \(regulations)")
                }
                if let parkLocation = parks["location"] as? String{
                    print(parkLocation)
                    //locationLabel.text = parkLocation
                    tableData.addObject("Location: \(parkLocation)")
                }
                if let ammenities = parks["ammenities"] as? String{
                    print(ammenities)
                    //ammenitiesLabel.text = ammenities
                    tableData.addObject("Ammenities: \(ammenities)")
                }
                if let fees = parks["fees"] as? String{
                    print(fees)
                    //feesLabel.text = fees
                    tableData.addObject("Fees: \(fees)")
                }
                if let contact = parks["contact"] as? String{
                    print(contact)
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
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = tableData[indexPath.row] as? String
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = NSTextAlignment.Center
        //cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        //cell.textLabel?.sizeToFit()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //always fill the view
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
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
    func closeSwipe() {
        self.dismissViewControllerAnimated(true, completion: {})
    }

}
