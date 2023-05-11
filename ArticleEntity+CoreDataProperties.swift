//
//  ArticleEntity+CoreDataProperties.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 11.05.2023.
//
//

import Foundation
import CoreData

@objc(ArticleEntity)
public class ArticleEntity: NSManagedObject {
    func setValues(from article: Article) {
        self.url = article.url
        self.articleDescription = article.description
        self.id = article.id
        self.source = article.source
        self.title = article.title
        self.byline = article.byline
        self.publishedDate = article.publishedDate
        self.html = article.html
    }
}

extension ArticleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleEntity> {
        return NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
    }
    
    @nonobjc public class func findByIdPredicate(_ id: Int64) -> NSPredicate {
        NSPredicate(format: "%K == %@", argumentArray: [#keyPath(ArticleEntity.id), id])
    }

    @NSManaged public var url: String?
    @NSManaged public var id: Int64
    @NSManaged public var source: String?
    @NSManaged public var byline: String?
    @NSManaged public var title: String?
    @NSManaged public var articleDescription: String?
    @NSManaged public var publishedDate: Date?
    @NSManaged public var html: String?
}
