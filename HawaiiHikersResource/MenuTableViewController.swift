//
//  TrailTableViewController.swift
//  HawaiiHikersResource
//
//  Created by Ray Manzano on 2/23/16.
//  Copyright © 2016 Kenneth Nagata. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    var chosenCellIndex = 1
    var menuTableData: NSMutableArray = []
    var passedCoord: CLLocationCoordinate2D!
    var pinCoordinate: CLLocationCoordinate2D!
    
    @IBOutlet weak var itemTest: UIBarButtonItem!
    
    @IBAction func unwindToViewController (sender: UIStoryboardSegue){
        
    }
    
    /*@IBAction func mapSwipe(sender: UIScreenEdgePanGestureRecognizer) {
    
    }*/
    @IBAction func menuOptions(sender: AnyObject) {
        let attributedStringTitle = NSAttributedString(string: "Select an Option", attributes: [
            NSFontAttributeName : UIFont.systemFontOfSize(22),
            NSForegroundColorAttributeName : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            ])
        
        let menuAlert = UIAlertController(title: "", message: "", preferredStyle: .Alert)
        
        menuAlert.setValue(attributedStringTitle, forKey: "attributedTitle")
        
        menuAlert.view.tintColor = UIColor.whiteColor()
        
        menuAlert.addAction(UIAlertAction(title: "User Info", style: .Default, handler: { (action) -> Void in }))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.toolbarHidden = false
        
        menuTableData.addObject("Trails")
        loadTrailName("akaka001")
        passedCoord = CLLocationCoordinate2D(latitude: 19.865850, longitude: -155.116115)
        loadTrailName("lavatree001")
        loadTrailName("uh")
        loadTrailName("havo001")
        loadTrailName("king001")
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(MenuTableViewController.handleSwipes(_:)))
        
        leftSwipe.direction = .Left
        
        view.addGestureRecognizer(leftSwipe)
    }
    
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
            
            if let trails = json?.objectForKey(trailId) {
                if let trailName = trails.objectForKey("trailName") as? String{
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

        cell.textLabel?.text = menuTableData[indexPath.row] as? String
        
        if indexPath.row == 0 {
            //tableView.userInteractionEnabled = false
            cell.selectionStyle = .None
           
            cell.textLabel?.textAlignment = NSTextAlignment.Center
            cell.textLabel?.font = UIFont.boldSystemFontOfSize(18)
        }
        
        return cell
    }
    
    /*override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //chosenCellIndex = indexPath.row
        
        var cellnumber = menuTableData[indexPath.row]
        
        performSegueWithIdentifier("menuTrailIdentifier", sender: self)
    }*/
    
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        /*if segue.identifier == "menuTrailIdentifier", let destination = segue.destinationViewController as? MenuTrailInfoController {
            
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPathForCell(cell) {
                
                var menuTrail = menuTableData[indexPath.row]
                
                destination.toPass = passedCoord
            }
        }*/
        
        if segue.identifier == "menuTrailIdentifier" {
            var svc = segue.destinationViewController as! MenuTrailInfoController
            
            svc.toPass = passedCoord
        }
    }*/

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
