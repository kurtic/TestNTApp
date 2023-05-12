//
//  ArticleTVC.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 11.05.2023.
//

import UIKit

final class ArticleTVC: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var bylineLabel: UILabel!
    
    // MARK: - Configure
    func configure(article: Article) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        bylineLabel.text = article.byline
    }
}
