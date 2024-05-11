//
//  FamilyTreeViewModel.swift
//  Aljarbouh
//
//  Created by Hendawi on 02/05/2024.
//

import Foundation

class FamilyTreeViewModel{
    private let endpoint = "profiles"
    
    private var getFamilyTreeResponse: GetFamilyTreeResponse?
    var profiles: [Profile] {
        return getFamilyTreeResponse?.data ?? []
    }
    
    func list(filter: String = "", completion: @escaping (Result<Void, Error>) -> Void){
        let url = ApiConfig.baseUrl + endpoint + filter
        
        print(url)
        ApiServices.shared.genericGetRequest(url: url) { [weak self] (response: Result<GetFamilyTreeResponse, Error>) in
            guard let self = self else { return }
            
//            print(response)
            
            switch response{
            case .success(let data):
                print("DEBUG: List All Family Successfully")
                self.getFamilyTreeResponse = data
                completion(.success(()))
            case .failure(let error):
                print("DEBUG: List All Family Failed")
                completion(.failure(error))
            }
        }
    }
}
