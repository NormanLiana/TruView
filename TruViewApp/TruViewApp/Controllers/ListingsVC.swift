//
//  ListingsVC.swift
//  TruViewApp
//
//  Created by Liana Norman on 2/13/20.
//  Copyright © 2020 Liana Norman. All rights reserved.
//

import UIKit
import MapKit

class ListingsVC: UIViewController {

    // MARK: - UI Objects
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.searchBarStyle = .minimal
        return sb
    }()
    
    lazy var mapListViewSegController: UISegmentedControl = {
        let items = ["Map View", "List View"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        sc.selectedSegmentTintColor = #colorLiteral(red: 0.4256733358, green: 0.5473166108, blue: 0.3936028183, alpha: 1)
        sc.addTarget(self, action: #selector(segControlValueChanged(_:)), for: .valueChanged)
        return sc
    }()
    
    lazy var mapView: MKMapView = {
        let mv = MKMapView()
        return mv
    }()
    
    lazy var listingView: ListingCVView = {
        let lv = ListingCVView()
        return lv
    }()
    
    lazy var slideCardView: SlideCardView = {
        let scv = SlideCardView()
        return scv
    }()
    
    // MARK: - Properties
    lazy var slideCardHeight: CGFloat = view.frame.height
    var slideCardState: SlideCardState = .collapsed
    let address = "USA, Brooklyn, 1133 Park Place"
    
    private let locationManager = CLLocationManager()
    private let initialLocation = CLLocation(latitude: 40.742928, longitude: -73.941660)
    private let searchRadius: Double = 1000
    
    private var listings = Listing.allListings
    
    var halfOpenSlideCardViewTopConstraint: NSLayoutConstraint?
    var collapsedSlideCardViewTopConstraint: NSLayoutConstraint?
    var fullScreenSlideCardTopConstraint: NSLayoutConstraint?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        addConstraints()
        setUpInitialVCViews()
        delegation()
        loadGestures()
        locationAuthorization()
        zoomMapOn(location: initialLocation)
        geocodeAddress()
    }
    
    @objc func thumbnailTapped() {
        let panoVC = PanoVC()
        panoVC.modalPresentationStyle = .fullScreen
        
        present(panoVC, animated: true, completion: nil)
    }
    
    // MARK: - Objc Methods
    @objc func respondToSwipeGesture(gesture: UISwipeGestureRecognizer?) {
        if let swipeGesture = gesture {
            switch swipeGesture.direction {
            case .down:
                switch slideCardState {
                case .fullOpen:
                    activateHalfOpenSliderViewConstraints()
                    slideCardState = .halfOpen
                case .halfOpen:
                    activateClosedSliderViewConstraints()
                    slideCardState = .collapsed
                case .collapsed:
                    print("Its closed already")
                }
                
                UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.80, initialSpringVelocity: 0, options: .curveEaseInOut, animations: { [weak self] in
                
                self?.view.layoutIfNeeded()
                
                    if self?.slideCardState == .collapsed {
                    self?.slideCardView.alpha = 0.5
                }
                
                }, completion: nil)
            case .up:
                switch slideCardState {
                case .fullOpen:
                    print("Its already fully open")
                case .halfOpen:
                    activateFullOpenSliderViewConstraints()
                    slideCardState = .fullOpen
                case .collapsed:
                    activateHalfOpenSliderViewConstraints()
                    slideCardState = .halfOpen
                }
                
                UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.80, initialSpringVelocity: 0, options: .curveEaseInOut, animations: { [weak self] in
                
                self?.view.layoutIfNeeded()
                
                self?.slideCardView.alpha = 1.0
                }, completion: nil)
                
            default:
                break
                
            }
        }
    }
    
    @objc func segControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            showMapView()
        case 1:
            showListView()
        default:
            break
        }
    }
    
    // MARK: - Private Methods
    private func setUpInitialVCViews() {
        view.backgroundColor = .systemBackground
        showMapView()
    }
    
    private func addSubViews() {
        view.addSubview(searchBar)
        view.addSubview(mapListViewSegController)
        view.addSubview(mapView)
        view.addSubview(listingView)
        view.addSubview(slideCardView)
    }
    
    private func addConstraints() {
        constrainSearchBar()
        constrainSegmentedController()
        constrainMapView()
        constrainListingView()
        constrainSlideCardView()
    }
    
    private func delegation() {
        listingView.collectionView.delegate = self
        listingView.collectionView.dataSource = self
        locationManager.delegate = self
        mapView.delegate = self
    }
    
    private func loadGestures() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeDown.direction = .down
        self.slideCardView.addGestureRecognizer(swipeDown)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeUp.direction = .up
        self.slideCardView.addGestureRecognizer(swipeUp)
        
        let thumbnailTapGesture = UITapGestureRecognizer(target: self, action: #selector(thumbnailTapped))
        slideCardView.aptThumbnail.isUserInteractionEnabled = true
        slideCardView.aptThumbnail.addGestureRecognizer(thumbnailTapGesture)
    }
    
    private func showMapView() {
        mapView.isHidden = false
        slideCardView.isHidden = false
        listingView.isHidden = true
    }
    
    private func showListView() {
        listingView.isHidden = false
        slideCardView.isHidden = true
        mapView.isHidden = true
    }
    
    private func zoomMapOn(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: searchRadius * 2.0, longitudinalMeters: searchRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func locationAuthorization() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.requestLocation()
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func geocodeAddress() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { [weak self] placemarks, error in
            
            if let placemark = placemarks?.first, let location = placemark.location {
                let mark = MKPlacemark(placemark: placemark)

                if var region = self?.mapView.region {
                    region.center = location.coordinate
                    region.span.longitudeDelta /= 8.0
                    region.span.latitudeDelta /= 8.0
                    self?.mapView.setRegion(region, animated: true)
                    self?.mapView.addAnnotation(mark)
                    print(mark.subLocality ?? "unknown sublocality")
                }
            }
        }
    }
    
    // MARK: - Constraint Methods
    private func constrainSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        [searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor), searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor), searchBar.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.15)].forEach({$0.isActive = true})
    }
    
    private func constrainSegmentedController() {
        mapListViewSegController.translatesAutoresizingMaskIntoConstraints = false
        
        [mapListViewSegController.topAnchor.constraint(equalTo: searchBar.bottomAnchor), mapListViewSegController.leadingAnchor.constraint(equalTo: view.leadingAnchor), mapListViewSegController.trailingAnchor.constraint(equalTo: view.trailingAnchor), mapListViewSegController.heightAnchor.constraint(equalTo: searchBar.heightAnchor, multiplier: 0.4)].forEach({$0.isActive = true})
    }
    
    private func constrainMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        [mapView.topAnchor.constraint(equalTo: mapListViewSegController.bottomAnchor), mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor), mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor), mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainListingView() {
        listingView.translatesAutoresizingMaskIntoConstraints = false
        
        [listingView.topAnchor.constraint(equalTo: mapListViewSegController.bottomAnchor), listingView.leadingAnchor.constraint(equalTo: view.leadingAnchor), listingView.trailingAnchor.constraint(equalTo: view.trailingAnchor), listingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainSlideCardView() {
        slideCardView.translatesAutoresizingMaskIntoConstraints = false
        
        [slideCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor), slideCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor), slideCardView.heightAnchor.constraint(equalToConstant: slideCardHeight)].forEach({$0.isActive = true})
        createSlideCardViewConstraints()
    }
    
    // MARK: - Constraint Methods to change Slide Card View
    private func createSlideCardViewConstraints() {
        halfOpenSlideCardViewTopConstraint = slideCardView.topAnchor.constraint(equalTo: view.bottomAnchor, constant:  -slideCardHeight / 1.9)
        halfOpenSlideCardViewTopConstraint?.isActive = false

        collapsedSlideCardViewTopConstraint = slideCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -slideCardHeight / 30)
        collapsedSlideCardViewTopConstraint?.isActive = true

        fullScreenSlideCardTopConstraint = slideCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        fullScreenSlideCardTopConstraint?.isActive = false
    }
    
    private func activateFullOpenSliderViewConstraints() {
        fullScreenSlideCardTopConstraint?.isActive = true
        halfOpenSlideCardViewTopConstraint?.isActive = false
        collapsedSlideCardViewTopConstraint?.isActive = false
    }
    
    private func activateHalfOpenSliderViewConstraints() {
        fullScreenSlideCardTopConstraint?.isActive = false
        halfOpenSlideCardViewTopConstraint?.isActive = true
        collapsedSlideCardViewTopConstraint?.isActive = false
    }
    
    private func activateClosedSliderViewConstraints() {
        fullScreenSlideCardTopConstraint?.isActive = false
        halfOpenSlideCardViewTopConstraint?.isActive = false
        collapsedSlideCardViewTopConstraint?.isActive = true
    }
}

// MARK: - Extensions
extension ListingsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = listingView.collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.listViewCVCell.rawValue, for: indexPath) as? ListingCVCell {
            cell.aptThumbnail.image = UIImage(systemName: "bed.double")
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}

extension ListingsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 175)
    }
}

extension ListingsVC: UICollectionViewDelegate {}

extension ListingsVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("New locations: \(locations)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("An error occured: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        default:
            break
        }
    }
    
}

extension ListingsVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        annotationView.pinTintColor = #colorLiteral(red: 0.4256733358, green: 0.5473166108, blue: 0.3936028183, alpha: 1)
        return annotationView
    }
    
}
