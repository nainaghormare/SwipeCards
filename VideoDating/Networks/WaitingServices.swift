//
//  WaitingServices.swift
//  VideoDating
//
//  Created by Naina Ghormare on 8/20/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import Foundation

public class WaitingServices: APIService {
    
    //MARK: - get youtube video list API
    func getYoutubeVideoList(with target: BaseViewController? = nil, complition: @escaping ([YouTubeVideos]?) -> Void) {
        target?.showLoader()
        super.startService(with: .GET, path: Config.ServiceName.getYouTubeLink, parameters: [:], target: target!, files: []) { (result) in
            DispatchQueue.main.async {
                target?.hideLoader()
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let data = ((response as? Dictionary<String,Any>)?["data"] as? Array<Dictionary<String,Any>>) {
                        let videos = YouTubeVideos.modelsFromDictionaryArray(array: data)
                        complition(videos)
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
    
    //MARK: - get youtube video list API
    func getWaitingQuestions(with target: BaseViewController? = nil, complition: @escaping ([WaitingQuestions]?) -> Void) {
        target?.showLoader()
        super.startService(with: .GET, path: Config.ServiceName.getWaitingScreenQuestions, parameters: [:], target: target!, files: []) { (result) in
            DispatchQueue.main.async {
                target?.hideLoader()
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let data = ((response as? Dictionary<String,Any>)?["data"] as? Array<Dictionary<String,Any>>) {
                        let questions = WaitingQuestions.modelsFromDictionaryArray(array: data)
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
    
}
