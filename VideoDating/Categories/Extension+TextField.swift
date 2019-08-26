//
//  Extension+TextField.swift
//  NomadAviation
//
//  Created by Subhash Kumar on 7/19/18.
//  Copyright © 2018 Ratnadeep Govande. All rights reserved.
//

import UIKit
import AVFoundation

extension UITextField {
    
    
    public var isEmpty: Bool {
        return text?.isEmpty == true
    }
    
    public var trimmedTextCount: Int {
        return text!.trimmingCharacters(in: .whitespacesAndNewlines).count
    }
    func isEmailValid() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let email  = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return email.evaluate(with: self)
    }
    
    public var hasValidEmail: Bool {
        return text!.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
                           options: String.CompareOptions.regularExpression,
                           range: nil, locale: nil) != nil
    }
    
    public var hasValidMobile: Bool {
        let PHONE_REGEX             = "^[0-9]*$"
        let phoneTest               = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result                  =  phoneTest.evaluate(with: self.text)
        return result
    }
    
    public func clear() {
        text                        = ""
        attributedText              = NSAttributedString(string: "")
    }
    
    public func setCorner(_ radius:CGFloat) {
        self.layer.cornerRadius     = radius
        self.clipsToBounds          = true
    }
    
//    public func setPlaceHolderTextColor(_ color: UIColor) {
//        guard let holder            = placeholder, !holder.isEmpty else {
//            return
//        }
//        self.attributedPlaceholder = NSAttributedString(string: holder, attributes:  [kCTForegroundColorAttributeName as NSAttributedString.Key : color])
//        
//    }
    
    public func addPaddingLeftIcon(_ image: UIImage, padding: CGFloat) {
        let imageView               = UIImageView(image: image)
        imageView.contentMode       = .right
        self.leftView               = imageView
        self.leftView?.frame.size   = CGSize(width: image.size.width + padding, height: image.size.height)
        self.leftViewMode           = UITextField.ViewMode.always
    }
    public func addPaddingLeftIconWithoutImage(padding: CGFloat) {
//        let view                    = UIView()
//        view.frame                  = CGRect.init(x: 0, y: 0, width: Int(padding), height: Int(padding))
//        view.contentMode            = .right
//        self.leftView               = view
//        self.leftView?.frame.size   = CGSize(width: view.frame.size.width + padding, height: view.frame.size.height)
//        self.leftViewMode           = UITextField.ViewMode.always
        
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
        self.leftViewMode = .always
        self.leftView = paddingView
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func addPaddingRightIcon(_ image: UIImage, padding: CGFloat) {
        let imageView               = UIImageView(image: image)
        imageView.contentMode       = .left
        self.rightView              = imageView
        self.rightView?.frame.size  = CGSize(width: image.size.width + padding, height: image.size.height)
        self.rightViewMode          = UITextField.ViewMode.always
        
    }
    public func addPaddingRightIconWithoutImage(padding: CGFloat) {
        let view                    = UIView()
        view.frame                  = CGRect.init(x: 0, y: 0, width: Int(padding), height: Int(padding))
        view.contentMode            = .right
        self.rightView              = view
        self.rightView?.frame.size  = CGSize(width: view.frame.size.width + padding, height: view.frame.size.height)
        self.rightViewMode          = UITextField.ViewMode.always
    }
    
    func setBottomBorder(color: UIColor) {
        
//        let bottomLine = CALayer()
//        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 2.0)
//        bottomLine.backgroundColor = color.cgColor
//        self.borderStyle            = .none
//        self.layer.addSublayer(bottomLine)
//
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView             = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView               = paddingView
        self.leftViewMode           = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView             = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView              = paddingView
        self.rightViewMode          = .always
    }
    
}
