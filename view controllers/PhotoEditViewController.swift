//
//  PhotoEditViewController.swift
//  ImageDemoApp
//
//  Created by Oniel Rosario on 1/15/19.
//  Copyright © 2019 Oniel Rosario. All rights reserved.
//

import UIKit




class PhotoEditViewController: UIViewController {
    @IBOutlet weak var editPhotoImage: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
     private var imagepickerController: UIImagePickerController!
    @IBOutlet weak var editTextview: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editTextview.delegate = self
        imagePickerView()
        editTextview.becomeFirstResponder()
    }

    
        private func showImageController() {
        present(imagepickerController, animated: true, completion: nil)
    }
    
    private func imagePickerView() {
        imagepickerController = UIImagePickerController()
        imagepickerController.delegate = self
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            cameraButton.isEnabled = false
        }
    }
    
    
    private func doneEditing() {
        
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        guard let titletextview = editTextview.text else { return }
       let date = Date()
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate,
                                          .withFullTime,
                                          .withInternetDateTime,
                                          .withTimeZone,
                                          .withDashSeparatorInDate]
        let timeStamp = isoDateFormatter.string(from: date)
        var imageData = Data()
        _ = DataPersistenceManager.filePathToDocumentsDirectory(filename: PhotoJournalHelper.filename)
        do {
            let data = try PropertyListEncoder().encode(PhotoJournalHelper.getPhotos())
           imageData = data
        } catch {
            print("property list error: \(error)")
        }
        let photo = PhotoJournal.init(imageData: imageData, createdAt: timeStamp, description: titletextview)
       PhotoJournalHelper.addPhoto(photo: photo)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        imagepickerController.sourceType = .camera
        showImageController()
    }
    
    @IBAction func photoLibraryPressed(_ sender: UIBarButtonItem) {
//        imagepickerController.sourceType = .photoLibrary
        showImageController()
    }
}

extension PhotoEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            editPhotoImage.image = image
        } else {
            print("original image is nil")
        }
        dismiss(animated: true, completion: nil)
    }
}

extension PhotoEditViewController: UITextViewDelegate {
    
    
    
}
