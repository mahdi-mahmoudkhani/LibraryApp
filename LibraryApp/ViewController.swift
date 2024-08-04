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
    
}

