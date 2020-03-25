//
//  CreateListingView.swift
//  TruViewApp
//
//  Created by Liana Norman on 2/13/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit

class CreateListingView: UIView {

    // MARK: - UI objects
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.4256733358, green: 0.5473166108, blue: 0.3936028183, alpha: 1), for: .normal)
        button.backgroundColor = .systemBackground
        button.titleLabel?.font = UIFont(name: "BanglaSangamMN-Bold", size: 27)
        return button
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.4256733358, green: 0.5473166108, blue: 0.3936028183, alpha: 1), for: .normal)
        button.backgroundColor = .systemBackground
        button.titleLabel?.font = UIFont(name: "BanglaSangamMN-Bold", size: 27)
        return button
    }()
    
    lazy var streetAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "Street Address"
        label.font = UIFont(name: "BanglaSangamMN", size: 18)
        return label
    }()
    
    lazy var streetAddressTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter street address"
        return tf
    }()
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "City"
        label.font = UIFont(name: "BanglaSangamMN", size: 18)
        return label
    }()
    
    lazy var cityTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter city"
        return tf
    }()
    
    lazy var stateLabel: UILabel = {
        let label = UILabel()
        label.text = "State"
        label.font = UIFont(name: "BanglaSangamMN", size: 18)
        return label
    }()
    
    lazy var stateTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter state"
        return tf
    }()
    
    lazy var zipcodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Zipcode"
        label.font = UIFont(name: "BanglaSangamMN", size: 18)
        return label
    }()
    
    lazy var zipcodeTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter zipcode"
        return tf
    }()
    
    lazy var purchaseTypeSegController: UISegmentedControl = {
        let items = ["For Sale", "For Rent", "Room Shares"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentTintColor = #colorLiteral(red: 0.4256733358, green: 0.5473166108, blue: 0.3936028183, alpha: 1)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    lazy var numOfBedroomsLabel: UILabel = {
        let label = UILabel()
        label.text = "Number of Bedrooms"
        label.textColor = .gray
        label.font = UIFont(name: "BanglaSangamMN", size: 18)
        return label
    }()
    
    lazy var numOfBedroomsSegController: UISegmentedControl = {
        let items = ["Studio", "1", "2", "3", "4", "5"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentTintColor = #colorLiteral(red: 0.4256733358, green: 0.5473166108, blue: 0.3936028183, alpha: 1)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    lazy var numOfBathsLabel: UILabel = {
        let label = UILabel()
        label.text = "Number of Bathrooms"
        label.textColor = .gray
        label.font = UIFont(name: "BanglaSangamMN", size: 18)
        return label
    }()
    
    lazy var numOfBathsSegController: UISegmentedControl = {
        let items = ["1", "2", "3", "4", "5"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentTintColor = #colorLiteral(red: 0.4256733358, green: 0.5473166108, blue: 0.3936028183, alpha: 1)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    lazy var squareFootageLabel: UILabel = {
        let label = UILabel()
        label.text = "Square footage"
        label.font = UIFont(name: "BanglaSangamMN", size: 18)
        return label
    }()
    
    lazy var sqFootageTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter square footage"
        return tf
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Price"
        label.font = UIFont(name: "BanglaSangamMN", size: 18)
        return label
    }()
    
    lazy var priceTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter price"
        return tf
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont(name: "BanglaSangamMN", size: 18)
        return label
    }()
    
    lazy var descriptionTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont(name: "BanglaSangamMN", size: 18)
        return tv
    }()
    
    lazy var manageCoverPhotosButton: UIButton = {
        let button = UIButton()
        button.setTitle("Manage Cover Photos", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.4256733358, green: 0.5473166108, blue: 0.3936028183, alpha: 1)
        return button
    }()
    
    lazy var manageTourPhotosButton: UIButton = {
        let button = UIButton()
        button.setTitle("Manage Virtual Tour Photos", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.4256733358, green: 0.5473166108, blue: 0.3936028183, alpha: 1)
        return button
    }()
    
    lazy var createTourButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Tour", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.4256733358, green: 0.5473166108, blue: 0.3936028183, alpha: 1)
        return button
    }()
    
    // MARK: - Properties
    let svContentSize = UIScreen.main.bounds.height * 2
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        addConstraints()
        setUpViewUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func enableConstraintsForWidth(_ horizontalSizeClass: UIUserInterfaceSizeClass) {
      if horizontalSizeClass == .regular {
//        NSLayoutConstraint.deactivate(compactConstraints)
//        NSLayoutConstraint.activate(regularConstraints)
      } else {
//        NSLayoutConstraint.deactivate(regularConstraints)
//        NSLayoutConstraint.activate(compactConstraints)
      }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
      super.traitCollectionDidChange(previousTraitCollection)
      if traitCollection.horizontalSizeClass != previousTraitCollection?.horizontalSizeClass {
        enableConstraintsForWidth(traitCollection.horizontalSizeClass)
      }
    }
    
    // MARK: - Private Methods
    private func addSubViews() {
        addSubview(cancelButton)
        addSubview(saveButton)
        addSubview(streetAddressLabel)
        addSubview(streetAddressTextField)
        addSubview(cityLabel)
        addSubview(cityTextField)
        addSubview(stateLabel)
        addSubview(stateTextField)
        addSubview(zipcodeLabel)
        addSubview(zipcodeTextField)
        addSubview(purchaseTypeSegController)
        addSubview(numOfBedroomsLabel)
        addSubview(numOfBedroomsSegController)
        addSubview(numOfBathsLabel)
        addSubview(numOfBathsSegController)
        addSubview(squareFootageLabel)
        addSubview(sqFootageTextField)
        addSubview(priceLabel)
        addSubview(priceTextField)
        addSubview(descriptionLabel)
        addSubview(descriptionTextView)
        addSubview(manageCoverPhotosButton)
        addSubview(manageTourPhotosButton)
        addSubview(createTourButton)
        
    }
    
    private func addConstraints() {
        constrainCancelButton()
        constrainSaveButton()
        constrainStreetAddressLabel()
        constrainStreetAddressTextField()
        constrainCityLabel()
        constrainCityTextField()
        constrainStateLabel()
        constrainStateTextField()
        constrainZipcodeLabel()
        constrainZipcodeTextField()
        constrainPurchaseTypeSegControl()
        constrainNumOfBedroomsLabel()
        constrainNumOfBedSegControl()
        constrainNumOfBathsLabel()
        constrainNumOfBathsSegControl()
        constrainSqFootageLabel()
        constrainSqFootageTextField()
        constrainPriceLabel()
        constrainPriceTextField()
        constrainDescriptionLabel()
        constrainDescriptionTextView()
        constrainCoverPhotosButton()
        constrainTourPhotosButton()
        constrainCreateTourButton()
    }
    
    private func setUpViewUI() {
        backgroundColor = .systemBackground
    }
    
    // MARK: - Constraint Methods
    private func constrainCancelButton() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        [cancelButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor), cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor), cancelButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25), cancelButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.025)].forEach({$0.isActive = true})
    }
    
    private func constrainSaveButton() {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        [saveButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor), saveButton.trailingAnchor.constraint(equalTo: trailingAnchor), saveButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor), saveButton.heightAnchor.constraint(equalTo: cancelButton.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainStreetAddressLabel() {
        streetAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [streetAddressLabel.topAnchor.constraint(equalTo: cancelButton.bottomAnchor), streetAddressLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.92), streetAddressLabel.centerXAnchor.constraint(equalTo: centerXAnchor), streetAddressLabel.heightAnchor.constraint(equalTo: cancelButton.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainStreetAddressTextField() {
        streetAddressTextField.translatesAutoresizingMaskIntoConstraints = false
        
        [streetAddressTextField.topAnchor.constraint(equalTo: streetAddressLabel.bottomAnchor), streetAddressTextField.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), streetAddressTextField.centerXAnchor.constraint(equalTo: centerXAnchor), streetAddressTextField.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainCityLabel() {
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [cityLabel.topAnchor.constraint(equalTo: streetAddressTextField.bottomAnchor), cityLabel.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), cityLabel.centerXAnchor.constraint(equalTo: centerXAnchor), cityLabel.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainCityTextField() {
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        
        [cityTextField.topAnchor.constraint(equalTo: cityLabel.bottomAnchor), cityTextField.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), cityTextField.centerXAnchor.constraint(equalTo: centerXAnchor), cityTextField.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainStateLabel() {
        stateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [stateLabel.topAnchor.constraint(equalTo: cityTextField.bottomAnchor), stateLabel.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), stateLabel.centerXAnchor.constraint(equalTo: centerXAnchor), stateLabel.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainStateTextField() {
        stateTextField.translatesAutoresizingMaskIntoConstraints = false
        
        [stateTextField.topAnchor.constraint(equalTo: stateLabel.bottomAnchor), stateTextField.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), stateTextField.centerXAnchor.constraint(equalTo: centerXAnchor), stateTextField.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainZipcodeLabel() {
        zipcodeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [zipcodeLabel.topAnchor.constraint(equalTo: stateTextField.bottomAnchor), zipcodeLabel.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), zipcodeLabel.centerXAnchor.constraint(equalTo: centerXAnchor), zipcodeLabel.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainZipcodeTextField() {
        zipcodeTextField.translatesAutoresizingMaskIntoConstraints = false
        
        [zipcodeTextField.topAnchor.constraint(equalTo: zipcodeLabel.bottomAnchor), zipcodeTextField.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), zipcodeTextField.centerXAnchor.constraint(equalTo: centerXAnchor), zipcodeTextField.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainPurchaseTypeSegControl() {
        purchaseTypeSegController.translatesAutoresizingMaskIntoConstraints = false
        
        [purchaseTypeSegController.topAnchor.constraint(equalTo: zipcodeTextField.bottomAnchor, constant: svContentSize * 0.01), purchaseTypeSegController.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), purchaseTypeSegController.centerXAnchor.constraint(equalTo: centerXAnchor), purchaseTypeSegController.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainNumOfBedroomsLabel() {
        numOfBedroomsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [numOfBedroomsLabel.topAnchor.constraint(equalTo: purchaseTypeSegController.bottomAnchor), numOfBedroomsLabel.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), numOfBedroomsLabel.centerXAnchor.constraint(equalTo: centerXAnchor), numOfBedroomsLabel.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor, multiplier: 1.3)].forEach({$0.isActive = true})
    }
    
    private func constrainNumOfBedSegControl() {
        numOfBedroomsSegController.translatesAutoresizingMaskIntoConstraints = false
        
        [numOfBedroomsSegController.topAnchor.constraint(equalTo: numOfBedroomsLabel.bottomAnchor), numOfBedroomsSegController.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), numOfBedroomsSegController.centerXAnchor.constraint(equalTo: centerXAnchor), numOfBedroomsSegController.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainNumOfBathsLabel() {
        numOfBathsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [numOfBathsLabel.topAnchor.constraint(equalTo: numOfBedroomsSegController.bottomAnchor), numOfBathsLabel.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), numOfBathsLabel.centerXAnchor.constraint(equalTo: centerXAnchor), numOfBathsLabel.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor, multiplier: 1.3)].forEach({$0.isActive = true})
    }
    
    private func constrainNumOfBathsSegControl() {
        numOfBathsSegController.translatesAutoresizingMaskIntoConstraints = false
        
        [numOfBathsSegController.topAnchor.constraint(equalTo: numOfBathsLabel.bottomAnchor), numOfBathsSegController.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), numOfBathsSegController.centerXAnchor.constraint(equalTo: centerXAnchor), numOfBathsSegController.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainSqFootageLabel() {
        squareFootageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [squareFootageLabel.topAnchor.constraint(equalTo: numOfBathsSegController.bottomAnchor, constant: svContentSize * 0.01), squareFootageLabel.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), squareFootageLabel.centerXAnchor.constraint(equalTo: centerXAnchor), squareFootageLabel.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainSqFootageTextField() {
        sqFootageTextField.translatesAutoresizingMaskIntoConstraints = false
        
        [sqFootageTextField.topAnchor.constraint(equalTo: squareFootageLabel.bottomAnchor), sqFootageTextField.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), sqFootageTextField.centerXAnchor.constraint(equalTo: centerXAnchor), sqFootageTextField.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainPriceLabel() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [priceLabel.topAnchor.constraint(equalTo: sqFootageTextField.bottomAnchor), priceLabel.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), priceLabel.centerXAnchor.constraint(equalTo: centerXAnchor), priceLabel.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainPriceTextField() {
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        
        [priceTextField.topAnchor.constraint(equalTo: priceLabel.bottomAnchor), priceTextField.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), priceTextField.centerXAnchor.constraint(equalTo: centerXAnchor), priceTextField.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [descriptionLabel.topAnchor.constraint(equalTo: priceTextField.bottomAnchor), descriptionLabel.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor), descriptionLabel.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainDescriptionTextView() {
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        [descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor), descriptionTextView.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), descriptionTextView.centerXAnchor.constraint(equalTo: centerXAnchor), descriptionTextView.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor, multiplier: 4.5)].forEach({$0.isActive = true})
    }
    
    private func constrainCoverPhotosButton() {
        manageCoverPhotosButton.translatesAutoresizingMaskIntoConstraints = false
        
        [manageCoverPhotosButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: svContentSize * 0.01), manageCoverPhotosButton.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), manageCoverPhotosButton.centerXAnchor.constraint(equalTo: centerXAnchor), manageCoverPhotosButton.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainTourPhotosButton() {
        manageTourPhotosButton.translatesAutoresizingMaskIntoConstraints = false
        
        [manageTourPhotosButton.topAnchor.constraint(equalTo: manageCoverPhotosButton.bottomAnchor, constant: svContentSize * 0.01), manageTourPhotosButton.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), manageTourPhotosButton.centerXAnchor.constraint(equalTo: centerXAnchor), manageTourPhotosButton.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainCreateTourButton() {
        createTourButton.translatesAutoresizingMaskIntoConstraints = false
        
        [createTourButton.topAnchor.constraint(equalTo: manageTourPhotosButton.bottomAnchor, constant: svContentSize * 0.05), createTourButton.widthAnchor.constraint(equalTo: streetAddressLabel.widthAnchor), createTourButton.centerXAnchor.constraint(equalTo: centerXAnchor), createTourButton.heightAnchor.constraint(equalTo: streetAddressLabel.heightAnchor, multiplier: 1.25)].forEach({$0.isActive = true})
    }
    
}
