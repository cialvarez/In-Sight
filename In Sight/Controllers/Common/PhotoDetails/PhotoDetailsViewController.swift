//
//  PhotoDetailsViewController.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 08/01/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoDetailsViewController: UIViewController {
    var photo: UnsplashPhotoList?
    var photoToSave: Saved?
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView! {
        didSet {
            photoImageView.kf.indicatorType = .activity
            (photoImageView.kf.indicator?.view as? UIActivityIndicatorView)?.color = .white
        }
    }
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let photoToSave = photoToSave else {
            return
        }
        if photoToSave.isSaved {
            photoToSave.remove()
        } else {
            photoToSave.add()
        }
        updateSaveButton()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let photo = photo else {
            return
        }
        photoImageView.image(with: photo.urls?.full)
        authorLabel.text = photo.authorInfo?.name ?? ""
        photoToSave = Saved(photo: photo)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateSaveButton()
    }
    private func updateSaveButton() {
        guard let photoToSave = photoToSave else {
            return
        }
        saveButton.setImage(photoToSave.isSaved ?
            R.image.saved_filled_48pt()?.withRenderingMode(.alwaysTemplate) :
            R.image.saved_48pt()?.withRenderingMode(.alwaysTemplate),
                            for: .normal)
        saveButton.tintColor = photoToSave.isSaved ? .red : .white
    }

}

extension PhotoDetailsViewController {
    static func generateFromStoryboard(photo: UnsplashPhotoList) -> UIViewController {
        guard let photoDetailsVC =
            R.storyboard.photoDetails().instantiateInitialViewController() as? PhotoDetailsViewController else {
            return UIViewController()
        }
        photoDetailsVC.photo = photo
        return photoDetailsVC
    }
}
