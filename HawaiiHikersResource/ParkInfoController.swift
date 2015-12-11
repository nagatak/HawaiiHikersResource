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
        
        // Variable being passed in
        passedCoord = toPass
        //print(passedCoord)
        
        // Selects correct park info to be diasplayed according to latitude passed in
        if passedCoord.latitude == 19.865850{parkAkaka()}
        else if passedCoord.latitude == 19.482842{parkLavaTree()}
        else if passedCoord.latitude == 19.703202{parkUH()}
        else if passedCoord.latitude == 19.416333{parkHavo()}
        else if passedCoord.latitude == 19.670625{parkHapuna()}
        else {parkNone()}
    }
    
    //TODO: Can delete later probably not needed
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Sets Labels with - when no park available
    func parkNone(){
        parkNameLabel.text = "-"
        locationLabel.text = "-"
        activityLabel.text = "-"
        regulationsLabel.text = "-"
        ammenitiesLabel.text = "-"
        feesLabel.text = "-"
    }
    //Sets lables with akaka falls information
    func parkAkaka(){
        parkNameLabel.text = "'Akaka Falls State Park"
        locationLabel.text = "‘Akaka Falls Road"
        activityLabel.text = "Hiking, Sightseeing"
        regulationsLabel.text = "No bicycles, pets, alchohol, smoking"
        ammenitiesLabel.text = "Restroom, Water Fountain"
        feesLabel.text = "$5.00"
    }
    //Sets labels with lava tree info
    func parkLavaTree(){
        parkNameLabel.text = "Lava Tree State Monument"
        locationLabel.text = "HI-132, Pāhoa, HI 96778"
        activityLabel.text = "Hiking, Sightseeing"
        regulationsLabel.text = "No bicycles, pets, alchohol, smoking"
        ammenitiesLabel.text = "Restroom, Picnic Table"
        feesLabel.text = "None"
    }
    //Sets labels with uh info
    func parkUH(){
        parkNameLabel.text = "College Hall"
        locationLabel.text = "UH Hilo"
        activityLabel.text = "None"
        regulationsLabel.text = "No alchohol, smoking"
        ammenitiesLabel.text = "Restroom"
        feesLabel.text = "$4000"
    }
    //Sets labels with Hawaii Volcanoes National Park info
    func parkHavo(){
        parkNameLabel.text = "Hawaii Volcanoes National Park "
        locationLabel.text = "Volcano"
        activityLabel.text = "Hiking, Sightseeing"
        regulationsLabel.text = "No alchohol, smoking"
        ammenitiesLabel.text = "Restrooms"
        feesLabel.text = "$15.00"
    }
    //FIXME: info not correct
    func parkHapuna(){
        parkNameLabel.text = "Hapuna"
        locationLabel.text = "Westside"
        activityLabel.text = "Hiking, Sightseeing"
        regulationsLabel.text = "No alchohol, smoking"
        ammenitiesLabel.text = "Restrooms"
        feesLabel.text = "-"
    }

}
