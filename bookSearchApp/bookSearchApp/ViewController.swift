//
//  ViewController.swift
//  bookSearchApp
//
//  Created by t2023-m0049 on 5/2/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let searchBar = UISearchBar()
    
    let collectionViewLayout1: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 0
        
        let spacing: CGFloat = 10
        let deviceWidth = UIScreen.main.bounds.width
        let countForLine :  CGFloat = 2
        let inset: CGFloat = 10
        let cellWidth = (deviceWidth - (spacing * countForLine - 1) - inset * 2 - 1) / countForLine
        
        
        layout.itemSize = .init(width: cellWidth, height: cellWidth)
        
        
        return layout
    }()
    
    
    lazy var searchResultCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout1)
    
    var searchedList: [searchBook] = [
        
    ]
    
    let collectionViewLayout2: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        
        let spacing: CGFloat = 10
        let deviceWidth = UIScreen.main.bounds.width
        let countForLine :  CGFloat = 1
        let inset: CGFloat = 10
        let cellWidth = (deviceWidth - (spacing * countForLine - 1) - inset * 2 - 1) / (countForLine + 1)
        
        
        layout.itemSize = .init(width: cellWidth, height: cellWidth)
        
        
        return layout
    }()
    
    
    lazy var recentSeenCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout2)
    
    var recentList: [recentModel] = [
        .init(bookImage: UIImage(systemName: "star")!, bookTitle: ""),
        .init(bookImage: UIImage(systemName: "star")!, bookTitle: ""),
        .init(bookImage: UIImage(systemName: "star")!, bookTitle: ""),
        .init(bookImage: UIImage(systemName: "star")!, bookTitle: ""),
        .init(bookImage: UIImage(systemName: "star")!, bookTitle: ""),
        .init(bookImage: UIImage(systemName: "star")!, bookTitle: ""),
        .init(bookImage: UIImage(systemName: "star")!, bookTitle: ""),
        .init(bookImage: UIImage(systemName: "star")!, bookTitle: "")
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    
        
        view.backgroundColor = .white
       
        [searchBar, recentSeenCollectionView, searchResultCollectionView].forEach {
            view.addSubview($0)
        }
        searchBar.delegate = self
        configureUI()
        setConstraints()
        
    }
    
    
    private func setConstraints() {
        
        
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.trailing.equalToSuperview()
        }
        
        recentSeenCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(searchResultCollectionView.snp.top).offset(-10)
            $0.height.equalTo(searchResultCollectionView.snp.height).dividedBy(3)
        }
        
        searchResultCollectionView.snp.makeConstraints {
            $0.top.equalTo(recentSeenCollectionView.snp.bottom)/*.inset(20)*/
            $0.leading.trailing.equalToSuperview()/*.inset(10)*/
            $0.bottom.equalToSuperview()
        }
        
    }
    
    func configureUI() {
        //searchResultCollectionView의 delegate, datasource
        searchResultCollectionView.register(SearchedCollectionviewCell.self, forCellWithReuseIdentifier: SearchedCollectionviewCell.identifier)
        
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.delegate = self
        
       
        
        searchResultCollectionView.backgroundColor = .white
        
        //recentSeenCollectionView의 delegate, datasource
        
        recentSeenCollectionView.register(RecentCollectionViewCell.self, forCellWithReuseIdentifier: RecentCollectionViewCell.identifier)
        
        recentSeenCollectionView.dataSource = self
        recentSeenCollectionView.delegate = self
        
      
        recentSeenCollectionView.backgroundColor = .white
    }
    
//     검색한 책 이미지 가져오기
//        func fetchImage(for thumbnail: String, completion: @escaping (UIImage?) -> Void) {
//           guard let url = URL(string: "https://dapi.kakao.com/v3/search/book?query=\(thumbnail)") else { return }
//    
//            URLSession.shared.dataTask(with: url) { (data, response, error ) in
//                guard let data = data, error == nil else {
//                    print("Failed to fetch image: \(error?.localizedDescription ?? "Unknown error")")
//                    completion(nil)
//                    return
//                }
//                if let image = UIImage(data: data) {
//                    completion(image)
//                } else {
//                    print("Failed to create image from data")
//                    completion(nil)
//                }
//            }.resume()
//        }
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == searchResultCollectionView {
            return searchedList.count
        } else {
            return recentList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == searchResultCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchedCollectionviewCell.identifier, for: indexPath) as? SearchedCollectionviewCell else { return UICollectionViewCell()}
            
            cell.configureUI(searched: searchedList[indexPath.row])
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentCollectionViewCell.identifier, for: indexPath) as? RecentCollectionViewCell else { return UICollectionViewCell()}
            
            cell.configureUI(recent: recentList[indexPath.row])
            
            return cell
        }
        
    }
    
}

extension ViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchedList.removeAll()
        searchResultCollectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        let networkingManager = NetworkingManager()
        
        networkingManager.fetchBookAPI(title: searchText) {
            searchBooks in
            self.searchedList = searchBooks
           
            DispatchQueue.main.async {
                self.searchResultCollectionView.reloadData()
            }
        }
            
            
    }
    
}

