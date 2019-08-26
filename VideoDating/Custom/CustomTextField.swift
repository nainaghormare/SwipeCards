//
//  CustomErrorTextField.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/26/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
//import Material

class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        self.font                   = Fonts.mediumFont21
        self.textColor              = Colors.grayText
        self.borderStyle            = .none
        self.autocorrectionType     = .no
        self.setBottomBorder(color: Colors.darkPurple)
        
    }
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 1, right: 30)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

