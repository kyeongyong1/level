//
//  ViewController.swift
//  KILevel
//
//  Created by Coupang on 2017. 6. 14..
//  Copyright © 2017년 KI. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    let motionManager = CMMotionManager()
    
    @IBOutlet weak var rotX: UILabel?
    @IBOutlet weak var rotY: UILabel?
    
    @IBOutlet weak var XbarImage: UIImageView?
 
    @IBOutlet weak var YbarImage: UIImageView?
    @IBOutlet weak var XYBarImage: UIImageView?
    
    var XbarRect: CGRect?
    var YbarRect: CGRect?
    var XYbarRect: CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        XbarRect = XbarImage?.frame
        YbarRect = YbarImage?.frame
        XYbarRect = XYBarImage?.frame
        
        motionStart()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func motionStart() {
    
        motionManager.deviceMotionUpdateInterval = 0.01
        
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: { (deviceMotion, error) -> Void in
            
            if error == nil {
                if let myMotion = deviceMotion {
                    let attitude = myMotion.attitude
        
                    self.displayXY(attitude: attitude)
                    self.arrangeFrame(attitude: attitude)
                }
                
            } else {
                
            }
            
            
        })
     
    }
    
    func displayXY(attitude: CMAttitude) {
        self.rotX?.text = "\(Double(round(attitude.roll * 100000) / 100000))"
        self.rotY?.text = "\(Double(round(attitude.pitch * 100000) / 100000))"
    }
    
    func arrangeFrame(attitude: CMAttitude) {
        
        let XBarImageCurrentY = XbarRect?.origin.y
        
        XbarImage?.frame = CGRect(x: (XbarImage?.frame.origin.x)!, y: (XBarImageCurrentY! + CGFloat(round(attitude.pitch * 100000) / 10000 * 3.5)), width: (XbarImage?.frame.size.width)!, height: (XbarImage?.frame.size.height)!)
        
        let YBarImageCurrentX = YbarRect?.origin.x
        
        YbarImage?.frame = CGRect(x: YBarImageCurrentX! + CGFloat(round(attitude.roll * 100000) / 10000 * 3.5), y: (YbarImage?.frame.origin.y)!, width: (YbarImage?.frame.size.width)!, height: (YbarImage?.frame.size.height)!)
        
        let XYBarImageCurrentY = XYbarRect?.origin.y
        let XYBarImageCurrentX = XYbarRect?.origin.x
        
        XYBarImage?.frame = CGRect(x: XYBarImageCurrentX! + CGFloat(round(attitude.roll * 100000) / 10000 * 3.5), y: (XYBarImageCurrentY! + CGFloat(round(attitude.pitch * 100000) / 10000 * 3.5)), width: (XYBarImage?.frame.size.width)!, height: (XYBarImage?.frame.size.height)!)
        
        
        
        
       
        
    }
    
}

