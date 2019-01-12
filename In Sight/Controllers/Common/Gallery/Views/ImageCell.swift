//
//  ImageCell.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 04/01/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import UIKit
import Kingfisher

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView! {
        didSet {
            photoImageView.kf.indicatorType = .activity
            (photoImageView.kf.indicator?.view as? UIActivityIndicatorView)?.color = .white
        }
    }
    func loadImage(with url: URL?) {
        photoImageView.image(with: url)
    }
}
