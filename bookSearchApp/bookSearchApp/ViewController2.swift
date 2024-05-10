//
//  File.swift
//  bookSearchApp
//
//  Created by t2023-m0049 on 5/10/24.
//

import Foundation
import SnapKit
import UIKit

class ViewController2: UIViewController {
    
    
    let deleteAllButton = UIButton()
    let addButton = UIButton()
    let savedBooksTableView = UITableView()
    
      
    
    var savedList: [savedModel] = [
        .init(bookTitle: "토지", author: "박경리", price: "12,000"),
        .init(bookTitle: "해리포터", author: "조앤롤링", price: "12,000"),
        .init(bookTitle: "토지", author: "박경리", price: "12,000"),
        .init(bookTitle: "해리포터", author: "조앤롤링", price: "12,000"),
        .init(bookTitle: "토지", author: "박경리", price: "12,000"),
        .init(bookTitle: "해리포터", author: "조앤롤링", price: "12,000"),
        .init(bookTitle: "토지", author: "박경리", price: "12,000"),
        .init(bookTitle: "해리포터", author: "조앤롤링", price: "12,000"),
        .init(bookTitle: "토지", author: "박경리", price: "12,000"),
        .init(bookTitle: "해리포터", author: "조앤롤링", price: "12,000"),
        .init(bookTitle: "토지", author: "박경리", price: "12,000"),
        .init(bookTitle: "해리포터", author: "조앤롤링", price: "12,000"),
        .init(bookTitle: "토지", author: "박경리", price: "12,000"),
        .init(bookTitle: "해리포터", author: "조앤롤링", price: "12,000"),
        .init(bookTitle: "토지", author: "박경리", price: "12,000"),
        .init(bookTitle: "해리포터", author: "조앤롤링", price: "12,000"),
        .init(bookTitle: "토지", author: "박경리", price: "12,000"),
        .init(bookTitle: "해리포터", author: "조앤롤링", price: "12,000"),
        .init(bookTitle: "토지", author: "박경리", price: "12,000"),
        .init(bookTitle: "해리포터", author: "조앤롤링", price: "12,000"),
        .init(bookTitle: "토지", author: "박경리", price: "12,000"),
        .init(bookTitle: "해리포터", author: "조앤롤링", price: "12,000")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .red
        
        deleteAllButton.setTitle("Delete All", for: .normal)
        deleteAllButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        deleteAllButton.setTitleColor(.black, for: .normal)
        deleteAllButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteAllButton.tintColor = .black
        deleteAllButton.layer.cornerRadius = 5

        addButton.setTitle("Add new books", for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        addButton.setTitleColor(.black, for: .normal)
        addButton.setImage(UIImage(systemName: "plus.app"), for: .normal)
        addButton.tintColor = .black
        addButton.layer.cornerRadius = 5
        
        [deleteAllButton, addButton, savedBooksTableView].forEach {
            view.addSubview($0)
        }
        
        
        
        configureUI()
        setConstraints()
        
    }
    
    
    private func setConstraints() {
        
        
        
        deleteAllButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(40)
            $0.width.equalTo(100)
        
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(40)
            $0.width.equalTo(150)
            //                    $0.trailing.equalTo(view.safeAreaLayoutGuide)
            //                    $0.bottom.equalTo(searchResultCollectionView.snp.top).offset(-10)
            //                    $0.height.equalTo(searchResultCollectionView.snp.height).dividedBy(3)
        }
        
        savedBooksTableView.snp.makeConstraints {
            $0.top.equalTo(addButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        
        
    }
    
    func configureUI() {
        //savedBooksTableView의 delegate, datasource
        savedBooksTableView.register(SavedBooksTableViewCell.self, forCellReuseIdentifier: SavedBooksTableViewCell.identifier)
        
        savedBooksTableView.dataSource = self
        savedBooksTableView.delegate = self
        
        
        
        savedBooksTableView.backgroundColor = .white
        
    }
}

extension ViewController2: UITableViewDelegate {
    
}

extension ViewController2: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SavedBooksTableViewCell.identifier, for: indexPath) as? SavedBooksTableViewCell else {return UITableViewCell() }
        
        
        cell.configureUI(saved: savedList[indexPath.row])
        
        return cell
        
    }
    
    
}

