//
//  TermsConditionViewController.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/31/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit
import SwiftlyScrollSlider

class TermsConditionViewController: BaseViewController {
    
    class func initiateController() -> TermsConditionViewController {
        let storyboard  = UIStoryboard(name: "SignUp", bundle: nil)
        let controller  = storyboard.instantiateViewController(withIdentifier: "TermsConditionViewController") as! TermsConditionViewController
        return controller
    }

    @IBOutlet weak var txtViewTerms     : UITextView!
    @IBOutlet weak var scrollView       : SwiftlyScrollSlider!
    @IBOutlet weak var lblBlessings     : UILabel!
    @IBOutlet weak var lblTermsAndCondi : UILabel!
    
    typealias typeCompletionHandler     = (UIViewController?) -> ()
    var complition                      : typeCompletionHandler = { _ in }
    
    func dismissVCCompletion(_ completionHandler: @escaping typeCompletionHandler) {
        self.complition = completionHandler
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblBlessings.font       = Fonts.mediumFont30
        lblTermsAndCondi.font   = Fonts.demi18
        txtViewTerms.font       = Fonts.mediumFont13
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        self.complition(self)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },completion:{ _ in
            self.view.removeFromSuperview()
            self.removeFromParent()
        })
    }
    
}
