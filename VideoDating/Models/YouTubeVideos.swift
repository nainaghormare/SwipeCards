//
//  YouTubeVideos.swift
//  VideoDating
//
//  Created by Naina Ghormare on 8/20/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import Foundation

/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class YouTubeVideos {
    public var _id              : String?
    public var youtube_url      : String?
    public var title            : String?
    public var subtitle         : String?
    public var videoId          : String?
    public var thumbnail_url    : String?
    public var isPlayed         : Bool?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let YouTubeVideos_list = YouTubeVideos.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of YouTubeVideos Instances.
     */
    public class func modelsFromDictionaryArray(array: Array<Dictionary<String,Any>>) -> [YouTubeVideos] {
        var models:[YouTubeVideos] = []
        for item in array {
            if let model = YouTubeVideos(dictionary: item) {
                models.append(model)
            }
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let YouTubeVideos = YouTubeVideos(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: YouTubeVideos Instance.
     */
    required public init?(dictionary: Dictionary<String,Any>) {
        
        _id             = dictionary["_id"] as? String ?? ""
        youtube_url     = dictionary["youtube_url"] as? String ?? ""
        title           = dictionary["title"] as? String ?? ""
        subtitle        = dictionary["subtitle"] as? String ?? ""
        videoId         = dictionary["videoId"] as? String ?? ""
        thumbnail_url   = dictionary["thumbnail_url"] as? String ?? ""
        isPlayed        = dictionary["isPlayed"] as? Bool ?? false
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> Dictionary<String,Any> {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self._id, forKey: "_id")
        dictionary.setValue(self.youtube_url, forKey: "youtube_url")
        dictionary.setValue(self.title, forKey: "title")
        dictionary.setValue(self.subtitle, forKey: "subtitle")
        dictionary.setValue(self.videoId, forKey: "videoId")
        dictionary.setValue(self.thumbnail_url, forKey: "thumbnail_url")
        dictionary.setValue(self.isPlayed, forKey: "isPlayed")
        
        return dictionary as! Dictionary<String, Any>
    }
    
}
