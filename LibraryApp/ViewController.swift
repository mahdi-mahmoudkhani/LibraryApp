//
//  ViewController.swift
//  LibraryApp
//
//  Created by Mahdi on 5/14/1403 AP.
//

import UIKit

class ViewController: UIViewController {
    
    private var bookList: [Book] = []
    private var filterredBookList: [Book] = []
    private var selectedCell: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bookTitle: UITextField!
    @IBOutlet weak var bookAuthor: UITextField!
    @IBOutlet weak var bookCategory: UITextField!
    @IBOutlet weak var bookDelete: UIButton!
    @IBOutlet weak var categoryTextField: UITextField!
    
    @IBAction func addBook(_ sender: UIButton) {
        
        guard bookTitle.text != "", bookAuthor.text != "", bookCategory.text != "" else {
            
            return
        }
        
        bookList.append( Book(title: bookTitle.text!, author: bookAuthor.text!, category: Category(rawValue: bookCategory.text!) ?? .none) )
        
        bookTitle.text = ""
        bookAuthor.text = ""
        bookCategory.text = ""
        
        tableView.reloadData()

    }
    
    @IBAction func bookDelete(_ sender: Any) {
        
        guard let selectedBook = selectedCell else { return }
        let book = bookList[selectedBook.row]
        removeBook(title: book.title, category: book.category, author: book.author)
        bookDelete.isEnabled = false
        tableView.reloadData()
    }
    
    @IBAction func filterBooks(_ sender: Any) {
        
        guard categoryTextField.text != "" else {
            filterredBookList = bookList
            tableView.reloadData()
            
            return
        }
        filterredBookList = searchBook( category: Category(rawValue: categoryTextField.text! ) )
        tableView.reloadData()
        categoryTextField.text = ""
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
    
    private func searchBook(title: String? = "", category: Category? = nil, author: String? = "") -> [Book] {
        
        return bookList.filter { book in
            let matchedTitle = title == "" || book.title.lowercased().contains(title!.lowercased())
            let matchedCategory = category == nil || book.category == category
            let matchedAuthor = author == "" || book.author.lowercased().contains(author!.lowercased())
            
            return matchedTitle && matchedCategory && matchedAuthor
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if categoryTextField.text == "" {
            filterredBookList = bookList
        }
        return filterredBookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell") else {
            
            return UITableViewCell()
        }
        
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let bookTitle = UILabel()
        bookTitle.text = filterredBookList[indexPath.row].title
        bookTitle.font = UIFont.systemFont(ofSize: 30)
        bookTitle.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(bookTitle)
        
        let bookAuthor = UILabel()
        bookAuthor.text = filterredBookList[indexPath.row].author
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedCell = indexPath
        bookDelete.isEnabled = true
    }
}
