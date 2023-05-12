//
//  ArticlesService.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 09.05.2023.
//

import ReactiveSwift
import Alamofire
import CoreData

final class ArticlesService: ArticlesUseCase {

    private enum C {
        static var token = "ZKKdFq0OwHtX7gtGRDagcq3yUcJRo5lw"
        static let parameters = ["api-key": token]
        static func urlString(for flow: ArticlesVM.Flow) -> String {
            switch flow {
            case .mostEmailed:
                return "https://api.nytimes.com/svc/mostpopular/v2/emailed/30.json"
            case .mostShared:
                return "https://api.nytimes.com/svc/mostpopular/v2/shared/30.json"
            case .mostViewed:
                return "https://api.nytimes.com/svc/mostpopular/v2/viewed/30.json"
            case .favourite:
                return ""
            }
        }
    }
    
    private lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()

    
    func getArticles(flow: ArticlesVM.Flow) -> SignalProducer<[Article], Error> {
        SignalProducer { (observer, lifetime) in
            let request = AF
                .request(C.urlString(for: flow),
                         method: .get,
                         parameters: C.parameters,
                         encoding: URLEncoding.default,
                         headers: nil)
                .responseDecodable(of: Description.self) { response in
                    switch response.result {
                    case .success(let data):
                        observer.send(value: data.results.map { Article(from: $0)})
                        observer.sendCompleted()
                    case .failure(let error):
                        observer.send(error: error)
                    }
                }
            lifetime.observeEnded {
                request.cancel()
            }
        }
    }
    
    func saveArticle(article: Article) -> SignalProducer<Article, Error> {
        isAlreadySaved(articleId: article.id)
            .flatMap(.latest) { isAlreadySaved in
                SignalProducer { [unowned self] (observer, lifetime) in
                    if !isAlreadySaved {
                        let articleEntity = ArticleEntity(context: self.context)
                        articleEntity.setValues(from: article)
                        do {
                            try context.save()
                            observer.send(value: article)
                            observer.sendCompleted()
                        } catch {
                           observer.send(error: error)
                       }
                    }
                }
            }
    }
    
    func getSavedArticles() -> SignalProducer<[Article], Error> {
        SignalProducer { [unowned self] (observer, lifetime) in
            do {
               let articleEntities = try context.fetch(ArticleEntity.fetchRequest())
                observer.send(value: articleEntities.map { Article(from: $0)})
                observer.sendCompleted()
            } catch {
                observer.send(error: error)
            }
        }
    }
    
    func deleteArticle(articleId: Int64) -> SignalProducer<Void, Error> {
        SignalProducer { [unowned self] (observer, lifetime) in
            let fetchRequest = ArticleEntity.fetchRequest()
            fetchRequest.predicate = ArticleEntity.findByIdPredicate(articleId)
            fetchRequest.fetchLimit = 1
            do {
                if let storedArticle = try context.fetch(fetchRequest).first {
                    context.delete(storedArticle)
                }
                observer.send(value: ())
                observer.sendCompleted()
            } catch {
                observer.send(error: error)
            }
        }
        .observe(on: UIScheduler())
    }
    
    func isAlreadySaved(articleId: Int64) -> SignalProducer<Bool, Error> {
        SignalProducer { [unowned self] (observer, lifetime) in
            let fetchRequest = ArticleEntity.fetchRequest()
            fetchRequest.predicate = ArticleEntity.findByIdPredicate(articleId)
            fetchRequest.fetchLimit = 1
            do {
                let storedArticles = try context.fetch(fetchRequest)
                observer.send(value: !storedArticles.isEmpty)
                observer.sendCompleted()
            } catch {
                observer.send(error: error)
            }
        }
    }
}
