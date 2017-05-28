//
//  TrailInfoController.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 11/24/15.
//  Copyright © 2015 Kenneth Nagata. All rights reserved.
//


class TrailInfoController: UITableViewController {

    
    @IBAction func swipeClose(_ sender: AnyObject) {
        closeSwipe()
    }
    // Declaration of variables
    var toPass: CLLocationCoordinate2D!
    var passedCoord: CLLocationCoordinate2D!
    var tableData: NSMutableArray = []
    
    let shareData = ShareData.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if user allows tranparency sets blur and transparency
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            self.view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.7)
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            //set table backgound and color
            self.tableView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
            self.tableView.isOpaque = false
            self.tableView.backgroundView = blurEffectView
        }
        else {
            self.view.backgroundColor = UIColor.black
        }
 
        // Variable being passed in
        passedCoord = shareData.passedCoordinate
        
        // Selects correct trail info to display according to latitude
        if passedCoord.latitude == 19.865850 && passedCoord.longitude == -155.116115{loadTrailInfo("akaka001")}
        else if passedCoord.latitude == 19.482842 && passedCoord.longitude == -154.904300{loadTrailInfo("lavatree001")}
        else if passedCoord.latitude == 19.703202 && passedCoord.longitude == -155.079654{loadTrailInfo("uh")}
        else if passedCoord.latitude == 19.416333 && passedCoord.longitude == -155.242804{loadTrailInfo("havo001")}
        else if passedCoord.latitude == 19.670625 && passedCoord.longitude == -156.026178{loadTrailInfo("king001")}
        else {loadTrailInfo("trailid")}
        
    }
    
    //Can delete later probably not needed
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Override function to allow passing variables between scenes
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "trailMapViewIdentifier")
        {
            // Creates link from current ViewController to TrailMapViewController
            let svc = segue.destination as! TrailMapViewController
            
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
    func loadTrailInfo(_ trailId: String){
        //select json file to retrieve data from
        let parksURL: URL = #fileLiteral(resourceName: "trailInfo.json")
        let parkData = try! Data(contentsOf: parksURL)
        //load data into table
        do{
            let json = try JSONSerialization.jsonObject(with: parkData, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? NSDictionary
            
            if let trails = json?.object(forKey: trailId){
                
                tableData.add(" ")
                
                if let trailName = (trails as AnyObject).object(forKey: "trailName") as? String{
                    tableData.add("Trail Name: \(trailName)")
                }
                if let difficulty = (trails as AnyObject).object(forKey: "difficulty") as? String{
                    tableData.add("Difficulty: \(difficulty)")
                }
                if let distance = (trails as AnyObject).object(forKey: "length") as? String{
                    tableData.add("Distance: \(distance)")
                }
                if let activity = (trails as AnyObject).object(forKey: "activities") as? String{
                    tableData.add("Activity: \(activity)")
                }
                if let regulations = (trails as AnyObject).object(forKey: "regulations") as? String{
                    tableData.add("Regulations: \(regulations)")
                }
                if let other = (trails as AnyObject).object(forKey: "other") as? String{
                    tableData.add("Other: \(other)")
                }
                if let terrain = (trails as AnyObject).object(forKey: "terrain") as? String{
                    tableData.add("Terrain: \(terrain)")
                }
                if let type = (trails as AnyObject).object(forKey: "trailType") as? String{
                    tableData.add("Trail Type: \(type)")
                }
            }
        } catch {
            print("error serializing JSON: \(error)")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    //specify design of table cells(background and color)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tableData[indexPath.row] as? String
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = NSTextAlignment.left
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //always fill the view
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        cell.backgroundColor = UIColor.clear
        cell.backgroundView = blurEffectView
        cell.isOpaque = false
        cell.textLabel?.textColor = UIColor(white:0.8, alpha: 1.0)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    //dismiss view controller when swiped//
    func closeSwipe() {
        self.dismiss(animated: true, completion: nil)
    }
}
