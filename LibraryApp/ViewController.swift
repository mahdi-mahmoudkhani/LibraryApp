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
    
    @IBOutlet weak var tableView: UITableView!
    
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell") else {
            
            return UITableViewCell()
        }
        
        let bookTitle = UILabel()
        bookTitle.text = bookList[indexPath.row].title
        bookTitle.font = UIFont.systemFont(ofSize: 30)
        bookTitle.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(bookTitle)
        
        let bookAuthor = UILabel()
        bookAuthor.text = bookList[indexPath.row].author
        bookAuthor.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(bookAuthor)
        
        NSLayoutConstraint.activate( [

            bookTitle.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 30),
            bookTitle.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 5),
            
            bookAuthor.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -30),
            bookAuthor.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -5),
        ] )
        
        return cell
    }
    
}
