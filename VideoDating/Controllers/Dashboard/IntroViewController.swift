//
//  IntroViewController.swift
//  VideoDating
//
//  Created by Naina Ghormare on 8/22/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit

class IntroViewController: BaseViewController {

    class func initiateController() -> IntroViewController {
        let storyboard  = UIStoryboard(name: "Dashboard", bundle: nil)
        let controller  = storyboard.instantiateViewController(withIdentifier: "IntroViewController") as! IntroViewController
        return controller
    }
    
    @IBOutlet weak var lblTitle         : UILabel!
    @IBOutlet weak var lblSubtitle      : UILabel!
    @IBOutlet weak var lblSubtitle2     : UILabel!
    @IBOutlet weak var lblBlessings     : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblBlessings.font   = Fonts.mediumFont25
        lblTitle.font       = Fonts.demi18
        lblSubtitle.font    = Fonts.mediumFont13
        lblSubtitle2.font   = Fonts.mediumFont13
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(actionPushToVideoCall), userInfo: nil, repeats: false)
    }
    
    @objc func actionPushToVideoCall() {
        let controller = ReviewViewController.initiateController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
