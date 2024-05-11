//
//  BanksViewModel.swift
//  Aljarbouh
//
//  Created by Hendawi on 02/05/2024.
//

import Foundation

class BanksViewModel {
    private let endpoint = "banks"
    
    private var getBanksResponse: GetBanksResponse?
    var banks: [Bank] {
        return getBanksResponse?.data ?? []
    }
    
    func list(completion: @escaping (Result<Void, Error>) -> Void){
        let url = ApiConfig.baseUrl + endpoint
        ApiServices.shared.genericGetRequest(url: url) { [weak self] (response: Result<GetBanksResponse, Error>) in
            guard let self = self else { return }
            
//            print(response)
            
            switch response{
            case .success(let data):
                print("DEBUG: List All Banks Successfully")
                self.getBanksResponse = data
                completion(.success(()))
            case .failure(let error):
                print("DEBUG: List All Banks Failed")
                completion(.failure(error))
            }
        }
    }
}
