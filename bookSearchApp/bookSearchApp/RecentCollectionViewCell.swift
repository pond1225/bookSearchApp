//
//  recentCollectionViewCell.swift
//  bookSearchApp
//
//  Created by t2023-m0049 on 5/8/24.
//

import UIKit

class RecentCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecentCollectionViewCell"
    
    let recentImage = UIImageView()
    let recentBookTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        [recentImage, recentBookTitleLabel].forEach {
            contentView.addSubview($0)
        }
        
        recentImage.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).inset(8)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        recentBookTitleLabel.snp.makeConstraints {
            $0.top.equalTo(recentImage.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
    
    func configureUI(recent: recentModel) {
        contentView.backgroundColor = .red
        recentImage.image = recent.bookImage
        recentBookTitleLabel.text = recent.bookTitle
        recentBookTitleLabel.backgroundColor = .white
    }
}

