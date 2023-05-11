//
//  BaseVC.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 11.05.2023.
//

import UIKit

class BaseVC: UIViewController {
    private var activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }
    
    func startShowingActivity() {
        view.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
    }
 
    func stopShowingActivity() {
        view.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
    }
}
