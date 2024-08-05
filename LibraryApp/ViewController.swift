//
//  ViewController.swift
//  LibraryApp
//
//  Created by Mahdi on 5/14/1403 AP.
//  NOTE: I used AI to write my commits in correct form of English sentences:
//        Sometimes I mentioned my changes and wanted it to rewrite it
//        Sometimes I gave it my new bunch of codes and wanted to write its commit
//        In each case I read and edit its ouput if needed


import UIKit

// MARK: - View Controller
class ViewController: UIViewController {
    
    
    // MARK: Class Properties
    private var bookList: [Book] = []
    private var filterredBookList: [Book] = []
    private var selectedCell: IndexPath?
    
    // MARK: Page Load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: IBOutlets
    
    // I Learnt how to add and connect these IBOutlets to UI from sean's Youtube chanel
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bookTitle: UITextField!
    @IBOutlet weak var bookAuthor: UITextField!
    @IBOutlet weak var bookCategory: UITextField!
    @IBOutlet weak var bookDelete: UIButton!
    @IBOutlet weak var categoryTextField: UITextField!
    
    // MARK: IBActions
    
    // I Learnt how to add and connect these IBActions to UI from sean's Youtube chanel
    // whole idea and implementation is for me
    @IBAction func addBook(_ sender: UIButton) {
        
        guard self.bookTitle.text != "", self.bookAuthor.text != "", self.bookCategory.text != "" else {
            
            return
        }
        
        self.bookList.append( Book(title: self.bookTitle.text!, author: self.bookAuthor.text!, category: Category(rawValue: self.bookCategory.text!) ?? .none) )
        
        self.bookTitle.text = ""
        self.bookAuthor.text = ""
        self.bookCategory.text = ""
        
        // Learnt that the table content MUST be reloaded after changes form AI
        self.tableView.reloadData()

    }
    
    @IBAction func bookDelete(_ sender: Any) {
        
        // Asked AI to know about how can I have access to data of the tapped cell by its index
        // Asked How can i connect my own deletation function to this button and do not use table remove function
        // So copied and changed the folowing code (used my own deletaion function)
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
    
    // MARK: Class Methods
    
    // Got the syntax of .contains() and the the closure in it form AI
    // Then Changed unwrapping logic based on my logic
    // The idea of checking existence of book in list was form me
    // Then read more about closures form `www.programiz.com` and sean's Youtube videos
    private func addBook(title: String!, author: String!, category: Category!) {
        
        guard !self.bookList.contains(where: { $0.title == title &&
                                          $0.author == author &&
                                          $0.category == category } )
        else {
            return
        }
        self.bookList.append( Book(title: title, author: author, category: category) )
    }
    
    // Got the syntax of .firstIndex(), its functionality and the the closure in it form AI
    // Then Changed unwrapping logic based on my logic
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
    
    // Got the folowing function logic and code from AI
    // And chnaged the unwrapping logic and also default values based on my logic
    private func searchBook(title: String? = "", category: Category? = nil, author: String? = "") -> [Book] {
        
        return self.bookList.filter { book in
            let matchedTitle = title == "" || book.title.lowercased().contains(title!.lowercased())
            let matchedCategory = category == nil || book.category == category
            let matchedAuthor = author == "" || book.author.lowercased().contains(author!.lowercased())
            
            return matchedTitle && matchedCategory && matchedAuthor
        }
    }
    
}

// MARK: - View Controller Extension
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Learnt adding this extension and its functions form YouTube (sean allen's courses)
    // Actually I used Xcode options to write functions signature
    // learnt what is the functionality of each of them
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
        
        // Folowing lines to line 150 were been written by assistance from ChatGPT:
        // Copied line 130 command to prevent overlay cell lables, from AI
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        // Got the idea of generating UILabel and setting const text, from AI
        // Then changed cell variable name and UILabels names based on my own code
        let bookTitle = UILabel()
        // Set UILabel text to be variable (be written from a list)
        bookTitle.text = self.filterredBookList[indexPath.row].title
        bookTitle.font = UIFont.systemFont(ofSize: 30)
        // Tried to not writing the next line and saw the result of doing that
        // Asked AI to explain its usage completely
        bookTitle.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(bookTitle)
        
        let bookAuthor = UILabel()
        bookAuthor.text = self.filterredBookList[indexPath.row].author
        bookAuthor.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(bookAuthor)
        
        // AI gave me some other constrains such as setting labels in center Horizontally
        // I read them to know how do they work and how they should been written
        // Then I changed them based on my needs (removed previous constraints and added another ones)
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
        // Searched on web how to set a button to be unclickable
        self.bookDelete.isEnabled = true
    }
}
