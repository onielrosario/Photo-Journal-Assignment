//
//  DataPersistenceManager.swift
//  ImageDemoApp
//
//  Created by Oniel Rosario on 1/15/19.
//  Copyright © 2019 Oniel Rosario. All rights reserved.
//

import Foundation


final class DataPersistenceManager {
    static func DocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    
    static func filePathToDocumentsDirectory(filename: String) -> URL {
      return DocumentsDirectory().appendingPathComponent(filename)
    }
}
