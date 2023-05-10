//
//  File.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 09.05.2023.
//

import Foundation

internal protocol HasArticlesUseCase {
    var articles: ArticlesUseCase { get }
}

typealias UseCases = HasArticlesUseCase
protocol UseCasesProvider: UseCases {}
