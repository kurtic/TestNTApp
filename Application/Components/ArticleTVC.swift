//
//  ArticleTVC.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 11.05.2023.
//

import UIKit

protocol ArticleTVCDelegate: AnyObject {
    //TODO
}

final class ArticleTVC: UITableViewCell {
    
    // MARK: - Private Properties
    private weak var delegate: ArticleTVCDelegate?
    
    // MARK: - Configure
    func configure(delegate: ArticleTVCDelegate) {
        // TODO
    }
}
