//
//  SavedBooksTableViewCell.swift
//  bookSearchApp
//
//  Created by t2023-m0049 on 5/10/24.
//

import UIKit

class SavedBooksTableViewCell: UITableViewCell {
    
    static let identifier = "SavedBooksTableViewCell"
    
    
    let savedBookTitleLabel = UILabel()
    let author = UILabel()
    let price = UILabel()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        [savedBookTitleLabel, author, price].forEach {
            contentView.addSubview($0)
        }
        
        savedBookTitleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).inset(10)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.centerX)
            $0.height.equalTo(50)
        }
        
        author.snp.makeConstraints {
            $0.top.equalTo(savedBookTitleLabel.snp.top)
            $0.leading.equalTo(savedBookTitleLabel.snp.trailing)
            $0.trailing.equalTo(price.snp.leading)
            $0.height.equalTo(50)
        }
        
        price.snp.makeConstraints {
            $0.top.equalTo(savedBookTitleLabel.snp.top)
            $0.leading.equalTo(author.snp.trailing)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(32)
        }
    }
    
    func configureUI(saved: savedModel) {
        contentView.backgroundColor = .cyan
        savedBookTitleLabel.text = saved.bookTitle
        author.text = saved.author
        price.text = saved.price
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}



    
   
  


