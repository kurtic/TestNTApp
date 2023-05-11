//
//  Article.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 11.05.2023.
//

import Foundation

struct Article: Identifiable {
    let url: String
    let id: Int64
    let source: String
    let byline: String
    let title: String
    let description: String
    let publishedDate: Date
    
    init(from response: Response) {
        self.url = response.url
        self.id = response.id
        self.source = response.source
        self.byline = response.byline
        self.title = response.title
        self.description = response.description
        self.publishedDate = response.publishedDate.value
    }
}
