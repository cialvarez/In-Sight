//
//  GalleryViewController.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 04/01/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

let reuseIdentifier = R.reuseIdentifier.imageCell.identifier

enum GalleryType {
    case favorites
    case featured
}

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var photoListOptions: UnsplashPhotoListOptions?
    var photoSearchOptions: UnsplashPhotoSearchOptions?
    var photoSearchResultCount = 0
    var photos = [UnsplashPhotoList]()
    var isLoadingPhotos = false
    let searchController = UISearchController(searchResultsController: nil)
    var galleryType = GalleryType.featured
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let layout = collectionView.collectionViewLayout as? PhotoGridLayout {
            layout.delegate = self
        }
        // Register cell classes
        self.collectionView.register(UINib(resource: R.nib.imageCell),
                                     forCellWithReuseIdentifier: reuseIdentifier)
        
        // Setup the Search Controller
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Find Photos"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // Setup the Scope Bar
        searchController.searchBar.delegate = self

        if galleryType == .featured {
            photoListOptions = UnsplashPhotoListOptions()
            callPhotoListAPI()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if galleryType == .favorites {
            photos = Saved.allStoredData().compactMap({$0.photo})
        }
        collectionView.reloadData()
    }
    
    func clearPhotos() {
        photos =  [UnsplashPhotoList]()
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

// MARK: Layout Delegate

extension GalleryViewController: PhotoGridLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        guard photos.count > indexPath.row else {
            return 0
        }
        
        let currentPhoto = photos[indexPath.row]
        let cellWidth = (collectionView.bounds.width / 2) - 20
        
        return (currentPhoto.height / currentPhoto.width) * cellWidth
    }
}

// MARK: Network Requests

extension GalleryViewController {

    func callPhotoSearchAPI() {
        guard let photoSearchOptions = photoSearchOptions,
            !isLoadingPhotos else {
                return
        }
        let isNewList = photoSearchOptions.page == 1
        if isNewList {
            clearPhotos()
        }
        isLoadingPhotos = true
        Alamofire.request(UnsplashPhotoSearchRequest(options: photoSearchOptions))
            .responseObject { [weak self] (response: DataResponse<UnsplashPhotoSearchResponse>) in
                switch response.result {
                case .success(let response):
                    self?.photos += response.results
                    self?.photoSearchResultCount = response.total
                case .failure(let error):
                    print(error)
                }
                self?.isLoadingPhotos = false
                self?.collectionView.reloadData()
                self?.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    func callPhotoListAPI() {
        guard galleryType == .featured else {
            collectionView.reloadData()
            return
        }
        
        guard let photoListOptions = photoListOptions,
            !isLoadingPhotos else {
            return
        }
        let isNewList = photoListOptions.page == 1
        if isNewList {
            clearPhotos()
        }
        
        isLoadingPhotos = true
        Alamofire.request(UnsplashPhotoListRequest(options: photoListOptions))
            .responseArray { [weak self] (response: DataResponse<[UnsplashPhotoList]>) in
                switch response.result {
                case .success(let photoList):
                    self?.photos += photoList
                case .failure(let error):
                    print(error)
                }
                self?.isLoadingPhotos = false
                self?.collectionView.reloadData()
                self?.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
}

// MARK: - UISearchBar Delegate

extension GalleryViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        photoSearchOptions = nil
        if photoListOptions == nil {
            photoListOptions = UnsplashPhotoListOptions()
        }
        callPhotoListAPI()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        photoListOptions = nil
        if photoSearchOptions == nil {
            photoSearchOptions = UnsplashPhotoSearchOptions(query: searchBar.text ?? "")
        }
        photoSearchOptions?.page = 1
        callPhotoSearchAPI()
    }
}

extension GalleryViewController {
    
    static func generateFromStoryboard(galleryType: GalleryType = .featured) -> UIViewController {
        guard let navigationVC = R.storyboard.gallery().instantiateInitialViewController() as? UINavigationController,
            let galleryVC = navigationVC.visibleViewController as? GalleryViewController else {
                assertionFailure()
                return UINavigationController(rootViewController: UIViewController())
        }
        
        galleryVC.galleryType = galleryType
        
        return navigationVC
    }
}
