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
    
    @IBOutlet weak var closeTap: UIView!
    
    @IBAction func tapRec(sender: AnyObject) {
        tappedView()
    }
    
    @IBAction func closeBtn(sender: UIButton) {
               self.dismissViewControllerAnimated(true, completion: {});
    }
    
    // Declaration of variables
    var toPass: CLLocationCoordinate2D!
    var passedCoord: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            self.view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.7)
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            
            self.view.addSubview(blurEffectView)
            
            //if you have more UIViews, use an insertSubview API to place it where needed
            
            trailNameLabel.textColor = UIColor(white: 1.0, alpha: 0.7)
        }
        else {
            self.view.backgroundColor = UIColor.blackColor()
        }
        

        self.view.addSubview(closeTap)
        
        //view?.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.7)
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
    func tappedView(){
//        let tapAlert = UIAlertController(title: "Tapped", message: "You just tapped the tap view", preferredStyle: UIAlertControllerStyle.Alert)
//        tapAlert.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: nil))
//        self.presentViewController(tapAlert, animated: true, completion: nil)
        
        self.dismissViewControllerAnimated(true, completion: {});
    }
    func loadTrailInfo(trailId: String){
        
        let parksURL: NSURL = [#FileReference(fileReferenceLiteral: "trailInfo.json")#]
        let parkData = NSData(contentsOfURL: parksURL)!
        
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(parkData, options: NSJSONReadingOptions(rawValue: 0)) as? NSDictionary
            
            if let trails = json![trailId]{
                
                if let trailName = trails["trailName"] as? String{
                    trailNameLabel.text = trailName
                    self.view.addSubview(trailNameLabel)
                }
                if let difficulty = trails["difficulty"] as? String{
                    difficultyLabel.text = difficulty
                    self.view.addSubview(difficultyLabel)
                }
                if let distance = trails["length"] as? String{
                    distanceLabel.text = distance
                }
                if let activity = trails["activities"] as? String{
                    trailActivityLabel.text = activity
                }
                if let regulations = trails["regulations"] as? String{
                    trailRegulationsLabel.text = regulations
                }
                if let other = trails["other"] as? String{
                    trailHazardsLabel.text = other
                }
                if let terrain = trails["terrain"] as? String{
                    trailTerrainLabel.text = terrain
                }
                if let type = trails["trailType"] as? String{
                    trailTypeLabel.text = type
                }
            
            }
        } catch {
            print("error serializing JSON: \(error)")
        }
    }

}
