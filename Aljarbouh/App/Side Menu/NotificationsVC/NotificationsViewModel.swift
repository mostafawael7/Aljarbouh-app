//
//  NotificationsViewModel.swift
//  Aljarbouh
//
//  Created by Hendawi on 02/05/2024.
//

import Foundation

class NotificationsViewModel {
    private let endpoint = "notifies"
    
    private var getNotificationsResponse: GetNotificationsResponse?
    var notifications: [Notification] {
        return getNotificationsResponse?.data ?? []
    }
    
    func list(completion: @escaping (Result<Void, Error>) -> Void){
        let url = ApiConfig.baseUrl + endpoint
        ApiServices.shared.genericGetRequest(url: url) { [weak self] (response: Result<GetNotificationsResponse, Error>) in
            guard let self = self else { return }
            
//            print(response)
            
            switch response{
            case .success(let data):
                print("DEBUG: List All Notifications Successfully")
                self.getNotificationsResponse = data
                completion(.success(()))
            case .failure(let error):
                print("DEBUG: List All Notifications Failed")
                completion(.failure(error))
            }
        }
    }
}
