//
//  MapVC.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 4/12/16.
//  Copyright © 2016 Kenneth Nagata. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, UIPopoverPresentationControllerDelegate,UIAdaptivePresentationControllerDelegate{
    
    // MARK: Properties
    
    @IBOutlet weak var mainMapView: MKMapView!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var listBtn: UIBarButtonItem!
    var chromeView: UIView = UIView() // chrome view darkend background
    
    
    @IBAction func qVMBtn(sender: UIBarButtonItem) {

        //performSegueWithIdentifier("QVMSegueIdentifier", sender: nil)
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("QVMenuVC")
        vc.modalPresentationStyle = UIModalPresentationStyle.Popover
        let popover: UIPopoverPresentationController = vc.popoverPresentationController!
        popover.barButtonItem = sender
        popover.delegate = self
        presentViewController(vc, animated: true, completion:nil)
    }
    
    
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        let navigationController = UINavigationController(rootViewController: controller.presentedViewController)
        let btnDone = UIBarButtonItem(title: "Done", style: .Done, target: self, action: "dismiss")
        navigationController.topViewController!.navigationItem.rightBarButtonItem = btnDone
        return navigationController
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
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

//    // chrome view ----------------------------------------------------
//    override init(QVMenuVC: UIViewController!, MapVC: UIViewController!) {
//        super.init(QVMenuVC:QVMenuVC, mapVC:MapVC)
//        chromeView.backgroundColor = UIColor(white:0.0, alpha:0.4)
//        chromeView.alpha = 0.0
//        
//        let tap = UITapGestureRecognizer(target: self, action: "chromeViewTapped:")
//        chromeView.addGestureRecognizer(tap)
//    }
//    
//    func chromeViewTapped(gesture: UIGestureRecognizer) {
//        if (gesture.state == UIGestureRecognizerState.Ended) {
//            presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
//        }
//    }
//    // ----------------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: Prepare for Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "menuSegueIdentifier"){
            let menuVC = segue.destinationViewController as! MenuVC
            menuVC.transitioningDelegate = self.slideDownManager
        }
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
