//
//  Book.swift
//  LibraryApp
//
//  Created by Mahdi on 5/14/1403 AP.
//

import Foundation

enum Category: String {
    
    case art                = "Art"
    case biography          = "Biography"
    case children           = "Children"
    case cooking            = "Cooking"
    case drama              = "Drama"
    case fantasy            = "Fantasy"
    case fiction            = "Fiction"
    case health             = "Health"
    case history            = "History"
    case horror             = "Horror"
    case mystery            = "Mystery"
    case nonFiction         = "Non-Fiction"
    case poetry             = "Poetry"
    case religion           = "Religion"
    case romance            = "Romance"
    case science            = "Science"
    case scienceFiction     = "Science Fiction"
    case selfHelp           = "Self-Help"
    case thriller           = "Thriller"
    case travel             = "Travel"
    case none               = "none"
}

protocol BookProtocol {
    
    var title: String { get }
    var author: String { get }
    var category: Category { get }
}

struct Book: BookProtocol {
    
    let title, author: String
    let category: Category
}
