//
//  ArticlesVM.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 11.05.2023.
//

import ReactiveSwift

protocol ArticlesVMDelegate: AnyObject {
    func openArticlesDetails(for article: Article)
}

final class ArticlesVM: UseCasesConsumer {
    typealias UseCases = HasArticlesUseCase
    
    // MARK: - Public Properties
    let articles = MutableProperty<[Article]>([])
    var flow: Flow = .mostEmailed
    
    // MARK: - Private Properties
    private weak var delegate: ArticlesVMDelegate?
    
    // MARK: - Actions
    private(set) lazy var getArticles = Action(execute: useCases.articles.getArticles)
    
    // MARK: - Life Cycle
    init(useCases: UseCases, delegate: ArticlesVMDelegate, flow: Flow) {
        self.useCases = useCases
        self.delegate = delegate
        self.flow = flow
        articles <~ getArticles.values
    }
    
    func openArticleDetails(for article: Article) {
        delegate?.openArticlesDetails(for: article)
    }
}

extension ArticlesVM {
    enum Flow {
        case mostEmailed
        case mostShared
        case mostViewed
        case favourite
        
        var title: String {
            switch self {
            case .mostEmailed:
                return "Most Emailed"
            case .mostShared:
                return "Most Shared"
            case .mostViewed:
                return "Most Viewed"
            case .favourite:
                return "Favourite"
            }
        }
    }
}
