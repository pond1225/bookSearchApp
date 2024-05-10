//
//  NetworkingManager.swift
//  bookSearchApp
//
//  Created by t2023-m0049 on 5/10/24.
//

import Foundation

class NetworkingManager {
    func fetchBookAPI(title: String, completion: @escaping (([searchBook]) -> Void)) {
        
        guard let url = URL(string: "https://dapi.kakao.com/v3/search/book?query=\(title)") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let headers = ["Authorization" : "KakaoAK a331656c9c6174d504a0b758822e3416"]
        urlRequest.allHTTPHeaderFields = headers
        
        
        URLSession.shared.dataTask(with: urlRequest)
        { data, response, error in
            
            if let error = error {
                print("에러 발생!", error)
            }
            guard let data = data else { return }

            
            guard let bookResponse = try?
                    JSONDecoder().decode(bookResponse.self, from: data) else { return }

            completion(bookResponse.documents)
        }
        .resume()
        
    }
    
}
