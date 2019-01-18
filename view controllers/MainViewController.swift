//
//  ViewController.swift
//  ImageDemoApp
//
//  Created by Oniel Rosario on 1/14/19.
//  Copyright © 2019 Oniel Rosario. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController {
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var AddButton: UIBarButtonItem!
    @IBOutlet weak var indexButton: UIButton!
    
    private var allPhotos = [PhotoJournal]() {
        didSet {
            DispatchQueue.main.async {
                self.myCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
//      updateUI()
        if let photos = PhotoJournalHelper.getPhotos() {
            allPhotos = photos
        }

    }
    
    private func updateUI(index: Int) -> UIImage {
        let image = UIImage()
        if let photojournal = PhotoJournalHelper.getPhotos()?[index] {
            _ = UIImage.init(data: photojournal.imageData)
        } else {
            print("photo journal does not exist")
        }
         return image
    }
    
    private func savePhoto(image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            _ = PhotoJournal.init(imageData: imageData, createdAt: "no date", description: "nice pic!")
            PhotoJournalHelper.savePhoto()
        }
    }
    
    
    @IBAction func shareButtton(_ sender: UIButton) {
        let alert = UIAlertController(title: "options", message: "pleae select any of the following", preferredStyle: .actionSheet)
        let edit = UIAlertAction(title: "edit", style: .default){_ in
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            guard let vc = storyBoard.instantiateViewController(withIdentifier: "editController") as? PhotoEditViewController else { return }
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
        let delete = UIAlertAction(title: "remove", style: .destructive){_ in
            PhotoJournalHelper.deletePhoto(photo: allPhotos, atIndex: )
        }
        let share = UIAlertAction(title: "share", style: .default, handler: nil)
        alert.addAction(edit)
        alert.addAction(delete)
        alert.addAction(share)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
     let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
       guard let vc = storyBoard.instantiateViewController(withIdentifier: "editController") as? PhotoEditViewController else { return }
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
      
    }
    
    
}

extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return allPhotos.count
   
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
       let photo = allPhotos[indexPath.row]
        cell.cellImage.image = self.updateUI(index: indexPath.row)
//        cell.cellPicInfo.text = photo?.description ?? ""
        return cell
    }
    
    
}
