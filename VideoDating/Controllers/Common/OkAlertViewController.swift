//
//  OkAlertViewController.swift
//  VideoDating
//
//  Created by Naina Ghormare on 8/14/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit

class OkAlertViewController: BaseViewController {
    
    class func initiateController() -> OkAlertViewController {
        let storyboard  = UIStoryboard(name: "Main", bundle: nil)
        let controller  = storyboard.instantiateViewController(withIdentifier: "OkAlertViewController") as! OkAlertViewController
        return controller
    }
    
    @IBOutlet weak var imageAlert       : UIImageView!
    @IBOutlet weak var alertTitle       : UILabel!
    @IBOutlet weak var alertSubtitle    : UILabel!
    @IBOutlet weak var lblBlessing      : UILabel!
    @IBOutlet weak var btnOk            : CustomButton!
    @IBOutlet weak var heightBtn        : NSLayoutConstraint!
    
    var alertTitleString        = ""
    var alertSubtitleString     = ""
    var alertImage              = #imageLiteral(resourceName: "noAccount")
    var hide                    = false
    
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
        
        self.btnOk.isHidden     = hide
        hide ? (heightBtn.constant = 0) : (heightBtn.constant = 50*(UIDevice().screenHeight/812))
        self.definesPresentationContext = true
        self.modalPresentationStyle = .currentContext
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
    
    @IBAction func actionOk(_ sender: Any) {
        self.returnString = "OK"
        self.dismissView()
    }
   
}
