//
//  NewsViewModel.swift
//  Aljarbouh
//
//  Created by Hendawi on 26/04/2024.
//

import Foundation

class NewsViewModel {
    private let endpoint = "news"
    
    private var getNewsResponse: GetNewsResponse?
    var news: [News] {
        return getNewsResponse?.data ?? []
    }
    
    func list(completion: @escaping (Result<Void, Error>) -> Void){
        let url = ApiConfig.baseUrl + endpoint
        ApiServices.shared.genericGetRequest(url: url) { [weak self] (response: Result<GetNewsResponse, Error>) in
            guard let self = self else { return }
            
//            print(response)
            
            switch response{
            case .success(let data):
                print("DEBUG: List All News Successfully")
                self.getNewsResponse = data
                completion(.success(()))
            case .failure(let error):
                print("DEBUG: List All News Failed")
                completion(.failure(error))
            }
        }
    }
}
