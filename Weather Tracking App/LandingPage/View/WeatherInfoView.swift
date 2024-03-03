//
//  WeatherInfoView.swift
//  Weather Tracking App
//
//  Created by Mehedi Hasan on 3/3/24.
//

import UIKit

class WeatherInfoView: UIView {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexColor:"e6e5eb")
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var weatherCondition: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 48, weight: .semibold)
        return label
    }()
    
    private lazy var weatherTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexColor:"9e9da3")
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var locationAddress: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexColor:"9e9da3")
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var dateTime: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(hexColor:"9e9da3")
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupViews()
    }
    
    private func setupViews() {
        self.addSubview(containerView)
        containerView.addSubview(weatherIcon)
        containerView.addSubview(locationAddress)
        containerView.addSubview(dateTime)
        containerView.addSubview(weatherCondition)
        containerView.addSubview(weatherTitle)
        
        containerView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
        weatherIcon.anchor(left: containerView.leftAnchor, paddingLeft: 10, height: 100, width: 100)
        weatherIcon.centerY(view: containerView)
        
        locationAddress.anchor(bottom: containerView.bottomAnchor, paddingBottom: 10)
        locationAddress.centerX(view: weatherIcon)
        
        weatherCondition.centerY(view: weatherIcon)
        weatherCondition.anchor(right: containerView.rightAnchor, paddingRight: 10)
        weatherTitle.anchor(bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingBottom: 10, paddingRight: 10)
        weatherTitle.leftAnchor.constraint(greaterThanOrEqualTo: locationAddress.rightAnchor, constant: 20).isActive = true
        
        dateTime.anchor(top: containerView.topAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingRight: 10)
        
    }
    
    //TODO:- Set actual data
    func setupData(model: WeatherModel) {
        weatherCondition.text = model.temperatureString
        weatherTitle.text = model.condition
        dateTime.text = model.dateTime
        locationAddress.text = model.cityName
        let url = "https:\(model.iconUrl)"
        ImageDownloader.shared.downloadImage(from: url, completion: { image, error in
            if let error = error {
                return
            }
            DispatchQueue.main.async {
                self.weatherIcon.image = image
            }
        })
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
