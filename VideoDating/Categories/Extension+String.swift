//
//  Extension+String.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/31/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import Foundation

extension String {
    
    func toDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func trimSpaces() -> String {
        if(self.length() > 0) {
            return self.trimmingCharacters(in: CharacterSet.whitespaces)
        }
        return self
    }
    
    func length() -> Int {
        return self.count
    }
    
    func getAttributedString(font: UIFont, color: UIColor, text: String) -> NSAttributedString {
        let attrs = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor : color, NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
        let stringWithAttribute = NSAttributedString(string: text,
                                                     attributes: attrs)
        return stringWithAttribute
    }
    
}

