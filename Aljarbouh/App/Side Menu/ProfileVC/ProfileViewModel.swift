//
//  ProfileViewModel.swift
//  Aljarbouh
//
//  Created by Hendawi on 01/05/2024.
//

import Foundation

class ProfileViewModel {
    private let endpoint = "profiles"
    
    private var getProfileResponse: GetProfileResponse?
    var profile: Profile {
        return getProfileResponse?.data ?? Profile()
    }
    
    func retrieve(id: Int, completion: @escaping (Result<Void, Error>) -> Void){
        let url = ApiConfig.baseUrl + endpoint + "/\(id)"
        print(url)
        ApiServices.shared.genericGetRequest(url: url) { [weak self] (response: Result<GetProfileResponse, Error>) in
            guard let self = self else { return }
            
            print(response)
            
            switch response{
            case .success(let data):
                print("DEBUG: Retrieved Profile Successfully")
                self.getProfileResponse = data
                completion(.success(()))
            case .failure(let error):
                print("DEBUG: Retrieved Profile Failed")
                completion(.failure(error))
            }
        }
    }
}
