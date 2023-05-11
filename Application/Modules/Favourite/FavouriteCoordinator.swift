//
//  FavouriteCoordinator.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 10.05.2023.
//

import UIKit

final class FavouriteCoordinator: Coordinator {
    // MARK: - Public Properties
    var useCases: UseCasesProvider
    
    // MARK: - Private Properties
    private weak var presenter: UINavigationController!
    
    // MARK: - Life Cycle
    init(navContoller: UINavigationController, useCases: UseCasesProvider) {
        self.useCases = useCases
        self.presenter = navContoller
    }
    
    func start(animated: Bool = true) {
        let favouriteVC = Factory.articleFactory.makeArticlesVC(delegate: self, flow: .favourite)
        presenter.pushViewController(favouriteVC, animated: animated)
    }
    
    func stop(animated: Bool = true) {
        presenter.popViewController(animated: animated)
    }
}

// MARK: - ArticlesVMDelegate
extension FavouriteCoordinator: ArticlesVMDelegate {
    func openArticlesDetails(for article: Article) {
        let articleDetailVC = Factory.articleFactory.makeArticleDetailVC(delegate: self, article: article)
        presenter.pushViewController(articleDetailVC, animated: true)
    }
}

// MARK: - DetailArticleVMDelegate
extension FavouriteCoordinator: DetailArticleVMDelegate {
    // TODO
}
