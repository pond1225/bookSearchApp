//
//  searchedCollectionviewCell.swift
//  bookSearchApp
//
//  Created by t2023-m0049 on 5/9/24.
//

import UIKit

class SearchedCollectionviewCell: UICollectionViewCell {
    static let identifier = "SearchedCollectionviewCell"
    
    let searchedImage = UIImageView()
    let searchedBookTitleLabel = UILabel()
    let author = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        [searchedImage, searchedBookTitleLabel, author].forEach {
            contentView.addSubview($0)
        }
        
        searchedImage.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).inset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        searchedBookTitleLabel.snp.makeConstraints {
            $0.top.equalTo(searchedImage.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        author.snp.makeConstraints {
            $0.top.equalTo(searchedBookTitleLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(32)
        }
    }
    
    func configureUI(searched: searchBook) {
        contentView.backgroundColor = .blue
//        searchedImage.image = searched.thumbnail
        searchedBookTitleLabel.text = searched.title
        author.text = searched.authors.first
        searchedBookTitleLabel.backgroundColor = .red
        author.backgroundColor = .yellow
    }
}


