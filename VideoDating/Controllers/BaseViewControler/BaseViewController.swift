//
//  BaseViewController.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/24/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import PopupDialog

class BaseViewController: UIViewController, NVActivityIndicatorViewable {
    
    let animationType:NVActivityIndicatorType   = NVActivityIndicatorType.ballDoubleBounce

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func showLoader() {
        startAnimating(CGSize(width: 50.0, height: 50.0), message: "", messageFont: nil, type: self.animationType, color: Colors.darkPurple, padding: 0.0, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: UIColor.lightText)
    }
    
    func hideLoader() {
        stopAnimating()
    }
    
    func setupViewXib(innerview: UIView, outerView: UIView) {
        innerview.translatesAutoresizingMaskIntoConstraints = false
        outerView.addConstraint(NSLayoutConstraint(item: innerview, attribute: .trailing, relatedBy: .equal, toItem: outerView, attribute: .trailing, multiplier: 1, constant: 0))
        outerView.addConstraint(NSLayoutConstraint(item: innerview, attribute: .leading, relatedBy: .equal, toItem: outerView, attribute: .leading, multiplier: 1, constant: 0))
        outerView.addConstraint(NSLayoutConstraint(item: innerview, attribute: .top, relatedBy: .equal, toItem: outerView, attribute: .top, multiplier: 1, constant: 0))
        outerView.addConstraint(NSLayoutConstraint(item: innerview, attribute: .bottom, relatedBy: .equal, toItem: outerView, attribute: .bottom, multiplier: 1, constant: 0))
    }
    
    func showAlert(with message:String, title : String = Macros.ApplictionName) {
        AlertManager.showOKAlert(withTitle: title, withMessage: message, onViewController: self).view.tintColor = Colors.darkPurple
    }
    
    @objc func backBtnAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func regBackBtnAction() {
        let controller                              =  AlertViewController.initiateController()
        controller.alertImage                       = #imageLiteral(resourceName: "backAlert")
        controller.alertTitleString                 = "Are you sure you want to leave from here?"
        controller.alertSubtitleString              = ""
        controller.isReg                            = false
        controller.navigationItem.hidesBackButton   = true
        controller.modalPresentationStyle           = .overCurrentContext
        let popupDialog  = PopupDialog(viewController: controller,
                                       buttonAlignment: .horizontal,
                                       transitionStyle: .bounceDown,
                                       tapGestureDismissal: true,
                                       panGestureDismissal: false)
        self.present(popupDialog, animated: false, completion: nil)
        controller.dismissVCCompletion { str in
            if str == "Yes" {
                for controller in self.navigationController!.viewControllers.reversed() as Array {
                    if controller.isKind(of: LoginViewController.self) {
                        self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                }
            }
        }
    }
    
    @objc func contactUs() {
        let controller = ContactUsViewController.initiateController()
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    @objc func endorsement() {
        let controller = PartnershipViewController.initiateController()
        controller.isPartnership = false
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    @objc func partnerShip() {
        let controller = PartnershipViewController.initiateController()
        controller.isPartnership = true
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    @objc func popFromContact() {
        for controller in self.navigationController!.viewControllers.reversed() as Array {
            if controller.isKind(of: PartnershipViewController.self) || controller.isKind(of: ContactUsViewController.self) {
                print("Self kind")
            } else {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    func getAttributedString(font: UIFont, color: UIColor, text: String) -> NSAttributedString {
        let attrs = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor : color, NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
        let stringWithAttribute = NSAttributedString(string: text,
                                                      attributes: attrs)
        return stringWithAttribute
    }
    
    func alertForRegister(isReg: Bool) {
        let controller                              =  AlertViewController.initiateController()
        if isReg {
            controller.alertImage                       = #imageLiteral(resourceName: "noAccount")
            controller.alertTitleString                 = "Sign up for an account!"
            controller.alertSubtitleString              = "The email address that you’ve entered doesn’t match any account. "
            controller.isReg                            = true
        } else {
            controller.alertImage                       = #imageLiteral(resourceName: "backAlert")
            controller.alertTitleString                 = "Are you sure you want to leave from here?"
            controller.alertSubtitleString              = ""
            controller.isReg                            = false
        }
        
        controller.navigationItem.hidesBackButton   = true
        let popupDialog  = PopupDialog(viewController: controller,
                                       buttonAlignment: .horizontal,
                                       transitionStyle: .bounceDown,
                                       tapGestureDismissal: true,
                                       panGestureDismissal: false)
        self.present(popupDialog, animated: false, completion: nil)
        controller.dismissVCCompletion { str in
            if str == "Yes" {
                if isReg {
                    let controller = SignUpViewController.initiateController()
                    self.navigationController?.pushViewController(controller, animated: true)
                } else {
                    let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                    self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
                }
            }
        }
    }
    
    func okAlert(msg: String) {
        let controller                              =  OkAlertViewController.initiateController()
        controller.alertImage                       = #imageLiteral(resourceName: "exclaimAlert")
        controller.alertTitleString                 = msg
        controller.alertSubtitleString              = ""
        controller.hide                             = false
        controller.navigationItem.hidesBackButton   = true
        let popupDialog  = PopupDialog(viewController: controller,
                                              buttonAlignment: .horizontal,
                                              transitionStyle: .bounceDown,
                                              tapGestureDismissal: true,
                                              panGestureDismissal: false)
        self.present(popupDialog, animated: false, completion: nil)
        controller.dismissVCCompletion { _ in
            
        }
    }
    
}
