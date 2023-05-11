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
    
    // MARK: - IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var bylineLabel: UILabel!
    
    // MARK: - Configure
    func configure(delegate: ArticleTVCDelegate, article: Article) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        bylineLabel.text = article.byline
    }
}
