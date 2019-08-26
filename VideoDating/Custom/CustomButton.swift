//
//  CustomButton.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/24/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CustomButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
        (layer as! CAGradientLayer).startPoint = CGPoint(x: 0.0, y: 0.0)
        (layer as! CAGradientLayer).endPoint = CGPoint(x: 0.0, y: 1.0)
        (layer as! CAGradientLayer).colors = [topColor.cgColor, bottomColor.cgColor]
    }
    
    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    @IBInspectable var cornerRadiusValue: CGFloat = 10.0 {
        didSet {
            updateCornerRadius()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            updateCornerRadius()
        }
    }
    
    @IBInspectable var borderColorButton: UIColor? = UIColor.clear {
        didSet {
            updateCornerRadius()
        }
    }
    
    func updateCornerRadius() {
        layer.borderColor = borderColorButton?.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = rounded ? frame.size.height / 2 : cornerRadiusValue
        self.clipsToBounds = true
    }
    
    @IBInspectable var topColor: UIColor = UIColor.init(red: 214.0/255.0, green: 153.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    @IBInspectable var bottomColor: UIColor = UIColor.init(red: 121.0/255.0, green: 0.0/255.0, blue: 205.0/255.0, alpha: 1.0)
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    func orangeGrad(btn: CustomButton) {
        btn.topColor = Colors.gradOrangeTop
        btn.bottomColor = Colors.gradOrangeBottom
    }
    
    func clearBackground(btn: CustomButton) {
        btn.topColor = UIColor.clear
        btn.bottomColor = UIColor.clear
        btn.layoutSubviews()
    }
    
}

