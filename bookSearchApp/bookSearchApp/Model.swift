//
//  Model.swift
//  bookSearchApp
//
//  Created by t2023-m0049 on 5/9/24.
//

import Foundation
import UIKit


struct recentModel {
    var bookImage: UIImage
    var bookTitle: String
}


struct savedModel {
    var bookTitle: String
    var author: String
    var price: String
}


struct bookResponse: Decodable {
    var documents: [searchBook]
}

struct searchBook: Decodable {
    var title: String
    var thumbnail: String
    var authors: [String]
    var price: Int
    var contents: String
}
