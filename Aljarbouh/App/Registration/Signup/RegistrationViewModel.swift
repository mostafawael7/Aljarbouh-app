//
//  RegistrationViewModel.swift
//  Aljarbouh
//
//  Created by Hendawi on 25/04/2024.
//

import Foundation
import UIKit

class RegistrationViewModel {
    private var getLoginResponse: GetLoginResponse?
    var loginResponse: LoginResponse {
        return getLoginResponse?.data ?? LoginResponse()
    }
    
    private var getUpdateProfileResponse: GetProfileResponse?
    var profile: Profile{
        return getUpdateProfileResponse?.data ?? Profile()
    }
    
    func register(name: String, email: String, phone: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void){
        ApiServices.shared.register(name: name, email: email, phone: phone, password: password) { result in
            switch result {
            case .success(let response):
                
                if let token = response.data?.accessToken {
                    UserDefaultsManager.shared.store(token, forKey: UserDefaultKeys.AuthToken)
                    print("Auth Token✅")
                }
                UserDefaultsManager.shared.store(true, forKey: UserDefaultKeys.LoggedIn)
                UserDefaultsManager.shared.store(false, forKey: UserDefaultKeys.ShowOnboarding)
                
                self.getLoginResponse = response
                
                print("Registration successful. User: \(String(describing: response.data?.user))")
                completion(.success(true))
            case .failure(let error):
                print("Registration failed. Error: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    
    func updateProfile(id: Int, fatherName: String, grandFatherName: String, grand2FatherName: String, bornLocation: String, image: UIImage, dateOfBirth: String, profession: String, completion: @escaping (Result<Bool, Error>) -> Void){
        ApiServices.shared.updateProfile(id: id, fatherName: fatherName, grandFatherName: grandFatherName, grand2FatherName: grand2FatherName, bornLocation: bornLocation, image: image, dateOfBirth: dateOfBirth, profession: profession) { result in
            switch result {
            case .success(let response):
                self.getUpdateProfileResponse = response
                
                print("Updating Profile successful. User: \(String(describing: response))")
                completion(.success(true))
            case .failure(let error):
                print("Updating Profile failed. Error: \(error)")
                completion(.failure(error))
            }
        }
    }
    
}
