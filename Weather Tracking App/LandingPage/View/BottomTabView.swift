//
//  BottomTabView.swift
//  Weather Tracking App
//
//  Created by Mehedi Hasan on 3/3/24.
//

import UIKit

protocol BottomTapViewDelegate: AnyObject {
    func didTapRefreshButton()
    func didTapCurrentLocation()
}

class BottomTabView: UIView {

    private lazy var refreshView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "refresh")
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(refreshButtonTapped)))
        return imageView
    }()
    
    private lazy var currentPosition: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gps")
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(currentPositionButtonTapped)))
        return imageView
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexColor: "34b1eb")
        return view
    }()
    
    weak var delegate: BottomTapViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        setupViews()
    }
    
    func setupAppearance() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 25
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 0.5
    }
    
    private func setupViews() {
        self.addSubview(refreshView)
        self.addSubview(dividerView)
        self.addSubview(currentPosition)
        
        refreshView.anchor(left: self.leftAnchor, paddingLeft: 10, height: 30, width: 30)
        refreshView.centerY(view: self)
        
        dividerView.centerX(view: self)
        dividerView.centerY(view: self)
        dividerView.anchor(height: 30, width: 2)
        
        
        currentPosition.anchor(right: self.rightAnchor, paddingRight: 10, height: 30, width: 30)
        currentPosition.centerY(view: self)
    }
    
    @objc func refreshButtonTapped() {
        delegate?.didTapRefreshButton()
    }
    
    @objc func currentPositionButtonTapped() {
        delegate?.didTapCurrentLocation()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
