//
//  Extension+UIDevice.swift
//  VideoDating
//
//  Created by Naina Ghormare on 8/6/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {
    
    var iPhone: Bool {
        return UIDevice().userInterfaceIdiom == .phone
    }
    
    enum ScreenType: String {
        case iPhone4
        case iPhone5
        case iPhone6
        case iPhone6Plus
        case iPhoneX
        case Unknown
    }
    
    var screenHeight : CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var screenWidth : CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var heightAspectRatio : CGFloat {
        return screenHeight/812
    }
    
    var widthAspectRatio : CGFloat {
        return screenWidth/375
    }
    
    var screenType: ScreenType {
        guard iPhone else { return .Unknown}
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhone4
        case 1136:
            return .iPhone5
        case 1334:
            return .iPhone6
        case 2208, 1920:
            return .iPhone6Plus
        case 2436:
            return .iPhoneX
        default:
            return .Unknown
        }
    }
    
    var isGreater: Bool {
        guard iPhone else {
            return false
        }
        switch UIScreen.main.nativeBounds.height {
        case 960, 1136, 1334:
            return false
        default:
            return true
        }
    }
    
}

