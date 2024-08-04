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
        
        guard self.bookTitle.text != "", self.bookAuthor.text != "", self.bookCategory.text != "" else {
            
            return
        }
        
        self.bookList.append( Book(title: self.bookTitle.text!, author: self.bookAuthor.text!, category: Category(rawValue: self.bookCategory.text!) ?? .none) )
        
        self.bookTitle.text = ""
        self.bookAuthor.text = ""
        self.bookCategory.text = ""
        
        self.tableView.reloadData()

    }
    
    @IBAction func bookDelete(_ sender: Any) {
        
        guard let selectedBook = self.selectedCell else { return }
        let book = self.bookList[selectedBook.row]
        self.removeBook(title: book.title, category: book.category, author: book.author)
        self.bookDelete.isEnabled = false
        self.tableView.reloadData()
    }
    
    @IBAction func filterBooks(_ sender: Any) {
        
        guard self.categoryTextField.text != "" else {
            self.filterredBookList = self.bookList
            self.tableView.reloadData()
            
            return
        }
        self.filterredBookList = self.searchBook( category: Category(rawValue: self.categoryTextField.text! ) )
        self.tableView.reloadData()
        self.categoryTextField.text = ""
    }
    
    private func addBook(title: String!, author: String!, category: Category!) {
        
        guard !self.bookList.contains(where: { $0.title == title &&
                                          $0.author == author &&
                                          $0.category == category } )
        else {
            return
        }
        self.bookList.append( Book(title: title, author: author, category: category) )
    }
    
    private func removeBook(title: String!, category: Category!, author: String!) {
        
        if let bookIndex = self.bookList.firstIndex(where: { $0.title == title &&
                                                        $0.author == author &&
                                                        $0.category == category } )
        {
            self.bookList.remove(at: bookIndex)
        } else {
            return
        }
    }
    
    private func searchBook(title: String? = "", category: Category? = nil, author: String? = "") -> [Book] {
        
        return self.bookList.filter { book in
            let matchedTitle = title == "" || book.title.lowercased().contains(title!.lowercased())
            let matchedCategory = category == nil || book.category == category
            let matchedAuthor = author == "" || book.author.lowercased().contains(author!.lowercased())
            
            return matchedTitle && matchedCategory && matchedAuthor
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.categoryTextField.text == "" {
            self.filterredBookList = self.bookList
        }
        return self.filterredBookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell") else {
            
            return UITableViewCell()
        }
        
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let bookTitle = UILabel()
        bookTitle.text = self.filterredBookList[indexPath.row].title
        bookTitle.font = UIFont.systemFont(ofSize: 30)
        bookTitle.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(bookTitle)
        
        let bookAuthor = UILabel()
        bookAuthor.text = self.filterredBookList[indexPath.row].author
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
        
        self.selectedCell = indexPath
        self.bookDelete.isEnabled = true
    }
}
