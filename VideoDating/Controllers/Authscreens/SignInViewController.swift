//
//  SignInViewController.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/24/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import MaterialTextField

class SignInViewController: BaseViewController {
    
    class func initiateController() -> SignInViewController {
        let storyboard  = UIStoryboard(name: "Main", bundle: nil)
        let controller  = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        return controller
    }
    
    @IBOutlet weak var txtFieldEmail        : CustomTextField!
    @IBOutlet weak var txtFieldPassword     : CustomTextField!
    @IBOutlet weak var eyePassword          : UIButton!
    @IBOutlet weak var viewTopNav           : UIView!
    @IBOutlet weak var btnForgotPwd         : UIButton!
    @IBOutlet weak var btnSignIn            : CustomButton!
    @IBOutlet weak var lblSignUp            : UILabel!
    @IBOutlet weak var btnSignUp            : UIButton!
    @IBOutlet weak var lblEmail             : UILabel!
    @IBOutlet weak var lblPwd               : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let topView    = UINib(nibName: "TopNavView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TopNavView
        self.viewTopNav.addSubview(topView)
        self.setupViewXib(innerview: topView, outerView: self.viewTopNav)
        topView.btnBack.setTitle("SIGN IN", for: .normal)
        topView.btnBack.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
        topView.btnBackImage.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
        setUpUI()
    }

    func setUpUI() {
        txtFieldEmail.font              = Fonts.mediumFont21
        txtFieldPassword.font           = Fonts.mediumFont21
        lblEmail.font                   = Fonts.semiBoldFont13
        lblPwd.font                     = Fonts.semiBoldFont13
        btnForgotPwd.setAttributedTitle(self.getAttributedString(font: Fonts.regu15 ?? UIFont.systemFont(ofSize: 15.0), color: Colors.forgotPwdPurple, text: btnForgotPwd.titleLabel?.text ?? ""), for: .normal)
        btnSignIn.titleLabel?.font      = Fonts.demi18
        lblSignUp.font                  = Fonts.mediumFont13
        btnSignUp.setAttributedTitle(self.getAttributedString(font: Fonts.boldFont13 ?? UIFont.systemFont(ofSize: 13.0), color: Colors.appOrangeColor, text: btnSignUp.titleLabel?.text ?? ""), for: .normal)
    }
    
    @IBAction func actionEyePassword(_ sender: Any) {
        txtFieldPassword.isSecureTextEntry ? eyePassword.setImage(#imageLiteral(resourceName: "eye"), for: .normal) : eyePassword.setImage(#imageLiteral(resourceName: "hiddenEye"), for: .normal)
        txtFieldPassword.isSecureTextEntry = !txtFieldPassword.isSecureTextEntry
    }
    
    @IBAction func actionForgotPwd(_ sender: Any) {
        let controller = ForgotPwdViewController.initiateController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func actionSignIn(_ sender: Any) {
        if !txtFieldEmail.isEmpty {
            if !txtFieldPassword.isEmpty {
                if self.isValidEmail(emailStr: txtFieldEmail.text ?? "") {
                    self.login()
                } else {
                    self.okAlert(msg: "Please enter valid email")
                }
            } else {
                self.okAlert(msg: "Please enter password")
            }
        } else {
            self.okAlert(msg: "Please enter email")
        }
    }
    
    @IBAction func actionSignUp(_ sender: Any) {
        let controller = SignUpViewController.initiateController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK:- API Call
    func login() {
        let service = UserService()
        service.login(with: txtFieldEmail.text ?? "", password: txtFieldPassword.text ?? "", target: self, complition: { response in
            DispatchQueue.main.async {
                if let user = response {
                    AppInstance.shared.user = user
                    AppInstance.shared.kUserDefault.setValue(AppInstance.shared.user?.dictionaryRepresentation(), forKey: Macros.userDetails)
                    let user = AppInstance.shared.user
                    if user?.isBlocked ?? false {
                        let controller = BlockAccountViewController.initiateController()
                        self.navigationController?.pushViewController(controller, animated: true)
                    } else if !(user?.isNormalQuizComplete ?? false) {
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
        })
    }
    
}
