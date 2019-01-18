//
//  PhotoJournalModel.swift
//  ImageDemoApp
//
//  Created by Oniel Rosario on 1/17/19.
//  Copyright © 2019 Oniel Rosario. All rights reserved.
//

import Foundation

final class PhotoJournalHelper {
    public static let filename = "PhotojournalList.plist"
    private static var photos = [PhotoJournal]()
    
    
    private init() {}
    static func savePhoto() {
        let path = DataPersistenceManager.filePathToDocumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(photos)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("property list error: \(error)")
        }
    }
    static func getPhotos() -> [PhotoJournal]? {
        let path = DataPersistenceManager.filePathToDocumentsDirectory(filename: filename).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    photos = try PropertyListDecoder().decode([PhotoJournal].self, from: data)
                } catch {
                    print("propery list decoding error: \(error)")
                }
            } else {
                print("getPhotojournal - data is nil")
            }
        } else {
            print("\(filename) does not exist")
        }
        return photos
    }
    
    static func addPhoto(photo: PhotoJournal) {
        photos.append(photo)
        savePhoto()
    }
    
    static func deletePhoto(atIndex index: Int) {
        photos.remove(at: index)
        savePhoto()
    }
    
    static func editPhoto(photo: PhotoJournal, atIndex index: Int) {
    photos[index] = photo
        savePhoto()
    }
    
    
    
}
