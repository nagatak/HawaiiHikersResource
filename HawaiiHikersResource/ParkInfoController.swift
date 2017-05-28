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
    
    let shareData = ShareData.sharedInstance
    
    //interface builder swipe gesture recognizer
    @IBAction func swipeClose(_ sender: AnyObject) {
        closeSwipe()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if user allows tranparency sets blur and transparency
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            //set tableview color and background
            self.tableView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
            self.tableView.isOpaque = false
            self.tableView.backgroundView = blurEffectView
        }
        else {
            self.view.backgroundColor = UIColor.black
        }
        
        var parkId: String!
        parkId = "001"

        // Variable being passed in
        passedCoord = shareData.passedCoordinate
        
        //Selects correct park info to be diasplayed according to latitude passed in
        if passedCoord.latitude == 19.865850 && passedCoord.longitude == -155.116115{loadParkInfo("001")}
        else if passedCoord.latitude == 19.482842 && passedCoord.longitude == -154.904300{loadParkInfo("002")}
        else if passedCoord.latitude == 19.703202 && passedCoord.longitude == -155.079654{loadParkInfo("uh")}
        else if passedCoord.latitude == 19.416333 && passedCoord.longitude == -155.242834{loadParkInfo("003")}
        else if passedCoord.latitude == 19.670625 && passedCoord.longitude == -156.026178{loadParkInfo("004")}
        else {loadParkInfo(parkId)}
    }
    
    //TODO: Can delete later probably not needed
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func loadParkInfo(_ parkId: String){
        
        //select json file to load data
        let parksURL: URL = #fileLiteral(resourceName: "parkInfo.json")
        let parkData = try! Data(contentsOf: parksURL)
        
        //Add data from json to table
        do{
            let json = try JSONSerialization.jsonObject(with: parkData, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? NSDictionary
            
            if let parks = json?.object(forKey: parkId){
                
                tableData.add(" ")
                
                if let parkName = (parks as AnyObject).object(forKey: "parkName") as? String{
                    tableData.add("Name: \(parkName)")
                }
                if let activities = (parks as AnyObject).object(forKey: "activities") as? String{
                    tableData.add("Activities: \(activities)")
                }
                if let regulations = (parks as AnyObject).object(forKey: "regulations") as? String{
                    tableData.add("Regulations: \(regulations)")
                }
                if let parkLocation = (parks as AnyObject).object(forKey: "location") as? String{
                    tableData.add("Location: \(parkLocation)")
                }
                if let ammenities = (parks as AnyObject).object(forKey: "ammenities") as? String{
                    tableData.add("Ammenities: \(ammenities)")
                }
                if let fees = (parks as AnyObject).object(forKey: "fees") as? String{
                    tableData.add("Fees: \(fees)")
                }
                if let contact = (parks as AnyObject).object(forKey: "contact") as? String{
                    tableData.add("Contact: \(contact)")
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
    
    //create cells for table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tableData[indexPath.row] as? String
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = NSTextAlignment.left
 
        //add blur effect for cell background
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //always fill the view
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //set cell colors
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
    //close view controller when swiped
    func closeSwipe() {
        self.dismiss(animated: true, completion: {})
    }

}
