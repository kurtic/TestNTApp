//
//  Platform.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 09.05.2023.
//

import Foundation

final class Platform: UseCasesProvider {
    var articles: ArticlesUseCase
    
    init() {
        articles = ArticlesService()
    }
}
