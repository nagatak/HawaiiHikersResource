//HawaiiHikersResource
//
import UIKit
import SceneKit
import CoreMotion
import SpriteKit
import AVFoundation
import Foundation
import Darwin
import CoreGraphics

// utility functions
func degreesToRadians(_ degrees: Float) -> Float {
    return (degrees * Float(M_PI)) / 180.0
}

class PreviewController: UIViewController, SCNSceneRendererDelegate, UIGestureRecognizerDelegate {
    
    //@IBOutlet weak var leftSceneView : SCNView!
    //@IBOutlet weak var rightSceneView : SCNView!
    //@IBOutlet weak var playButton : UIButton!
    //@IBOutlet weak var playerSlideBar : UISlider!
    
    @IBOutlet weak var SceneView: SCNView!
    @IBOutlet weak var playButton: UIBarButtonItem!
    @IBOutlet weak var playerSlideBar: UISlider!
   
    @IBAction func closePreview(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var scene : SCNScene?
    
    var videoNode : SCNNode?
    var videoSpriteKitNode : SKVideoNode?
    var player : AVPlayer!
    
    var camerasNode : SCNNode?
    var cameraRollNode : SCNNode?
    var cameraPitchNode : SCNNode?
    var cameraYawNode : SCNNode?
    
    var recognizer : UITapGestureRecognizer?
    var panRecognizer: UIPanGestureRecognizer?
    var motionManager : CMMotionManager?
    
    var playingVideo : Bool = false
    
    var currentAngleX : Float?
    var currentAngleY : Float?
    
    var progressObserver : AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SceneView?.backgroundColor = UIColor.black
        
        // Create Scene
        scene = SCNScene()
        SceneView?.scene = scene
        
        // Create cameras
        let camX = 0.0 as Float
        let camY = 0.0 as Float
        let camZ = 0.0 as Float
        let zFar = 50.0
        
        let leftCamera = SCNCamera()
        let rightCamera = SCNCamera()
        
        leftCamera.zFar = zFar
        rightCamera.zFar = zFar
        
        let leftCameraNode = SCNNode()
        leftCameraNode.camera = leftCamera
        leftCameraNode.position = SCNVector3(x: camX - 0.5, y: camY, z: camZ)
        
        let rightCameraNode = SCNNode()
        rightCameraNode.camera = rightCamera
        rightCameraNode.position = SCNVector3(x: camX + 0.5, y: camY, z: camZ)
        
        camerasNode = SCNNode()
        camerasNode!.position = SCNVector3(x: camX, y:camY, z:camZ)
        camerasNode!.addChildNode(leftCameraNode)
        camerasNode!.addChildNode(rightCameraNode)
        
        let camerasNodeAngles = getCamerasNodeAngle()
        camerasNode!.eulerAngles = SCNVector3Make(Float(camerasNodeAngles[0]), Float(camerasNodeAngles[1]), Float(camerasNodeAngles[2]))
        
        cameraRollNode = SCNNode()
        cameraRollNode!.addChildNode(camerasNode!)
        
        cameraPitchNode = SCNNode()
        cameraPitchNode!.addChildNode(cameraRollNode!)
        
        cameraYawNode = SCNNode()
        cameraYawNode!.addChildNode(cameraPitchNode!)
        
        scene!.rootNode.addChildNode(cameraYawNode!)
        
        SceneView?.pointOfView = leftCameraNode
        
        // Respond to user head movement. Refreshes the position of the camera 60 times per second.
        motionManager = CMMotionManager()
        motionManager?.deviceMotionUpdateInterval = 1.0 / 60.0
        motionManager?.startDeviceMotionUpdates(using: CMAttitudeReferenceFrame.xArbitraryZVertical)
        
        SceneView?.delegate = self
        
        SceneView?.isPlaying = true
        
        // Add gestures on screen
        recognizer = UITapGestureRecognizer(target: self, action:#selector(PreviewController.tapTheScreen))
        recognizer!.delegate = self
        view.addGestureRecognizer(recognizer!)
        
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(PreviewController.panGesture(_:)))
        view.addGestureRecognizer(panRecognizer!)
        currentAngleX = 0
        currentAngleY = 0
        
        play()
    }
    
    
    //MARK: Camera Orientation methods
    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        let camerasNodeAngles = getCamerasNodeAngle()
        camerasNode!.eulerAngles = SCNVector3Make(Float(camerasNodeAngles[0]), Float(camerasNodeAngles[1]), Float(camerasNodeAngles[2]))
    }
    
    func getCamerasNodeAngle() -> [Double] {
        var camerasNodeAngle1: Double! = 0.0
        var camerasNodeAngle2: Double! = 0.0
        let orientation = UIApplication.shared.statusBarOrientation.rawValue
        if orientation == 1 {
            camerasNodeAngle1 = -.pi/2
        } else if orientation == 2 {
            camerasNodeAngle1 = .pi/2
        } else if orientation == 3 {
            camerasNodeAngle1 = 0.0
            camerasNodeAngle2 = .pi
        }
        
        return [ -.pi/2, camerasNodeAngle1, camerasNodeAngle2 ]
    }
    
    
    //Mark: video player methods
    func play(){

        let fileURL: URL? = URL(fileURLWithPath: Bundle.main.path(forResource: "get", ofType: "mp4")!)
        
        if (fileURL != nil){
            
            player = AVPlayer(url: fileURL!)
            
            videoSpriteKitNode =  SKVideoNode(avPlayer: player)
            videoNode = SCNNode()
            videoNode!.geometry = SCNSphere(radius: 30)
            
            let spriteKitScene = SKScene(size: CGSize(width: 2500, height: 2500))
            spriteKitScene.scaleMode = .aspectFit
            
            videoSpriteKitNode!.position = CGPoint(x: spriteKitScene.size.width / 2.0, y: spriteKitScene.size.height / 2.0)
            videoSpriteKitNode!.size = spriteKitScene.size
            
            spriteKitScene.addChild(videoSpriteKitNode!)
            
            videoNode!.geometry?.firstMaterial?.diffuse.contents = spriteKitScene
            videoNode!.geometry?.firstMaterial?.isDoubleSided = true
            
            // Flip video upside down, so that it's shown in the right position
            var transform = SCNMatrix4MakeRotation(Float(M_PI), 0.0, 0.0, 1.0)
            transform = SCNMatrix4Translate(transform, 1.0, 1.0, 0.0)
            
            videoNode!.pivot = SCNMatrix4MakeRotation(Float(M_PI_2), 0.0, -1.0, 0.0)
            videoNode!.geometry?.firstMaterial?.diffuse.contentsTransform = transform
            videoNode!.position = SCNVector3(x: 0, y: 0, z: 0)
            
            scene!.rootNode.addChildNode(videoNode!)
            
            progressObserver = player.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(0.1, Int32(NSEC_PER_SEC)),
                                                                         queue: nil,
                                                                         using: { [unowned self] (time) -> Void in
                                                                            self.updateSliderProgression()
                }) as AnyObject
            
            playPausePlayer()
        }
    }
    
    func stopPlay(){
        
        if (playingVideo){
            videoSpriteKitNode!.pause()
        }else{
            videoSpriteKitNode!.play()
        }
        
        playingVideo = !playingVideo
    }
    
    @IBAction func playPausePlayer() {
        if true == playingVideo {
            videoSpriteKitNode!.pause()
        } else {
            videoSpriteKitNode!.play()
        }
        
        playingVideo = !playingVideo
//        playButton.setImage(UIImage(named: (true == playingVideo) ? "pause@3x.png" : "play@3x.png"), forState: .Normal)
    }
    
    //Mark: action methods
    func tapTheScreen(){
        // Action when the screen is tapped
        stopPlay()
    }
    
    func panGesture(_ sender: UIPanGestureRecognizer){
        //getting the CGpoint at the end of the pan
        let translation = sender.translation(in: sender.view!)
        
        var newAngleX = Float(translation.x)
        
        //current angle is an instance variable so i am adding the newAngle to it
        newAngleX = newAngleX + currentAngleX!
        videoNode!.eulerAngles.y = -newAngleX/100
        
        //getting the end angle of the swipe put into the instance variable
        if(sender.state == UIGestureRecognizerState.ended) {
            currentAngleX = newAngleX
        }
    }
    
    
    //Mark: Render the scenes
    func renderer(_ aRenderer: SCNSceneRenderer, updateAtTime time: TimeInterval){
        
        // Render the scene
        DispatchQueue.main.async { () -> Void in
            if let mm = self.motionManager, let motion = mm.deviceMotion {
                let currentAttitude = motion.attitude
                
                var roll : Double = currentAttitude.roll
                if(UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.landscapeRight){ roll = -1.0 * (-M_PI - roll)}
                
                self.cameraRollNode!.eulerAngles.x = Float(roll)
                self.cameraPitchNode!.eulerAngles.z = Float(currentAttitude.pitch)
                self.cameraYawNode!.eulerAngles.y = Float(currentAttitude.yaw)
                
            }
        }
    }
    
    // MARK: Slider method
    fileprivate func updateSliderProgression() {
        let playerDuration = self.playerItemDuration()
        if CMTIME_IS_INVALID(playerDuration) {
            playerSlideBar.minimumValue = 0.0
            return;
        }
        
        let duration = Float(CMTimeGetSeconds(playerDuration))
        // isFinite(duration) &&
        if (duration > 0) {
            let minValue            = playerSlideBar.minimumValue
            let maxValue            = playerSlideBar.maximumValue
            let time                = Float(CMTimeGetSeconds(player.currentTime()))
            
            playerSlideBar.value    = (maxValue - minValue) * time / duration + minValue
        }
    }
    
    fileprivate func playerItemDuration() -> CMTime {
        let thePlayerItem = player.currentItem
        
        if AVPlayerItemStatus.readyToPlay == thePlayerItem?.status {
            return thePlayerItem?.duration ?? kCMTimeInvalid
        }
        
        return kCMTimeInvalid
    }
    
    @IBAction func sliderChangeProgression(_ sender: UISlider) {
        let playerDuration = self.playerItemDuration()
        
        if CMTIME_IS_INVALID(playerDuration) {
            return;
        }
        
        let duration = Float(CMTimeGetSeconds(playerDuration))
        // isFinite(duration) && 
        if (duration > 0) {
            print(duration,Float64(duration) * Float64(playerSlideBar.value))
            player.seek(to: CMTimeMakeWithSeconds(Float64(duration) * Float64(playerSlideBar.value), 60000))
            playPausePlayer()
        }
    }
    
    @IBAction func sliderStartSliding(_ sender: AnyObject) {
        videoSpriteKitNode!.pause()
        playingVideo = false
//        playButton.setImage(UIImage(named: (true == playingVideo) ? "pause@3x.png" : "play@3x.png"), forState: .Normal)
    }
    
    //MARK: Clean Methods
    
    deinit {
        motionManager?.stopDeviceMotionUpdates()
        motionManager = nil
        
        if let observer = progressObserver {
            player.removeTimeObserver(observer)
        }
        
        playingVideo = false
        
        self.videoSpriteKitNode?.removeFromParent()
        
        for node in scene!.rootNode.childNodes {
            removeNode(node)
        }
    }
    
    func removeNode(_ node : SCNNode) {
        for node in node.childNodes {
            removeNode(node)
        }
        
        if 0 == node.childNodes.count {
            node.removeFromParentNode()
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
