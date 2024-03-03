//
//  AddressSearchCell.swift
//  Weather Tracking App
//
//  Created by Mehedi Hasan on 3/3/24.
//


import UIKit

class AddressSearchCell: UITableViewCell {

    lazy var addressIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "recentLocationIcon")
        imageView.tintColor = UIColor(hexColor: "292F48")
        return imageView
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(hexColor: "292F48")
        return label
    }()
    
    lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexColor: "E5E5E5")
        return view
    }()
    
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        setupViews()
    }
    
    private func setupViews() {
        self.addSubview(addressIcon)
        self.addSubview(addressLabel)
        self.addSubview(dividerView)
        
        addressIcon.anchor(left: self.leftAnchor, right: addressLabel.leftAnchor, paddingLeft: 20, paddingRight: 15, height: 30, width: 30)
        addressIcon.centerY(view: self)
        addressLabel.anchor(right: self.rightAnchor, paddingRight: 20)
        addressLabel.centerY(view: self)
        dividerView.anchor(left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingLeft: 20, paddingRight: 20, height: 1)
    }
    
    func setupData(model: SearchModel) {
        addressLabel.text = "\(model.name), \(model.country)"
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var id: String {
        return "AddressSearchCell"
    }
}
