//
//  ForgotPwdViewController.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/25/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import PopupDialog

class ForgotPwdViewController: BaseViewController {
    
    class func initiateController() -> ForgotPwdViewController {
        let storyboard  = UIStoryboard(name: "Main", bundle: nil)
        let controller  = storyboard.instantiateViewController(withIdentifier: "ForgotPwdViewController") as! ForgotPwdViewController
        return controller
    }
    
    @IBOutlet weak var navView          : UIView!
    @IBOutlet weak var txtFieldEmail    : CustomTextField!
    @IBOutlet weak var lblTitle         : UILabel!
    @IBOutlet weak var lblSubTitle      : UILabel!
    @IBOutlet weak var lblEmail         : UILabel!
    @IBOutlet weak var btnSendLink      : CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
        let topView    = UINib(nibName: "TopNavView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TopNavView
        self.navView.addSubview(topView)
        self.setupViewXib(innerview: topView, outerView: self.navView)
        topView.btnBack.setTitle("RESET PASSWORD", for: .normal)
        topView.btnBack.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
        topView.btnBackImage.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
        
        lblTitle.font                   = Fonts.demi18
        lblSubTitle.font                = Fonts.mediumFont13
        lblEmail.font                   = Fonts.semiBoldFont13
        txtFieldEmail.font              = Fonts.mediumFont21
        btnSendLink.titleLabel?.font    = Fonts.demi18
    }
   
    @IBAction func actionSendLoginLink(_ sender: Any) {
        if !txtFieldEmail.isEmpty {
            if self.isValidEmail(emailStr: txtFieldEmail.text ?? "") {
                forgotPwdAPI()
            } else {
                self.okAlert(msg: "Please Enter valid email.")
            }
        } else {
            self.okAlert(msg: "Please Enter email.")
        }
    }
    
    func forgotPwdAPI() {
        let service = UserService()
        service.forgotPassword(with: self.txtFieldEmail.text ?? "", target: self, complition: { response in
            DispatchQueue.main.async {
                if response == "404" {
                    self.alertForRegister(isReg: true)
                } else {
                    let controller                              =  OkAlertViewController.initiateController()
                    controller.alertImage                       = #imageLiteral(resourceName: "email")
                    controller.alertTitleString                 = "Check your email!"
                    controller.alertSubtitleString              = "Email sent out from the google email domain: resetaccount@shidduchview.com"
                    controller.hide = true
                    controller.navigationItem.hidesBackButton   = true
                    let popupDialog  = PopupDialog(viewController: controller,
                                                   buttonAlignment: .horizontal,
                                                   transitionStyle: .bounceDown,
                                                   tapGestureDismissal: true,
                                                   panGestureDismissal: false)
                    self.present(popupDialog, animated: false, completion: nil)
                    controller.dismissVCCompletion { _ in
                        for controller in self.navigationController!.viewControllers.reversed() as Array {
                            if controller.isKind(of: SignInViewController.self) {
                                self.navigationController!.popToViewController(controller, animated: true)
                                break
                            }
                        }
                    }
                }
            }
        })
    }
    
}
