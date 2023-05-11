//
//  ArticlesService.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 09.05.2023.
//

import ReactiveSwift
import Alamofire

final class ArticlesService: ArticlesUseCase {

    private enum C {
        static var token = "ZKKdFq0OwHtX7gtGRDagcq3yUcJRo5lw"
        static let parameters = ["api-key": "ZKKdFq0OwHtX7gtGRDagcq3yUcJRo5lw"]
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
}
