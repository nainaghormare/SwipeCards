//
//  SuperImpQuestions.swift
//  VideoDating
//
//  Created by Naina Ghormare on 8/1/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit

class SuperImpQuestions: NSObject {
    
    public var modifiedDate         : String?
    public var createdDate          : String?
    public var _id                  : String?
    public var questions            : String?
    public var option1              : String?
    public var option2              : String?
    public var questionAddressTo    : Int?
    public var qType                : Int?
    public var createdAt            : String?
    public var updatedAt            : String?
    public var __v                  : Int?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let SuperImpQuestions_list = SuperImpQuestions.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of SuperImpQuestions Instances.
     */
    
    public class func modelsFromDictionaryArray(array: Array<Dictionary<String,Any>>) -> [SuperImpQuestions] {
        var models:[SuperImpQuestions] = []
        for item in array {
            if let model = SuperImpQuestions(dictionary: item) {
                models.append(model)
            }
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let SuperImpQuestions = SuperImpQuestions(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: SuperImpQuestions Instance.
     */
    required public init?(dictionary: Dictionary<String,Any>) {
        
        modifiedDate = dictionary["modifiedDate"] as? String ?? ""
        createdDate = dictionary["createdDate"] as? String ?? ""
        _id = dictionary["_id"] as? String ?? ""
        questions = dictionary["questions"] as? String ?? ""
        option1 = dictionary["option1"] as? String ?? ""
        option2 = dictionary["option2"] as? String ?? ""
        questionAddressTo = dictionary["questionAddressTo"] as? Int ?? 0
        qType = dictionary["qType"] as? Int ?? 0
        createdAt = dictionary["createdAt"] as? String ?? ""
        updatedAt = dictionary["updatedAt"] as? String ?? ""
        __v = dictionary["__v"] as? Int ?? 0
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> Dictionary<String,Any> {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.modifiedDate, forKey: "modifiedDate")
        dictionary.setValue(self.createdDate, forKey: "createdDate")
        dictionary.setValue(self._id, forKey: "_id")
        dictionary.setValue(self.questions, forKey: "questions")
        dictionary.setValue(self.option1, forKey: "option1")
        dictionary.setValue(self.option2, forKey: "option2")
        dictionary.setValue(self.questionAddressTo, forKey: "questionAddressTo")
        dictionary.setValue(self.qType, forKey: "qType")
        dictionary.setValue(self.createdAt, forKey: "createdAt")
        dictionary.setValue(self.updatedAt, forKey: "updatedAt")
        dictionary.setValue(self.__v, forKey: "__v")
        
        return dictionary as! Dictionary<String, Any>
    }
    
}
