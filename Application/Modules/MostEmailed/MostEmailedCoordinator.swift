//
//  MostEmailedCoordinator.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 10.05.2023.
//

import UIKit

final class MostEmailedCoordinator: Coordinator {
    // MARK: - Public Properties
    var useCases: UseCasesProvider
    
    // MARK: - Private Properties
    private weak var presenter: UINavigationController!
    
    // MARK: - Life Cycle
    init(navContoller: UINavigationController, useCases: UseCasesProvider) {
        self.useCases = useCases
        self.presenter = navContoller
    }
    
    deinit {
       print("deinited")
    }
    
    func start(animated: Bool = true) {
        let articlesVC = Factory.articleFactory.makeArticlesVC(delegate: self, flow: .mostEmailed)
        presenter.pushViewController(articlesVC, animated: animated)
    }
    
    func stop(animated: Bool = true) {
        presenter.popViewController(animated: animated)
    }
}

// MARK: - ArticlesVMDelegate
extension MostEmailedCoordinator: ArticlesVMDelegate {
    func openArticlesDetails(for article: Article) {
        let articleDetailVC = Factory.articleFactory.makeArticleDetailVC(delegate: self, article: article)
        presenter.pushViewController(articleDetailVC, animated: true)
    }
}

// MARK: - DetailArticleVMDelegate
extension MostEmailedCoordinator: DetailArticleVMDelegate {
    // TODO
}
