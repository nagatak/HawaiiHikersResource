//
//  TrailInfoController.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 11/24/15.
//  Copyright © 2015 Kenneth Nagata. All rights reserved.
//


class TrailInfoController: UITableViewController {

    
    @IBAction func swipeClose(sender: AnyObject) {
        closeSwipe()
    }
    // Declaration of variables
    var toPass: CLLocationCoordinate2D!
    var passedCoord: CLLocationCoordinate2D!
    var tableData: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if user allows tranparency sets blur and transparency
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            self.view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.7)
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            
            //set table backgound and color
            self.tableView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
            self.tableView.opaque = false
            self.tableView.backgroundView = blurEffectView
        }
        else {
            self.view.backgroundColor = UIColor.blackColor()
        }
 
        // Variable being passed in
        passedCoord = toPass
        //print(passedCoord)
        
        // Selects correct trail info to display according to latitude
        if passedCoord.latitude == 19.865850{loadTrailInfo("akaka001")}
        else if passedCoord.latitude == 19.482842{loadTrailInfo("lavatree001")}
        else if passedCoord.latitude == 19.703202{loadTrailInfo("uh")}
        else if passedCoord.latitude == 19.416333{loadTrailInfo("havo001")}
        else if passedCoord.latitude == 19.670625{loadTrailInfo("king001")}
        else {loadTrailInfo("trailid")}
        
    }
    
    //Can delete later probably not needed
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Override function to allow passing variables between scenes
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "trailMapViewIdentifier")
        {
            // Creates link from current ViewController to TrailMapViewController
            let svc = segue.destinationViewController as! TrailMapViewController
            
            // Variable to be passed
            svc.toPass = passedCoord
        }
    }
    
// Not used but keep to testing gestures
//    func tappedView(){
//        let tapAlert = UIAlertController(title: "Tapped", message: "You just tapped the tap view", preferredStyle: UIAlertControllerStyle.Alert)
//        tapAlert.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: nil))
//        self.presentViewController(tapAlert, animated: true, completion: nil)
//        
//        self.dismissViewControllerAnimated(true, completion: {});
//    }
    func loadTrailInfo(trailId: String){
        //select json file to retrieve data from
        let parksURL: NSURL = [#FileReference(fileReferenceLiteral: "trailInfo.json")#]
        let parkData = NSData(contentsOfURL: parksURL)!
        //load data into table
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(parkData, options: NSJSONReadingOptions(rawValue: 0)) as? NSDictionary
            
            if let trails = json?.objectForKey(trailId){
                
                tableData.addObject(" ")
                
                if let trailName = trails.objectForKey("trailName") as? String{
                    tableData.addObject("Trail Name: \(trailName)")
                }
                if let difficulty = trails.objectForKey("difficulty") as? String{
                    tableData.addObject("Difficulty: \(difficulty)")
                }
                if let distance = trails.objectForKey("length") as? String{
                    tableData.addObject("Distance: \(distance)")
                }
                if let activity = trails.objectForKey("activities") as? String{
                    tableData.addObject("Activity: \(activity)")
                }
                if let regulations = trails.objectForKey("regulations") as? String{
                    tableData.addObject("Regulations: \(regulations)")
                }
                if let other = trails.objectForKey("other") as? String{
                    tableData.addObject("Other: \(other)")
                }
                if let terrain = trails.objectForKey("terrain") as? String{
                    tableData.addObject("Terrain: \(terrain)")
                }
                if let type = trails.objectForKey("trailType") as? String{
                    tableData.addObject("Trail Type: \(type)")
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
    //specify design of table cells(background and color)
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = tableData[indexPath.row] as? String
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = NSTextAlignment.Center
        
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
    //dismiss view controller when swiped//
    func closeSwipe() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
