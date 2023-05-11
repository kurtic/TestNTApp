//
//  UITableView+Utils.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 11.05.2023.
//

import UIKit

extension UITableView {
    func registerNibs(for cellClasses: [UITableViewCell.Type]) {
        for cellClass in cellClasses {
            let identifier = String(describing: cellClass)
            register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        }
    }
    
    func registerNib<T>(for cellClass: T.Type) where T: UITableViewCell {
        let identifier = String(describing: cellClass)
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
}

