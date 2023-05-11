//
//  Article+Response.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 11.05.2023.
//

import Foundation

extension Article {
    struct Response: Decodable {
        let url: String
        let id: Int64
        let source: String
        let byline: String
        let title: String
        let description: String
        let publishedDate: DayMonthYearCoder
        
        private enum CodingKeys : String, CodingKey {
            case url, id, source, byline, title
            case description = "abstract"
            case publishedDate = "published_date"
        }
    }
}
