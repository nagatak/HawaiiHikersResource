//
//  TrailTableViewController.swift
//  HawaiiHikersResource
//
//  Created by Ray Manzano on 2/23/16.
//  Copyright © 2016 Kenneth Nagata. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    var menuTableData: NSMutableArray = []
    var pinCoordinate: CLLocationCoordinate2D!
    
    @IBOutlet weak var itemTest: UIBarButtonItem!
    /*@IBAction func mapSwipe(sender: UISwipeGestureRecognizer) {
        performSegueWithIdentifier("mapSegue", sender: nil)
    }*/    
    
    @IBAction func unwindToMenuTable (sender: UIStoryboardSegue){
        
    }
    /*@IBAction func mapSwipe(sender: UIScreenEdgePanGestureRecognizer) {
    
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.toolbarHidden = false
        
        menuTableData.addObject("Trails")
        loadTrailName("akaka001")
        loadTrailName("lavatree001")
        loadTrailName("uh")
        loadTrailName("havo001")
        loadTrailName("king001")
        
        
        // Datasets for trail locations including trail name, GPS coordinates, & subtitle
        let akaka = PinInfo(title: "Akaka Falls Loop Trail", coordinate: CLLocationCoordinate2D(latitude: 19.865850, longitude: -155.116115), subtitle: "Akaka Falls State Park")
        let lava = PinInfo(title: "Lava Tree Troop Trail", coordinate: CLLocationCoordinate2D(latitude: 19.482842, longitude: -154.904300), subtitle: "Lava Tree State Monument")
        let college = PinInfo(title: "College Hall Trail", coordinate: CLLocationCoordinate2D(latitude: 19.703202, longitude: -155.079654), subtitle: "UH Hilo")
        let kilauea = PinInfo(title: "Kilauea Iki Trail", coordinate: CLLocationCoordinate2D(latitude: 19.416333, longitude: -155.242804), subtitle: "Hawaii Volcanoes National Park")
        let kahakai = PinInfo(title: "Ala Kahakai Trail", coordinate: CLLocationCoordinate2D(latitude: 19.670625, longitude: -156.026178), subtitle: "Kings Trail")
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        leftSwipe.direction = .Left
        
        view.addGestureRecognizer(leftSwipe)
        
        //pin()
    }
    
    /*func pin() {
        
        if menuTableData == "akaka001" {
            performSegueWithIdentifier("mapSwipeSegue", sender: self)
    }*/
    
    func handleSwipes(sender: UISwipeGestureRecognizer) {
        
        if (sender.direction == .Left){
            performSegueWithIdentifier("mapSwipeSegue", sender: self)
        }
    }
    
    func loadTrailName(trailId: String) {
        
        let parksURL: NSURL = [#FileReference(fileReferenceLiteral: "trailInfo.json")#]
        let parkData = NSData(contentsOfURL: parksURL)!
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(parkData, options: NSJSONReadingOptions(rawValue: 0)) as? NSDictionary
            
            if let trails = json![trailId] {
                if let trailName = trails["trailName"] as? String{
                    menuTableData.addObject("\(trailName)")
                }
            }
        } catch {
            print("error serializing JSON: \(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuTableData.count
    }

    /*
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> Int {
        return 1
    }*/
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("menuCell", forIndexPath: indexPath)
        let test = indexPath.row

        cell.textLabel?.text = menuTableData[indexPath.row] as? String
        
        if indexPath.row == 0 {
            //tableView.userInteractionEnabled = false
            cell.selectionStyle = .None
           
            cell.textLabel?.textAlignment = NSTextAlignment.Center
            cell.textLabel?.font = UIFont.boldSystemFontOfSize(18)
        }
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cell = sender as? UITableViewCell {
            if segue.identifier == "menuTrailSegue" {
                var svc = segue.destinationViewController as! TrailInfoController
            
                svc.toPass = pinCoordinate
            }
        }
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
