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
    @IBOutlet weak var downloadButton: UIButton! {
        didSet {
            downloadButton.setImage(R.image.download()?.withRenderingMode(.alwaysTemplate),
                                    for: .normal)
            downloadButton.tintColor = .white
        }
    }
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
    @IBAction func downloadButtonTapped(_ sender: UIButton) {
        guard let url = photo?.urls?.full else {
            return
        }
        downloadButton.isUserInteractionEnabled = false
        self.updateDownloadButton()
        ImageDownloader.default.downloadImage(with: url, options: nil, progressBlock: nil) { result in
            self.downloadButton.isUserInteractionEnabled = true
            switch result {
            case .success(let value):
                UIImageWriteToSavedPhotosAlbum(value.image, self, nil, nil)
                self.updateDownloadButton(success: true)
            case .failure:
                self.updateDownloadButton(success: false)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let photo = photo else {
            return
        }
        photoImageView.image(with: photo.urls?.regular)
        authorLabel.text = photo.authorInfo?.name ?? ""
        photoToSave = Saved(photo: photo)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateSaveButton()
        updateDownloadButton()
    }
    private func updateSaveButton() {
        guard let photoToSave = photoToSave else {
            return
        }
        saveButton.setImage(photoToSave.isSaved ?
            R.image.saved()?.withRenderingMode(.alwaysTemplate) :
            R.image.not_saved()?.withRenderingMode(.alwaysTemplate),
                            for: .normal)
        saveButton.tintColor = photoToSave.isSaved ? .red : .white
    }
    private func updateDownloadButton(success: Bool? = nil) {
        if !downloadButton.isUserInteractionEnabled {
            flashDownloadButton()
        } else if let success = success {
            downloadButton.alpha = 1
            downloadButton.layer.removeAllAnimations()
            downloadButton.tintColor = success ? .green : .red
            UIView.animate(withDuration: 1,
                           delay: 0,
                           options: [],
                           animations: {
                            self.downloadButton.tintColor = .white
            }, completion: nil)
        }
    }
    func flashDownloadButton() {
        self.downloadButton.alpha = 0
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [.repeat, .autoreverse],
                       animations: {
                        self.downloadButton.alpha = 1
        }, completion: nil)
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
