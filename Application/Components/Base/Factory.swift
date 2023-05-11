//
//  Factory.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 11.05.2023.
//

import UIKit

struct Factory {
    static let articleFactory = ArticleFactory.main
}

private enum UIViewControllerKeys {
    static var coordinator = "coordinator"
}

extension UIViewController {
    static var describing: String {
        return String(describing: self.self)
    }
    
    func setCoordinator(_ coordinator: Coordinator) {
        setAssociatedObject(value: coordinator,
                            key: UIViewControllerKeys.coordinator,
                            policy: .retainNonatomic)
    }
}
