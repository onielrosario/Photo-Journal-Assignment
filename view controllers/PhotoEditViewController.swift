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
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    var photo: PhotoJournal?
    var index: Int!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        editTextview.delegate = self
        imagePickerView()
        editTextview.becomeFirstResponder()
        if let photo = photo {
            editPhotoImage.image = UIImage.init(data: photo.imageData)
        }
        
    }

    
        private func showImageController() {
        present(imagepickerController, animated: true, completion: nil)
    }
    
    @IBAction func tappedrecognizer(_ sender: UITapGestureRecognizer) {
        editTextview.resignFirstResponder()
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
            if let imageData = editPhotoImage.image?.jpegData(compressionQuality: 0.5) {
                let photo = PhotoJournal.init(imageData: imageData, createdAt: photo.createdAt, description: photo.description)
                 PhotoJournalHelper.addPhoto(photo: photo)
                dismiss(animated: true, completion: nil)
            }
        if isEditing {
       let date = Date()
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate,
                                          .withFullTime,
                                          .withInternetDateTime,
                                          .withTimeZone,
                                          .withDashSeparatorInDate]
        let timeStamp = isoDateFormatter.string(from: date)
        if let imageData = editPhotoImage.image?.jpegData(compressionQuality: 0.5) {
        let photo = PhotoJournal.init(imageData: imageData, createdAt: timeStamp, description: titletextview)
        PhotoJournalHelper.editPhoto(photo: photo, atIndex: index)
        dismiss(animated: true, completion: nil)
        }
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
