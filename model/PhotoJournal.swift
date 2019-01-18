//
//  PhotoJournal.swift
//  ImageDemoApp
//
//  Created by Oniel Rosario on 1/15/19.
//  Copyright © 2019 Oniel Rosario. All rights reserved.
//

import Foundation


struct PhotoJournal: Codable {
    var imageData: Data
    var createdAt: String
    var description: String
    public var dateFormattedString: String {
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = createdAt
        if let date = isoDateFormatter.date(from: createdAt) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy hh:mm a"
            formattedDate = dateFormatter.string(from: date)
        }
        return formattedDate
    }
}
