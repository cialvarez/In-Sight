//
//  GalleryViewController+CollectionView.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 09/01/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import UIKit

// MARK: UICollectionViewDelegate

extension GalleryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard photos.count > indexPath.row else {
            return
        }
        
        let photoDetailsVC = PhotoDetailsViewController.generateFromStoryboard(photo: photos[indexPath.row])
        show(photoDetailsVC, sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        guard galleryType == .featured else {
            return
        }
        if indexPath.row == photos.count - 2 {
            photoSearchOptions?.page += 1
            photoListOptions?.page += 1
            callPhotoListAPI()
            if photoSearchResultCount > photos.count {
                callPhotoSearchAPI()
            }
        }
    }
    
}

// MARK: UICollectionViewDataSource
extension GalleryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                            for: indexPath) as? ImageCell,
            photos.count > indexPath.row else {
                return ImageCell()
        }
        cell.loadImage(with: photos[indexPath.row].urls?.thumb)
        return cell
    }
    
}
