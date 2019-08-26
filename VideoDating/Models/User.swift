//
//  User.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/31/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit

class User: NSObject {
    
    public var isBlocked                : Bool?
    public var isNormalQuizComplete     : Bool?
    public var isBibleQuizComplete      : Bool?
    public var isActive                 : Bool?
    public var isSignUpPerformed        : Bool?
    public var _id                      : String?
    public var firstName                : String?
    public var lastName                 : String?
    public var email                    : String?
    public var gender                   : Int?
    public var dOB                      : String?
    public var age                      : Int?
    public var token                    : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let User_list = User.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of User Instances.
     */
    
    public class func modelsFromDictionaryArray(array: Array<Dictionary<String,Any>>) -> [User] {
        var models:[User] = []
        for item in array {
            models.append(User(dictionary: item)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let User = User(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: User Instance.
     */
    required public init?(dictionary: Dictionary<String,Any>) {
        
        isBlocked               = dictionary["isBlocked"] as? Bool ?? false
        isNormalQuizComplete    = dictionary["isNormalQuizComplete"] as? Bool ?? false
        isBibleQuizComplete     = dictionary["isBibleQuizComplete"] as? Bool ?? false
        isActive                = dictionary["isActive"] as? Bool ?? false
        isSignUpPerformed       = dictionary["isSignUpPerformed"] as? Bool ?? false
        _id                     = dictionary["_id"] as? String ?? ""
        firstName               = dictionary["firstName"] as? String ?? ""
        lastName                = dictionary["lastName"] as? String ?? ""
        email                   = dictionary["email"] as? String ?? ""
        gender                  = dictionary["gender"] as? Int ?? 0
        dOB                     = dictionary["DOB"] as? String ?? ""
        age                     = dictionary["age"] as? Int ?? 0
        token                   = dictionary["token"] as? String ?? ""
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> Dictionary<String,Any> {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.isBlocked, forKey: "isBlocked")
        dictionary.setValue(self.isNormalQuizComplete, forKey: "isNormalQuizComplete")
        dictionary.setValue(self.isBibleQuizComplete, forKey: "inBibleQuizComplete")
        dictionary.setValue(self.isActive, forKey: "isActive")
        dictionary.setValue(self.isSignUpPerformed, forKey: "isSignUpPerformed")
        dictionary.setValue(self._id, forKey: "_id")
        dictionary.setValue(self.firstName, forKey: "firstName")
        dictionary.setValue(self.lastName, forKey: "lastName")
        dictionary.setValue(self.email, forKey: "email")
        dictionary.setValue(self.gender, forKey: "gender")
        dictionary.setValue(self.dOB, forKey: "DOB")
        dictionary.setValue(self.age, forKey: "age")
        dictionary.setValue(self.token, forKey: "token")
        
        return dictionary as! Dictionary<String, Any>
    }
    
}
