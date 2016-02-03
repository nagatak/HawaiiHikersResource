//
//  ParkInfoController.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 11/24/15.
//  Copyright © 2015 Kenneth Nagata. All rights reserved.
//



class ParkInfoController: UIViewController {
    
    //Interface builder outlet references
    @IBOutlet weak var parkNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var regulationsLabel: UILabel!
    @IBOutlet weak var ammenitiesLabel: UILabel!
    @IBOutlet weak var feesLabel: UILabel!
    
    // Declaration of variables
    var toPass: CLLocationCoordinate2D!
    var passedCoord: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var parkId: String!
        parkId = "001"

        // Variable being passed in
        passedCoord = toPass
        //print(passedCoord)
        
        // Selects correct park info to be diasplayed according to latitude passed in
        if passedCoord.latitude == 19.865850{loadParkInfo("001")}
        else if passedCoord.latitude == 19.482842{loadParkInfo(parkId)}
        else if passedCoord.latitude == 19.703202{loadParkInfo(parkId)}
        else if passedCoord.latitude == 19.416333{loadParkInfo(parkId)}
        else if passedCoord.latitude == 19.670625{loadParkInfo(parkId)}
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
                    parkNameLabel.text = parkName
                }
                if let activities = parks["activities"] as? String{
                    print(activities)
                    activityLabel.text = activities
                }
                if let regulations = parks["regulations"] as? String{
                    print(regulations)
                    regulationsLabel.text = regulations
                }
                if let parkLocation = parks["location"] as? String{
                    print(parkLocation)
                    locationLabel.text = parkLocation
                }
                if let ammenities = parks["ammenities"] as? String{
                    print(ammenities)
                    ammenitiesLabel.text = ammenities
                }
                if let fees = parks["fees"] as? String{
                    print(fees)
                    feesLabel.text = fees
                }
                if let contact = parks["contact"] as? String{
                    print(contact)
                }
            }
        } catch {
            print("error serializing JSON: \(error)")
        }
    }
}
