//
//  UserServices.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/31/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit
import FirebaseInstanceID

public class UserService:APIService {
    
    func getDeviceToken() -> String{
        var deviceToken = ""
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
                deviceToken = "\(result.token)"
            }
        }
        return deviceToken
    }
    
    //MARK: - Login API
    func login(with email: String, password: String, target: BaseViewController? = nil, complition: @escaping (User?) -> Void) {
        let param = [ApiKeys.kEmail: email, ApiKeys.kPassword: password, ApiKeys.kDevice_type: "iOS", ApiKeys.kDevice_token: getDeviceToken()]
        target?.showLoader()
        super.startService(with: .POST, path: Config.ServiceName.login, parameters: param, target: target!, files: []) { (result) in
            DispatchQueue.main.async {
                target?.hideLoader()
                switch result {
                case .Success(let response):
                    if let data = response as? Dictionary<String,Any> {
                        if let dataModel = data["data"]  as? Dictionary<String,Any>{
                            let user = User(dictionary: dataModel)
                            complition(user)
                        } else {
                            complition(nil)
                        }
                    } else {
                        complition(nil)
                    }
                case .Error(let error):
                    if error == "404" {
                        target?.alertForRegister(isReg: true)
                    }
                    complition(nil)
                }
            }
        }
    }
    
    //MARK: - SignUp API
    func signUp(with firstName: String, lastName: String, email: String, gender: Int, DOB: String, loginType: Int, facebookSocialId: String, googleSocialId: String, password: String, target: BaseViewController? = nil, complition: @escaping (User?) -> Void) {
        let param = [ApiKeys.kEmail: email, ApiKeys.kPassword: password, ApiKeys.kDevice_type: "iOS", ApiKeys.kDevice_token: getDeviceToken(), ApiKeys.kFirstName: firstName, ApiKeys.kLastName: lastName, ApiKeys.kGender: gender, ApiKeys.kDOB: DOB, ApiKeys.kLoginType: loginType, ApiKeys.kFacebookSocialId: facebookSocialId, ApiKeys.kGoogleSocialId: googleSocialId] as [String : Any]
        print(param)
        target?.showLoader()
        super.startService(with: .POST, path: Config.ServiceName.signUp, parameters: param, target: target!, files: []) { (result) in
            DispatchQueue.main.async {
                target?.hideLoader()
                switch result {
                case .Success(let response):
                    if let data = response as? Dictionary<String,Any> {
                        if let dataModel = data["data"]  as? Dictionary<String,Any> {
                            let user = User(dictionary: dataModel)
                            complition(user)
                        } else {
                            complition(nil)
                        }
                    } else {
                        complition(nil)
                    }
                case .Error(let error):
                    target?.okAlert(msg: error)
                    complition(nil)
                }
            }
        }
    }
    
    //MARK: - getSuperImportantQuestions API
    func getSuperImportantQuestions(with id: String, target: BaseViewController? = nil, complition: @escaping ([SuperImpQuestions]?) -> Void) {
        let param = [ApiKeys.kId: id]
        print(param)
        target?.showLoader()
        super.startService(with: .POST, path: Config.ServiceName.getSuperImportantQuestions, parameters: param, target: target!, files: []) { (result) in
            DispatchQueue.main.async {
                target?.hideLoader()
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let data = ((response as? Dictionary<String,Any>)?["data"] as? Array<Dictionary<String,Any>>) {
                        let questions = SuperImpQuestions.modelsFromDictionaryArray(array: data)
                        complition(questions)
                    } else {
                        complition(nil)
                    }
                case .Error(let error):
                    // #display error message here
                    target?.okAlert(msg: error)
                    complition(nil)
                }
            }
        }
    }
    
    //MARK: - gettheBibleQuestions API
    func gettheBibleQuestions(with target: BaseViewController? = nil, complition: @escaping ([BibleQuestions]?) -> Void) {
        let param = [ApiKeys.kUser_id: AppInstance.shared.user?._id ?? ""]
        print(param)
        target?.showLoader()
        super.startService(with: .POST, path: Config.ServiceName.gettheBibleQuestions, parameters: param, target: target!, files: []) { (result) in
            DispatchQueue.main.async {
                target?.hideLoader()
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let data = ((response as? Dictionary<String,Any>)?["data"] as? Array<Dictionary<String,Any>>) {
                        let questions = BibleQuestions.modelsFromDictionaryArray(array: data)
                        complition(questions)
                    } else {
                        complition(nil)
                    }
                case .Error(let error):
                    // #display error message here
                    target?.okAlert(msg: error)
                    complition(nil)
                }
            }
        }
    }
    
    //MARK: - saveSuperImportantQuestions API
    func saveSuperImportantQuestions(with userid: String, answer: [Dictionary<String,String>], target: BaseViewController? = nil, complition: @escaping (String?) -> Void) {
        let param = [ApiKeys.kUser_id: userid, ApiKeys.kAnswer: answer] as [String : Any]
        print(param)
        target?.showLoader()
        super.startService(with: .POST, path: Config.ServiceName.addUseranswersForQuestion, parameters: param, target: target!, files: []) { (result) in
            DispatchQueue.main.async {
                target?.hideLoader()
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let data = response as? Dictionary<String,Any> {
                        if let msg = data["message"] as? String {
                            complition(msg)
                        }
                        complition(nil)
                    } else {
                        complition(nil)
                    }
                case .Error(let error):
                    // #display error message here
                    target?.okAlert(msg: error)
                    complition(nil)
                }
            }
        }
    }
    
    //MARK: - savetheBibleQuestions API
    func savetheBibleQuestions(with userid: String, answer: [Dictionary<String,String>], target: BaseViewController? = nil, complition: @escaping (User?) -> Void) {
        let param = [ApiKeys.kUser_id: userid, ApiKeys.kAnswer: answer] as [String : Any]
        print(param)
        target?.showLoader()
        super.startService(with: .POST, path: Config.ServiceName.answerBibleQuestion, parameters: param, target: target!, files: []) { (result) in
            DispatchQueue.main.async {
                target?.hideLoader()
                switch result {
                case .Success(let response):
                    if let data = response as? Dictionary<String,Any> {
                        if let dataModel = data["data"]  as? Dictionary<String,Any> {
                            let user = User(dictionary: dataModel)
                            complition(user)
                        } else {
                            complition(nil)
                        }
                    } else {
                        complition(nil)
                    }
                case .Error(let error):
                    target?.okAlert(msg: error)
                    complition(nil)
                }
            }
        }
    }
    
    //MARK: - forgotPassword API
    func forgotPassword(with email: String, target: BaseViewController? = nil, complition: @escaping (String?) -> Void) {
        let param = [ApiKeys.kEmail: email, ApiKeys.kDevice_type: "iOS", ApiKeys.kDevice_token: getDeviceToken()]
        target?.showLoader()
        super.startService(with: .POST, path: Config.ServiceName.forgotpassword, parameters: param, target: target!, files: []) { (result) in
            DispatchQueue.main.async {
                target?.hideLoader()
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let data = response as? Dictionary<String,Any> {
                        if let msg = data["message"] as? String {
                            complition(msg)
                        }
                        complition(nil)
                    } else {
                        complition(nil)
                    }
                case .Error(let error):
                    // #display error message here
                    complition(error)
                }
            }
        }
    }
    
}
