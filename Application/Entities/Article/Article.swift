//
//  Article.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 11.05.2023.
//

import Foundation

class Article: Identifiable {
    let url: String?
    let id: Int64
    let source: String?
    let byline: String?
    let title: String?
    let description: String?
    let publishedDate: Date?
    var html: String? = nil
    
    var isSaved: Bool {
        html != nil
    }
    
    init(from response: Response) {
        self.url = response.url
        self.id = response.id
        self.source = response.source
        self.byline = response.byline
        self.title = response.title
        self.description = response.description
        self.publishedDate = response.publishedDate.value
    }
    
    init(from entity: ArticleEntity) {
        self.url = entity.url
        self.id = entity.id
        self.source = entity.source
        self.byline = entity.byline
        self.title = entity.title
        self.description = entity.articleDescription
        self.publishedDate = entity.publishedDate
        self.html = entity.html
    }
}
