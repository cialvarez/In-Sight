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
    let refresher = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let layout = collectionView.collectionViewLayout as? PhotoGridLayout {
            layout.delegate = self
        }
        // Register cell classes
        self.collectionView.register(UINib(resource: R.nib.imageCell),
                                     forCellWithReuseIdentifier: reuseIdentifier)
        // Setup the Search Controller
        if galleryType == .featured {
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.placeholder =
                R.string.localizable.gallerySearchBarPlaceholder()
            navigationItem.searchController = searchController
            definesPresentationContext = true
            searchController.searchBar.enablesReturnKeyAutomatically = false
            searchController.searchBar.delegate = self
        }
        // Setup refresh view
        collectionView.alwaysBounceVertical = true
        refresher.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        collectionView.addSubview(refresher)
        // Load photo list
        if galleryType == .featured {
            photoListOptions = UnsplashPhotoListOptions()
            loadPhotoList(shouldReset: true)
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
        photoListOptions?.page = 1
        photoSearchOptions?.page = 1
    }
    @objc private func refreshList() {
        isLoadingPhotos = false
        loadPhotoList(shouldReset: true)
        refresher.endRefreshing()
    }
}

// MARK: Layout Delegate

extension GalleryViewController: PhotoGridLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
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
    func loadPhotoList(shouldReset: Bool = false) {
        guard !isLoadingPhotos else {
            return
        }
        if var options = photoSearchOptions { // For keyword searches, call photo search API
            guard shouldReset ||
                photoSearchResultCount > photos.count else {
                return
            }

            if shouldReset {
                options.page = 1
            } else {
                options.page += 1
            }
            callPhotoSearchAPI(options: options)
        } else if var options = photoListOptions { // For popular photo searches, call photo list API
            if shouldReset {
                options.page = 1
            } else {
                options.page += 1
            }
            callPhotoListAPI(options: options)
        } else { // For favorites
            collectionView.reloadData()
        }
    }

    func callPhotoSearchAPI(options: UnsplashPhotoSearchOptions) {
        let isNewList = options.page == 1
        if isNewList {
            clearPhotos()
        }
        isLoadingPhotos = true
        Alamofire.request(UnsplashPhotoSearchRequest(options: options))
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
    func callPhotoListAPI(options: UnsplashPhotoListOptions) {
        let isNewList = options.page == 1
        if isNewList {
            clearPhotos()
        }
        isLoadingPhotos = true
        Alamofire.request(UnsplashPhotoListRequest(options: options))
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
        isLoadingPhotos = false
        photoSearchOptions = nil
        if photoListOptions == nil {
            photoListOptions = UnsplashPhotoListOptions()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isLoadingPhotos = false
        if let searchQuery = searchBar.text,
            searchQuery != "" {
            photoListOptions = nil
            photoSearchOptions = UnsplashPhotoSearchOptions(query: searchQuery)
        } else {
            photoListOptions = UnsplashPhotoListOptions()
            photoSearchOptions = nil
        }
        loadPhotoList(shouldReset: true)
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
