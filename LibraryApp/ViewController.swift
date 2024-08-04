//
//  ViewController.swift
//  LibraryApp
//
//  Created by Mahdi on 5/14/1403 AP.
//

import UIKit

class ViewController: UIViewController {
    
    private var bookList: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func addBook(title: String!, author: String!, category: Category!) {
        
        guard !bookList.contains(where: { $0.title == title &&
                                          $0.author == author &&
                                          $0.category == category } )
        else {
            return
        }
        bookList.append( Book(title: title, author: author, category: category) )
    }
    
    private func removeBook(title: String!, category: Category!, author: String!) {
        
        if let bookIndex = bookList.firstIndex(where: { $0.title == title &&
                                                        $0.author == author &&
                                                        $0.category == category } )
        {
            bookList.remove(at: bookIndex)
        } else {
            return
        }
    }
    
    private func searchBook(title: String? = nil, category: Category? = nil, author: String? = nil) -> [Book] {
        
        return bookList.filter { book in
            let matchedTitle = title?.isEmpty == true || book.title.lowercased().contains(title!.lowercased())
            let matchedCategory = category == nil || book.category == category
            let matchedAuthor = author?.isEmpty == true || book.author.lowercased().contains(author!.lowercased())
            
            return matchedTitle && matchedCategory && matchedAuthor
        }
    }
    
}

