//
//  ViewController.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/24/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    class func initiateController() -> LoginViewController {
        let storyboard  = UIStoryboard(name: "Main", bundle: nil)
        let controller  = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        return controller
    }
    
    @IBOutlet weak var btnLoginFB       : CustomButton!
    @IBOutlet weak var btnLoginGoogle   : CustomButton!
    @IBOutlet weak var btnSignIn        : UIButton!
    @IBOutlet weak var btnSignUp        : UIButton!
    @IBOutlet weak var lblOtherMail     : UILabel!
    @IBOutlet weak var btnContactUs     : UIButton!
    @IBOutlet weak var btnPartner       : UIButton!
    @IBOutlet weak var btnEndorse       : UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if AppInstance.shared.kUserDefault .value(forKey: Macros.userDetails) != nil {
            AppInstance.shared.user = User.init(dictionary: AppInstance.shared.kUserDefault.value(forKey: Macros.userDetails) as! Dictionary<String, Any>)
            let user = AppInstance.shared.user
            if user?.isBlocked ?? false {
                let controller = BlockAccountViewController.initiateController()
                self.navigationController?.pushViewController(controller, animated: false)
            } else {
                if (user?.isSignUpPerformed ?? false) {
                    if !(user?.isNormalQuizComplete ?? false) {
                        let controller = KeyMatchingViewController.initiateController()
                        self.navigationController?.pushViewController(controller, animated: false)
                    } else if !(user?.isBibleQuizComplete ?? false) {
                        let controller = QuizViewController.initiateController()
                        self.navigationController?.pushViewController(controller, animated: false)
                    } else {
                        let controller = WaitingViewController.initiateController()
                        self.navigationController?.pushViewController(controller, animated: false)
                    }
                }
            }
        }
    }
    
    func setupUI() {
        btnContactUs.setAttributedTitle(self.getAttributedString(font: Fonts.mediumFont10 ?? UIFont.systemFont(ofSize: 15.0), color: .white, text: btnContactUs.titleLabel?.text ?? ""), for: .normal)
        btnEndorse.setAttributedTitle(self.getAttributedString(font: Fonts.mediumFont10 ?? UIFont.systemFont(ofSize: 15.0), color: .white, text: btnEndorse.titleLabel?.text ?? ""), for: .normal)
        btnPartner.setAttributedTitle(self.getAttributedString(font: Fonts.mediumFont10 ?? UIFont.systemFont(ofSize: 15.0), color: .white, text: btnPartner.titleLabel?.text ?? ""), for: .normal)
        btnSignIn.setAttributedTitle(self.getAttributedString(font: Fonts.boldFont13 ?? UIFont.systemFont(ofSize: 15.0), color: Colors.appOrangeColor, text: btnSignIn.titleLabel?.text ?? ""), for: .normal)
        btnSignUp.setAttributedTitle(self.getAttributedString(font: Fonts.boldFont13 ?? UIFont.systemFont(ofSize: 15.0), color: Colors.appOrangeColor, text: btnSignUp.titleLabel?.text ?? ""), for: .normal)
        
        btnLoginFB.titleLabel?.font     = Fonts.mediumFont14
        btnLoginGoogle.titleLabel?.font = Fonts.mediumFont14
        lblOtherMail.font               = Fonts.mediumFont13
        
    }
    
    @IBAction func actionContactUs() {
        let controller = ContactUsViewController.initiateController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func actionPartnerShip(_ sender: UIButton) {
        let controller = PartnershipViewController.initiateController()
        sender.tag == 100 ? (controller.isPartnership = true) : (controller.isPartnership = false)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func actionFBLogin(_ sender: Any) {
        
    }
    
    @IBAction func actionGoogleLogin(_ sender: Any) {
        
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        let controller = SignInViewController.initiateController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func actionSignUp(_ sender: Any) {
        let controller = SignUpViewController.initiateController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

