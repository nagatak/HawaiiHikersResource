//
//  MapVC.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 4/12/16.
//  Copyright © 2016 Kenneth Nagata. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var mainMapView: MKMapView!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var listBtn: UIBarButtonItem!
    
    var slideDownManager = SlideDownManager()
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        let sourceController = segue.sourceViewController as! MenuVC
        //self.title = sourceController.currentItem
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            listBtn.target = self.revealViewController()
            listBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: Prepare for Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let menuVC = segue.destinationViewController as! MenuVC
        //menuVC.currentItem = self.title!
        menuVC.transitioningDelegate = self.slideDownManager
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
