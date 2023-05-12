//
//  DetailArticleVM.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 11.05.2023.
//

import ReactiveSwift

final class DetailArticleVM: UseCasesConsumer {
    typealias UseCases = HasArticlesUseCase
    
    // MARK: - Actions
    private(set) lazy var saveArticleAction = Action(execute: useCases.articles.saveArticle)
    private(set) lazy var isArticleSavedAction = Action(execute: useCases.articles.isAlreadySaved)
    private(set) lazy var deleteArticleAction = Action(execute: useCases.articles.deleteArticle)
    
    // MARK: - Public Properties
    let article: MutableProperty<Article>
    let isArticleAlreadySaved = MutableProperty<Bool>(false)
    
    // MARK: - Life Cycle
    init(useCases: UseCases,
         article: Article) {
        self.article = MutableProperty(article)
        self.useCases = useCases
        
        isArticleAlreadySaved <~ isArticleSavedAction.values.merge(with: deleteArticleAction.values.map { false })
            .merge(with: saveArticleAction.values.map(value: (true)))
        isArticleSavedAction.apply(article.id).start()
    }
    
    func deleteArticle() {
        deleteArticleAction.apply(article.value.id).start()
    }
}
