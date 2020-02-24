//
//  CreateListingVC.swift
//  TruViewApp
//
//  Created by Liana Norman on 2/13/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit
import Photos

class CreateListingVC: UIViewController {
    
    // MARK: - UI Objects
    let createListingView: CreateListingView = {
        let view = CreateListingView()
        return view
    }()
    
    // MARK: - Properties
    var photoLibraryAccessIsAuthorized = false

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setUpVCViews()
        delegation()
        checkPhotoLibraryAccess()
    }
    
    // MARK: - Private Methods
    private func addSubViews() {
        view.addSubview(createListingView)
    }
    
    private func setUpVCViews() {
        view.backgroundColor = .white
    }
    
    private func delegation() {
        createListingView.collectionView.collectionView.dataSource = self
        createListingView.collectionView.collectionView.delegate = self
    }
    
    private func checkPhotoLibraryAccess() {
        let status = PHPhotoLibrary.authorizationStatus()

        switch status {
        case .authorized:
            print(status)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { [weak self] (status) in
                switch status {
                case .authorized:
                    self?.photoLibraryAccessIsAuthorized = true
                case .notDetermined:
                    print("not determined")
                case .restricted:
                    print("restricted")
                case .denied:
                    self?.photoLibraryAccessIsAuthorized = false
                @unknown default:
                    fatalError("This is outside of any authorization case.")
                }
            }
        case .restricted:
            print("restricted")
        case .denied:
            photoLibraryAccessIsAuthorized = false
        @unknown default:
            print("nothing should happen here")
        }
    }
    
}

extension CreateListingVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = createListingView.collectionView.collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.listViewCVCell.rawValue, for: indexPath) as? ListingCVCell {
            cell.aptThumbnail.image = UIImage(systemName: "bed.double")
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}

extension CreateListingVC: UICollectionViewDelegate {}

extension CreateListingVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 7, height: view.frame.height / 10)
    }
}
