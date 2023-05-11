//
//  DetailArticleVM.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 11.05.2023.
//

import ReactiveSwift

protocol DetailArticleVMDelegate: AnyObject {
    // TODO
}

final class DetailArticleVM: UseCasesConsumer {
    typealias UseCases = HasArticlesUseCase
    
    // MARK: - Private Properties
    private weak var delegate: DetailArticleVMDelegate?
    
    private(set) lazy var saveArticleAction = Action(execute: useCases.articles.saveArticle)
    
    // MARK: - Public Properties
    let article = MutableProperty<Article?>(nil)
    
    // MARK: - Life Cycle
    init(delegate: DetailArticleVMDelegate,
         useCases: UseCases,
         article: Article) {
        self.useCases = useCases
        self.delegate = delegate
        self.article.value = article
    }
}
