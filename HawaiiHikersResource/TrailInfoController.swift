//
//  TrailInfoController.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 11/24/15.
//  Copyright © 2015 Kenneth Nagata. All rights reserved.
//



class TrailInfoController: UIViewController {

    // Interface builder outlets
    @IBOutlet weak var trailNameLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var trailActivityLabel: UILabel!
    @IBOutlet weak var trailRegulationsLabel: UILabel!
    @IBOutlet weak var trailHazardsLabel: UILabel!
    @IBOutlet weak var trailTerrainLabel: UILabel!
    @IBOutlet weak var trailTypeLabel: UILabel!
    
    // Declaration of variables
    var toPass: CLLocationCoordinate2D!
    var passedCoord: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Variable being passed in
        passedCoord = toPass
        print(passedCoord)
        
        // Selects correct trail info according to latitude
        if passedCoord.latitude == 19.865850{akakaTrail()}
        else if passedCoord.latitude == 19.482842{lavaTreeTrail()}
        else if passedCoord.latitude == 19.703202{uhTrail()}
        else if passedCoord.latitude == 19.416333{kilaueaIkiTrail()}
        else if passedCoord.latitude == 19.670625{alaKahakaiTrail()}
        else {noTrailInfo()}
        
    }
    
    //Can delete later probably not needed
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Sets information for labels
    func noTrailInfo(){
        trailNameLabel.text = ""
        difficultyLabel.text = ""
        distanceLabel.text = ""
        trailActivityLabel.text = ""
        trailRegulationsLabel.text = ""
        trailHazardsLabel.text = ""
        trailTerrainLabel.text = ""
        trailTypeLabel.text = ""
    }
    // Sets information for labels
    func akakaTrail(){
        trailNameLabel.text = "'Akaka Falls Loop Trail"
        difficultyLabel.text = "Easy"
        distanceLabel.text = "0.4 Miles"
        trailActivityLabel.text = "Hiking, Sightseeing"
        trailRegulationsLabel.text = "No Bicycles, pets, smoking"
        trailHazardsLabel.text = "-"
        trailTerrainLabel.text = "Forested"
        trailTypeLabel.text = "Paved"
    }
    // Sets information for labels
    func lavaTreeTrail(){
        trailNameLabel.text = "Lava Trees Loop Trail"
        difficultyLabel.text = "Easy"
        distanceLabel.text = "0.7 Miles"
        trailActivityLabel.text = "Hiking, Sightseeing"
        trailRegulationsLabel.text = "No Bicycles, pets, smoking"
        trailHazardsLabel.text = "Hazardous Cliffs"
        trailTerrainLabel.text = "Cool, Forested"
        trailTypeLabel.text = "Semi-Paved"
    }
    // Sets information for labels
    func kilaueaIkiTrail(){
        
        trailNameLabel.text = "Kilauea Iki"
        difficultyLabel.text = "Moderate"
        distanceLabel.text = "4 miles"
        trailActivityLabel.text = "Hiking, Sightseeing"
        trailRegulationsLabel.text = "Do not disturb Ahu"
        trailHazardsLabel.text = "-"
        trailTerrainLabel.text = "Lava Rock Field"
        trailTypeLabel.text = "Natural"
    }
    // Sets information for labels
    func uhTrail(){
        trailNameLabel.text = "Test Trail"
        difficultyLabel.text = "Easy"
        distanceLabel.text = "0.1 Miles"
        trailActivityLabel.text = "-"
        trailRegulationsLabel.text = "-"
        trailHazardsLabel.text = "-"
        trailTerrainLabel.text = ""
        trailTypeLabel.text = "Paved"
    }
    // Sets information for labels
    func alaKahakaiTrail(){
        trailNameLabel.text = "Ala Kahakai Trail"
        difficultyLabel.text = "Moderate"
        distanceLabel.text = "15.4 Miles"
        trailActivityLabel.text = "Hiking, Sightseeing"
        trailRegulationsLabel.text = "No motorized vehicles, bicycles, camping"
        trailHazardsLabel.text = "Hazardous Cliffs"
        trailTerrainLabel.text = "Coastal, Lava Field"
        trailTypeLabel.text = "Natural"
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
}
