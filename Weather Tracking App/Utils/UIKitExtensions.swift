//
//  UIKitExtensions.swift
//  Weather Tracking App
//
//  Created by Md Mehedi Hasan on 1/3/24.
//

import Foundation
import UIKit

extension UIView {
    
    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        paddingTop: CGFloat = 0,
        paddingLeft: CGFloat = 0,
        paddingBottom: CGFloat = 0,
        paddingRight: CGFloat = 0,
        height: CGFloat? = nil,
        width: CGFloat? = nil
    ) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
    
    func centerX(view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func centerY(view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension UIColor{
    static func rgb (r: CGFloat, g:CGFloat, b:CGFloat ) -> UIColor{
        return UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static let PMbackgroundColor = UIColor.rgb(r: 245, g: 245, b: 245)
    static let changePaymentMethodBGColor = UIColor.rgb(r: 255, g: 255, b: 255)
    convenience init(hexColor: String) {
        var red: UInt32 = 0, green: UInt32 = 0, blue: UInt32 = 0
        
        let hex = hexColor as NSString
        Scanner(string: hex.substring(with: NSRange(location: 0, length: 2))).scanHexInt32(&red)
        Scanner(string: hex.substring(with: NSRange(location: 2, length: 2))).scanHexInt32(&green)
        Scanner(string: hex.substring(with: NSRange(location: 4, length: 2))).scanHexInt32(&blue)
        
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
    }
    
    static let CartbackgroundColor = UIColor.rgb(r: 250, g: 250, b: 250)
    static let productRed = UIColor.rgb(r: 248, g: 42, b: 38)
    static let PMproductBlack = UIColor.rgb(r: 41, g: 47, b: 72)
    static let CartproductBlack = UIColor.rgb(r: 53, g: 48, b: 57)
    static let productCustomGray = UIColor.rgb(r: 80, g: 67, b: 90)
    static let productGray = UIColor.rgb(r: 90, g: 90, b: 90)
    static let productMidGray = UIColor.rgb(r: 103, g: 95, b: 110)
    static let productLightGray = UIColor.rgb(r: 174, g: 173, b: 178)
    static let productGreen = UIColor.rgb(r: 99, g: 168, b: 93)
    static let promoTextField = UIColor(hexColor: "707C88")
    static let productWhite = UIColor(hexColor: "FAFAFA")
    static let promoTextFieldBorder = UIColor(hexColor: "D1D1D6")
    static let productOrange = UIColor(hexColor: "FC8019")//UIColor(hexColor: "F25F2C")
    static let promoCellDivider = UIColor(hexColor: "F4F4F4")
    static let promoTopDivider = UIColor(hexColor: "D1D1D6")
    static let deliveryContainerBorder = UIColor(hexColor: "F26F31")
    static let productPaymentGray = UIColor.rgb(r: 209, g: 212, b: 216)
    static let dividerBG = UIColor(hexColor: "E5E5E5")
    static let addressPlaceHolder = UIColor(hexColor: "C4C4C4")
    static let outletCartDisable = UIColor(hexColor: "BDBDBD")
    //CART VC
    static let cartVCBG = UIColor(hexColor: "F5F5F5")
    static let cartNavTitle = UIColor(hexColor: "000000")
    static let cartNavSubTitle = UIColor(hexColor: "A0A0A0")
    static let cartReviewPaymentGC1 = UIColor(hexColor: "FC8019")
    static let cartReviewPaymentGC2 = UIColor(hexColor: "FC8019")
    static let cartBlack = UIColor(hexColor: "292F48")
    static let cartGray = UIColor(hexColor: "707C88")
    static let cartBorderGray = UIColor(hexColor: "D1D4D8")
    static let addressDisable = UIColor(hexColor: "B9BFC4")
    static let cartRadioButton = UIColor(hexColor: "E4E8ED")
    
    //New Home
    static let homeBlack = UIColor(hexColor: "000000")
    static let homeFeature = UIColor(hexColor: "79ADA0")
    static let productSignature = UIColor(hexColor: "FC8019")
    static let productSignatureLight = UIColor(hexColor: "FFDEC7")
    static let homeGray = UIColor(hexColor: "6C7174")
    static let outletGray = UIColor(hexColor: "787878")
    static let outletAddButtonBG = UIColor(hexColor: "FFF6EF")
    static let cartCheckLaterButtonBorder = UIColor(hexColor: "767B81")
    static let runningOrderStatusBarOrange = UIColor(hexColor: "F4BC93")
    static let cartViewTopBorder = UIColor(hexColor: "DD6400")
    static let HPclearButton = UIColor(hexColor: "BDBDBD")
    static let dynamicProgressView = UIColor(hexColor: "C0C3C6")
    static let etaBlack = UIColor(hexColor: "1E1E1B")
    static let outletClose = UIColor(hexColor: "FA5757")
    static let pointDeactiveColor = UIColor(hexColor: "DADADA")
    
    static let ratingBlack = UIColor(hexColor: "1E1E1B")
    
    static let shimmerBackground = UIColor(hexColor: "E9E9E9")
    static let shimmerDeepBackground = UIColor(hexColor: "E3E3E3")
    
    //Onboarding
    static let onboardingPageGrayIndicator = UIColor(hexColor: "E1E1E1")
    static let onboardingSkipGray = UIColor(hexColor: "8D8D8D")
    
    static let adsProgressBG = UIColor(hexColor: "767B81")
    
}

extension String {
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
}
