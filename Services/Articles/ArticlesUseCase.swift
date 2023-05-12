//
//  ArticlesUseCase.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 09.05.2023.
//

import ReactiveSwift

protocol ArticlesUseCase {
    func getArticles(flow: ArticlesVM.Flow) -> SignalProducer<[Article], Error>
    func saveArticle(article: Article) -> SignalProducer<Article, Error>
    func getSavedArticles() -> SignalProducer<[Article], Error>
    func isAlreadySaved(articleId: Int64) -> SignalProducer<Bool, Error>
    func deleteArticle(articleId: Int64) -> SignalProducer<Void, Error>
}
