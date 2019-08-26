//
//  AppInstance.swift
//  IotiedNurseApp
//
//  Created by Naina Ghormare on 6/6/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import Foundation
class AppInstance: NSObject {
    
    static let shared                           = AppInstance()
    let kUserDefault                            = UserDefaults.standard
    var user                                    : User?
}
