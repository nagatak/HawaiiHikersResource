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
    
    //selection used to select correct park
    var selection: Int = 0
    
    //overrides function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selection = 2
        
        if selection == 1{parkAkaka()}
        else if selection == 2{parkLavaTree()}
        else if selection == 3{parkUH()}
        else if selection == 4{parkHavo()}
        else if selection == 5{parkHapuna()}
        else {parkNone()}
    }
    
    //Can delete later probably not needed
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
