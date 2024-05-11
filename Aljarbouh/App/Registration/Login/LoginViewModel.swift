//
//  LoginViewModel.swift
//  Aljarbouh
//
//  Created by Hendawi on 12/04/2024.
//

import Foundation

class LoginViewModel {
    
    private var getLoginResponse: GetLoginResponse?
    var loginResponse: LoginResponse {
        return getLoginResponse?.data ?? LoginResponse()
    }
    
    func login(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void){
        ApiServices.shared.login(email: email, password: password) { result in
            switch result {
            case .success(let response):
                
                if let token = response.data?.accessToken {
                    UserDefaultsManager.shared.store(token, forKey: UserDefaultKeys.AuthToken)
                }
                UserDefaultsManager.shared.store(true, forKey: UserDefaultKeys.LoggedIn)
                UserDefaultsManager.shared.store(false, forKey: UserDefaultKeys.ShowOnboarding)
                UserDefaultsManager.shared.store(response.data?.profile?.id, forKey: UserDefaultKeys.ProfileID)
                
                self.getLoginResponse = response
                
                print("Login successful. User: \(String(describing: response.data?.user))")
                completion(.success(true))
            case .failure(let error):
                print("Login failed. Error: \(error)")
                completion(.failure(error))
            }
        }
    }
    
}
