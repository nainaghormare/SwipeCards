//
//  AlertViewController.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/29/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit

class AlertViewController: BaseViewController {
    
    class func initiateController() -> AlertViewController {
        let storyboard  = UIStoryboard(name: "Main", bundle: nil)
        let controller  = storyboard.instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
        return controller
    }
    
    @IBOutlet weak var imageAlert       : UIImageView!
    @IBOutlet weak var alertTitle       : UILabel!
    @IBOutlet weak var alertSubtitle    : UILabel!
    @IBOutlet weak var lblBlessing      : UILabel!
    @IBOutlet weak var btnYes           : CustomButton!
    @IBOutlet weak var btnNo            : CustomButton!
    @IBOutlet weak var heightBtnView    : NSLayoutConstraint!
    
    var alertTitleString                = ""
    var alertSubtitleString             = ""
    var alertImage                      = #imageLiteral(resourceName: "noAccount")
    var isReg                           = false
    var returnString                    : String?
    typealias typeCompletionHandler     = (String?) -> ()
    var complition                      : typeCompletionHandler = { _ in }
    
    func dismissVCCompletion(_ completionHandler: @escaping typeCompletionHandler) {
        self.complition = completionHandler
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertTitle.text         = alertTitleString
        alertSubtitle.text      = alertSubtitleString
        imageAlert.image        = alertImage
        alertTitle.font         = Fonts.demi18
        alertSubtitle.font      = Fonts.mediumFont13
        lblBlessing.font        = Fonts.mediumFont30
        heightBtnView.constant  = 50*(UIDevice().screenHeight/812)
        isReg ? btnYes.setTitle("REGISTER", for: .normal) : btnYes.setTitle("YES", for: .normal)
        isReg ? btnNo.setTitle("TRY AGAIN", for: .normal) : btnNo.setTitle("NO", for: .normal)
        btnYes.titleLabel?.font = Fonts.demi18
        btnNo.titleLabel?.font  = Fonts.demi18
    }
    
    override func viewDidLayoutSubviews() {
        self.view.superview?.superview?.cornerRadiusView = 30
        self.view.clipsToBounds = true
    }
    
    func dismissView() {
        self.dismiss(animated: false) {
            self.complition(self.returnString)
            UIView.animate(withDuration: 0.3, animations: {
                self.view.transform = CGAffineTransform(translationX: 0, y: 0)
            },completion:{ _ in
                self.view.removeFromSuperview()
                self.removeFromParent()
            })
        }
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        self.returnString = "Cancel"
        self.dismissView()
    }
    
    @IBAction func actionYes(_ sender: Any) {
        self.returnString = "Yes"
        self.dismissView()
    }
    
    @IBAction func actionNo(_ sender: Any) {
        self.returnString = "No"
        self.dismissView()
    }
}
