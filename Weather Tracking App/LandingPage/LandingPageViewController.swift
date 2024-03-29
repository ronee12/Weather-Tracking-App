//
//  ViewController.swift
//  Weather Tracking App
//
//  Created by Md Mehedi Hasan on 1/3/24.
//

import UIKit
import CoreLocation
import ReactiveSwift
import Reachability

class LandingPageViewController: UIViewController {
    
    lazy var searchContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var searchCancelButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var addressSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for area, street name..."
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    
    lazy var searchTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(AddressSearchCell.self, forCellReuseIdentifier: AddressSearchCell.id)
        tableView.tableHeaderView?.removeFromSuperview()
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var weatherInfoView: WeatherInfoView = {
        let view = WeatherInfoView(frame: .zero)
        return view
    }()
    
    private lazy var bottomTabView: BottomTabView = {
        let view = BottomTabView(frame: .zero)
        view.delegate = self
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexColor: "34b1eb")
        return view
    }()
    
    private var statusBarHeight: CGFloat {
        UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0.0
    }
    
    var locationManager = CLLocationManager()
    var viewModel: LandingPageViewModel!
    var reachability : Bool {
        let reachability = try! Reachability()
        return reachability.connection != .unavailable
    }
    var lastLat: Double?
    var lastLong: Double?
    var currentLat: Double = 0.0
    var currentLong: Double = 0.0
    var tabViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        searchTableView.isHidden = true
        let weatherService = WeatherServiceManager()
        viewModel = LandingPageViewModel(weatherService: weatherService)
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
        addGradientBG()
        setupLocationManager()
        setupViews()
        setupObservers()
    }
    
    private func setupViews() {
        self.view.addSubview(containerView)
        containerView.addSubview(weatherInfoView)
        containerView.addSubview(bottomTabView)
        containerView.addSubview(searchContainer)
        containerView.addSubview(searchTableView)
        
        searchContainer.addSubview(addressSearchBar)
        searchContainer.addSubview(searchCancelButton)
        
        containerView.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor)
        searchContainer.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, height: 116)
        addressSearchBar.anchor(left: searchContainer.leftAnchor, bottom: searchContainer.bottomAnchor, paddingBottom: 0, height: 60)
        searchCancelButton.centerY(view: addressSearchBar)
        searchCancelButton.anchor(left: addressSearchBar.rightAnchor, right: containerView.rightAnchor, paddingLeft: 20, paddingRight: 10, height: 16)
        searchTableView.anchor(top: searchContainer.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 500)
        weatherInfoView.anchor(top: searchContainer.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10, height: 150)
        bottomTabView.centerX(view: containerView)
        
        bottomTabView.anchor(height: 50, width: 150)
        tabViewBottomConstraint = bottomTabView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -200)
        tabViewBottomConstraint?.isActive = true
    }
    
    private func setupObservers() {
        //For search auto completion
        viewModel.cityModel.signal.observeValues { _ in
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
            }
        }
        
        //To update weather info
        viewModel.weatherInfo.signal.observeValues { [weak self] weatherInfo in
            
            guard let weatherInfo = weatherInfo else {
                return
            }
            self?.lastLat = weatherInfo.lat
            self?.lastLong = weatherInfo.long
            
            DispatchQueue.main.async {
                self?.searchTableView.isHidden = true
                self?.addressSearchBar.resignFirstResponder()
                self?.weatherInfoView.setupData(model: weatherInfo)
            }
        }
        
        
    }
    
    private func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    @objc func searchBarCancelClicked() {
        view.endEditing(true)
        addressSearchBar.text = nil
        searchContainer.isHidden = true
        searchTableView.isHidden = true
        print("search cancel Button clicked")
    }
    
    @objc func cancelButtonTapped() {
        addressSearchBar.resignFirstResponder()
        addressSearchBar.text = ""
    }
    
    @objc func orientationDidChange() {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            tabViewBottomConstraint?.constant = -50
        } else {
            tabViewBottomConstraint?.constant = -200
        }
    }
    
    private func addGradientBG() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor(hexColor: "34b1eb").cgColor,
            UIColor.white.cgColor
        ]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        containerView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func showNoInternetToast() {
        WTToast.show(message: "No Internet Connection", in: self)
    }
    
}

extension LandingPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = searchTableView.dequeueReusableCell(withIdentifier: AddressSearchCell.id, for: indexPath) as? AddressSearchCell else {
            return UITableViewCell()
        }
        
        guard let model = viewModel.getSearchModel(indexPath: indexPath) else {
            return UITableViewCell()
        }
        
        cell.setupData(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
}

extension LandingPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = viewModel.getSearchModel(indexPath: indexPath) else {
            return
        }
        
        let lat = model.lat
        let lon = model.lon
        if reachability {
            viewModel.getWeatherByLatLon(lat: lat, lon: lon)
        } else {
            showNoInternetToast()
        }
    }
}

extension LandingPageViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        
        if lastLat == nil && lastLong == nil {
            lastLat = location.coordinate.latitude
            lastLong = location.coordinate.longitude
            if reachability {
                viewModel.getWeatherByLatLon(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            } else {
                showNoInternetToast()
            }
        }
        
        currentLat = location.coordinate.latitude
        currentLong = location.coordinate.longitude
        
        print("location \(location)")
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        @unknown default:
            break
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
}


extension LandingPageViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchTableView.isHidden = true
        weatherInfoView.isHidden = false
        bottomTabView.isHidden = false
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isNotEmpty {
            searchTableView.isHidden = false
            weatherInfoView.isHidden = true
            bottomTabView.isHidden = true
        }
        
        if searchText.isEmpty {
            searchTableView.isHidden = true
            weatherInfoView.isHidden = false
            bottomTabView.isHidden = false
        }
        
        if reachability {
            viewModel.getCities(text: searchText)
        } else {
            showNoInternetToast()
        }

    }
    
}

extension LandingPageViewController: BottomTapViewDelegate {
    func didTapRefreshButton() {
        
        guard let lastLat = lastLat, let lastLong = lastLong else {
            WTToast.show(message: "No weather info tracked yet", in: self)
            return
        }
        
        if reachability {
            viewModel.getWeatherByLatLon(lat: lastLat, lon: lastLong)
        } else {
            showNoInternetToast()
        }
    }
    
    func didTapCurrentLocation() {
        
        if reachability {
            viewModel.getWeatherByLatLon(lat: currentLat, lon: currentLong)
        } else {
            showNoInternetToast()
        }
    }
}
