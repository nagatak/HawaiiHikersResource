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
        
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            self.view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.7)
            
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
 
        // Variable being passed in
        passedCoord = toPass
        print(passedCoord)
        
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
            var svc = segue.destinationViewController as! TrailMapViewController
            
            // Variable to be passed
            svc.toPass = passedCoord
        }
    }
//    func tappedView(){
////        let tapAlert = UIAlertController(title: "Tapped", message: "You just tapped the tap view", preferredStyle: UIAlertControllerStyle.Alert)
////        tapAlert.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: nil))
////        self.presentViewController(tapAlert, animated: true, completion: nil)
//        
//        self.dismissViewControllerAnimated(true, completion: {});
//    }
    func loadTrailInfo(trailId: String){
        
        let parksURL: NSURL = [#FileReference(fileReferenceLiteral: "trailInfo.json")#]
        let parkData = NSData(contentsOfURL: parksURL)!
        
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(parkData, options: NSJSONReadingOptions(rawValue: 0)) as? NSDictionary
            
            
            if let trails = json![trailId]{
                
                tableData.addObject(" ")
                
                if let trailName = trails["trailName"] as? String{
//                    trailNameLabel.text = trailName
//                    self.view.addSubview(trailNameLabel)
                    tableData.addObject("Trail Name: \(trailName)")
                }
                if let difficulty = trails["difficulty"] as? String{
//                    difficultyLabel.text = difficulty
//                    self.view.addSubview(difficultyLabel)
                    tableData.addObject("Difficulty: \(difficulty)")
                }
                if let distance = trails["length"] as? String{
//                    distanceLabel.text = distance
                    tableData.addObject("Distance: \(distance)")
                }
                if let activity = trails["activities"] as? String{
//                    trailActivityLabel.text = activity
                    tableData.addObject("Activity: \(activity)")
                }
                if let regulations = trails["regulations"] as? String{
//                    trailRegulationsLabel.text = regulations
                    tableData.addObject("Regulations: \(regulations)")
                }
                if let other = trails["other"] as? String{
//                    trailHazardsLabel.text = other
                    tableData.addObject("Other: \(other)")
                }
                if let terrain = trails["terrain"] as? String{
//                    trailTerrainLabel.text = terrain
                    tableData.addObject("Terrain: \(terrain)")
                }
                if let type = trails["trailType"] as? String{
//                    trailTypeLabel.text = type
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
        self.dismissViewControllerAnimated(true, completion: nil)
    }}
