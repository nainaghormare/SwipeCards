//
//  BibleQuestions.swift
//  VideoDating
//
//  Created by Naina Ghormare on 8/1/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit

class BibleQuestions: NSObject {
    
    public var modifiedDate         : String?
    public var createdDate          : String?
    public var _id                  : String?
    public var questions            : String?
    public var option1              : String?
    public var option2              : String?
    public var option3              : String?
    public var qType                : Int?
    public var correctAnswer        : String?
    public var questionAddressTo    : Int?
    public var createdAt            : String?
    public var updatedAt            : String?
    public var __v                  : Int?
    public var answeredByUser       : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let BibleQuestions_list = BibleQuestions.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of BibleQuestions Instances.
     */
   
    public class func modelsFromDictionaryArray(array: Array<Dictionary<String,Any>>) -> [BibleQuestions] {
        var models:[BibleQuestions] = []
        for item in array {
            if let model = BibleQuestions(dictionary: item) {
                models.append(model)
            }
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let BibleQuestions = BibleQuestions(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: BibleQuestions Instance.
     */
    required public init?(dictionary: Dictionary<String,Any>) {
        
        modifiedDate = dictionary["modifiedDate"] as? String ?? ""
        createdDate = dictionary["createdDate"] as? String ?? ""
        _id = dictionary["_id"] as? String ?? ""
        questions = dictionary["questions"] as? String ?? ""
        option1 = dictionary["option1"] as? String ?? ""
        option2 = dictionary["option2"] as? String ?? ""
        option3 = dictionary["option3"] as? String ?? ""
        qType = dictionary["qType"] as? Int ?? 0
        correctAnswer = dictionary["correctAnswer"] as? String ?? ""
        questionAddressTo = dictionary["questionAddressTo"] as? Int ?? 0
        createdAt = dictionary["createdAt"] as? String ?? ""
        updatedAt = dictionary["updatedAt"] as? String ?? ""
        __v = dictionary["__v"] as? Int ?? 0
        answeredByUser = dictionary["answeredByUser"] as? String ?? ""
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
        dictionary.setValue(self.option3, forKey: "option3")
        dictionary.setValue(self.qType, forKey: "qType")
        dictionary.setValue(self.correctAnswer, forKey: "correctAnswer")
        dictionary.setValue(self.questionAddressTo, forKey: "questionAddressTo")
        dictionary.setValue(self.createdAt, forKey: "createdAt")
        dictionary.setValue(self.updatedAt, forKey: "updatedAt")
        dictionary.setValue(self.__v, forKey: "__v")
        dictionary.setValue(self.answeredByUser, forKey: "answeredByUser")
        
        
        return dictionary as! Dictionary<String,Any>
    }
    
}
