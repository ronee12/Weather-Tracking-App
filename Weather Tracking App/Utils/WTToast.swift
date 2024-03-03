//
//  WTToast.swift
//  Weather Tracking App
//
//  Created by Mehedi Hasan on 3/3/24.
//

import UIKit

class WTToast: UIView {

    static func show(message: String, in viewController: UIViewController, duration: TimeInterval = 2.0) {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastLabel.textColor = .white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 14.0)
        toastLabel.numberOfLines = 0
        toastLabel.text = message
        toastLabel.alpha = 0.0
        toastLabel.translatesAutoresizingMaskIntoConstraints = false

        viewController.view.addSubview(toastLabel)
        
        toastLabel.anchor(left: viewController.view.leftAnchor, bottom: viewController.view.bottomAnchor, right: viewController.view.rightAnchor, paddingLeft: 100, paddingBottom: 300, paddingRight: 100, height: 40)


        UIView.animate(withDuration: 0.3, animations: {
            toastLabel.alpha = 1.0
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                UIView.animate(withDuration: 0.3, animations: {
                    toastLabel.alpha = 0.0
                }) { _ in
                    toastLabel.removeFromSuperview()
                }
            }
        }
    }
}
