//
//  ArticlesUseCase.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 09.05.2023.
//

import ReactiveSwift

protocol ArticlesUseCase {
    func getArticles(flow: ArticlesVM.Flow) -> SignalProducer<[Article], Error>
}
