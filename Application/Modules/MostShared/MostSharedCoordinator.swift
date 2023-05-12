//
//  MostSharedCoordinator.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 10.05.2023.
//

import UIKit

final class MostSharedCoordinator: Coordinator {
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
        let mostSharedVC = Factory.articleFactory.makeArticlesVC(delegate: self, flow: .mostShared)
        presenter.pushViewController(mostSharedVC, animated: animated)
    }
    
    func stop(animated: Bool = true) {
        presenter.popViewController(animated: animated)
    }
}

// MARK: - ArticlesVMDelegate
extension MostSharedCoordinator: ArticlesVMDelegate {
    func openArticlesDetails(for article: Article) {
        let articleDetailVC = Factory.articleFactory.makeArticleDetailVC(delegate: self, article: article)
        presenter.pushViewController(articleDetailVC, animated: true)
    }
}
