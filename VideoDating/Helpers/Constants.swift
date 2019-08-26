//
//  Constants.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/24/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import Foundation
import  UIKit

enum Macros {
    static let userDetails                      = "userDetails"
    static let ApplictionName                   = "Shidduch View"
    
}

enum Fonts {
    static let mediumFont14                     = UIFont(name: "Montserrat-Medium", size: 14*(UIDevice().heightAspectRatio))
    static let mediumFont13                     = UIFont(name: "Montserrat-Medium", size: 13*(UIDevice().heightAspectRatio))
    static let mediumFont15                     = UIFont(name: "Montserrat-Medium", size: 15*(UIDevice().heightAspectRatio))
    static let mediumFont9                      = UIFont(name: "Montserrat-Medium", size: 9*(UIDevice().heightAspectRatio))
    static let mediumFont25                     = UIFont(name: "Montserrat-Medium", size: 25*(UIDevice().heightAspectRatio))
    static let mediumFont21                     = UIFont(name: "Montserrat-Medium", size: 21*(UIDevice().heightAspectRatio))
    static let mediumFont10                     = UIFont(name: "Montserrat-Medium", size: 10*(UIDevice().heightAspectRatio))
    static let mediumFont30                     = UIFont(name: "Montserrat-Medium", size: 30*(UIDevice().heightAspectRatio))
    static let mediumFont18                     = UIFont(name: "Montserrat-Medium", size: 18*(UIDevice().heightAspectRatio))
    static let reguFont11                       = UIFont(name: "Montserrat-Regular", size: 11*(UIDevice().heightAspectRatio))
    static let boldFont13                       = UIFont(name: "Montserrat-Bold", size: 13*(UIDevice().heightAspectRatio))
    static let demi25                           = UIFont(name: "AvenirNextLTPro-Demi", size: 25*(UIDevice().heightAspectRatio))
    static let demi18                           = UIFont(name: "AvenirNextLTPro-Demi", size: 18*(UIDevice().heightAspectRatio))
    static let demi12                           = UIFont(name: "AvenirNextLTPro-Demi", size: 12*(UIDevice().heightAspectRatio))
    static let regu15                           = UIFont(name: "AvenirNextLTPro-Regular", size: 15*(UIDevice().heightAspectRatio))
    static let semiBoldFont13                     = UIFont(name: "Montserrat-SemiBold", size: 13*(UIDevice().heightAspectRatio))
}

enum Colors {
    static let appOrangeColor                   = UIColor(red: 249.0/255.0, green: 157.0/255.0, blue: 20.0/255.0, alpha: 1.0)
    static let shadowColor                      = UIColor(red: 231.0/255.0, green: 183.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    static let gradOrangeTop                    = UIColor(red: 253.0/255.0, green: 185.0/255.0, blue: 54.0/255.0, alpha: 1.0)
    static let gradOrangeBottom                 = UIColor(red: 250.0/255.0, green: 91.0/255.0, blue: 104.0/255.0, alpha: 1.0)
    static let grayText                         = UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0)
    static let darkPurple                       = UIColor(red: 68.0/255.0, green: 0.0/255.0, blue: 116.0/255.0, alpha: 1.0)
    static let forgotPwdPurple                  = UIColor(red: 121.0/255.0, green: 0.0/255.0, blue: 206.0/255.0, alpha: 1.0)
}

enum Config {
    
//    static let baseUrl                      = "http://172.10.65.65:5952/api/"//local
        static let baseUrl                      = "http://54.71.18.74:5952/api/"//staging
    
    struct ServiceName {
        static let login                        = "user/userLoginNormal"
        static let signUp                       = "user/normalandsocialSignUp"
        static let getSuperImportantQuestions   = "rQuestions/getSuperImportantQuestions"
        static let gettheBibleQuestions         = "rQuestions/gettheBibleQuestions"
        static let addUseranswersForQuestion    = "useranswers/addUseranswersForQuestion"
        static let answerBibleQuestion          = "useranswers/answerBibleQuestion"
        static let forgotpassword               = "user/forgotpassword"
        static let getYouTubeLink               = "youtube/getYouTubeLink"
        static let getWaitingScreenQuestions    = "rQuestions/getWaitingScreenQuestions"
    }
    
}

enum ApiKeys {
    static let hasUser                          = "hasUser"
    //Login
    static let kDevice_token                    = "device_token"
    static let kDevice_type                     = "device_type"
    static let kEmail                           = "email"
    static let kPassword                        = "password"
    
    //SignUp
    static let kFirstName                       = "firstName"
    static let kLastName                        = "lastName"
    static let kGender                          = "gender"
    static let kDOB                             = "DOB"
    static let kLoginType                       = "loginType"
    static let kFacebookSocialId                = "facebookSocialId"
    static let kGoogleSocialId                  = "googleSocialId"
    
    //getSuperImportantQuestions
    static let kId                              = "id"
    
    //saveSuperImportantQuestions
    static let kUser_id                         = "user_id"
    static let kAnswer                          = "answer"
    static let kQType                           = "qType"
    static let kQ_id                            = "q_id"
    static let kQuestions                       = "questions"
    static let kAnswer_text                     = "answer_text"
    
}

enum Identifiers {
    enum cell {
        
    }
}
