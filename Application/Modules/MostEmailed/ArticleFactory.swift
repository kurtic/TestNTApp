//
//  ArticleFactory.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 10.05.2023.
//

import Foundation

final class ArticleFactory: BaseFactory {
    
    static var main = ArticleFactory()
    private override init() {}
    
    func makeArticlesVC<T: Coordinator & ArticlesVMDelegate>(delegate: T, flow: ArticlesVM.Flow) -> ArticlesVC {
        makeController(delegate) {
            $0.viewModel = ArticlesVM(useCases: delegate.useCases,
                                      delegate: delegate,
                                      flow: flow)
        }
    }
     
    func makeArticleDetailVC<T: Coordinator>(delegate: T, article: Article) -> DetailArticleVC {
        makeController(delegate) {
            $0.viewModel = DetailArticleVM(useCases: delegate.useCases, article: article)
        }
    }
}
