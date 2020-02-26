//
//  ImagePreviewVC.swift
//  TruViewApp
//
//  Created by Liana Norman on 2/26/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

class ImagePreviewVC: UIViewController {
    
    // MARK: - UI Objects
    lazy var previewImageView: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    // MARK: - Properties
    var currentImage: UIImage! {
        didSet {
            previewImageView.image = self.currentImage
        }
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        addConstraints()
        setUpVCView()
    }
    
    // MARK: - Private Methods
    private func addSubViews() {
        view.addSubview(previewImageView)
    }
    
    private func addConstraints() {
        constrainPreviewImageView()
    }
    
    private func setUpVCView() {
        view.backgroundColor = .white
    }
    
    // MARK: - Constraint Methods
    private func constrainPreviewImageView() {
        previewImageView.translatesAutoresizingMaskIntoConstraints = false
        
        [previewImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), previewImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor), previewImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor), previewImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)].forEach({$0.isActive = true})
    }

}
