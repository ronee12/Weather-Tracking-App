//
//  ViewController.swift
//  Weather Tracking App
//
//  Created by Daraz on 1/3/24.
//

import UIKit

class LandingPageViewController: UIViewController {

    private lazy var headerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var cityZipSelectSwitch: UISwitch = {
        let switchView = UISwitch()
        return switchView
    }()
    
    private lazy var weatherInfoView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var bottomTabView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

