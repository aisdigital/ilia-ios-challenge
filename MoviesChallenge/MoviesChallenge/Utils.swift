//
//  Utils.swift
//  MoviesChallenge
//
//  Created by Lucas Santana Brito on 22/03/20.
//  Copyright © 2020 lsb. All rights reserved.
//

import Foundation
import UIKit

final class Utils {
    
    static func getFormattedDate(dateString: String) -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        
        let dateFormatInput = format.date(from: dateString)
        format.dateFormat = "MMM d, yyy"
        
        guard let date = dateFormatInput else {
            debugPrint("Could not conver date")
            return "N/A"
        }
        
        return format.string(from: date)
    }
    
    static func getTimeMove(runtime: Int) -> String {
        let hour = runtime / 60
        let min = runtime % 60
        
        return "\(hour)h \(min)m"
    }
    
    static func alert(title: String, message: String, handler: ((UIAlertAction) -> Void)?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        return alert
    }
}
