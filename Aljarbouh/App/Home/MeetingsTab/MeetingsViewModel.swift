//
//  MeetingsViewModel.swift
//  Aljarbouh
//
//  Created by Hendawi on 28/04/2024.
//

import Foundation

class MeetingsViewModel {
    private let endpoint = "meetings"
    
    private var getMeetingsResponse: GetMeetings?
    var meetings: [Meeting] {
        return getMeetingsResponse?.data ?? []
    }
    
    private var getMeetingResponse: GetMeetings?
    var meeting: Meeting{
        return getMeetingsResponse?.data![0] ?? Meeting()
    }
    
    func list(date: String = "", completion: @escaping (Result<Void, Error>) -> Void){
        let url = ApiConfig.baseUrl + endpoint
        ApiServices.shared.genericGetRequest(url: url) { [weak self] (response: Result<GetMeetings, Error>) in
            guard let self = self else { return }
            
//            print(response)
            
            switch response{
            case .success(let data):
                print("DEBUG: List All Meetings Successfully")
                self.getMeetingsResponse = data
                completion(.success(()))
            case .failure(let error):
                print("DEBUG: List All Meetings Failed")
                completion(.failure(error))
            }
        }
    }
    
    func retrieve(date: String, completion: @escaping (Result<Void, Error>) -> Void){
        let url = ApiConfig.baseUrl + endpoint + "?date=\(date)"
        ApiServices.shared.genericGetRequest(url: url) { [weak self] (response: Result<GetMeetings, Error>) in
            guard let self = self else { return }
            
//            print(response)
            
            switch response{
            case .success(let data):
                print("DEBUG: Fetching Meeting Successfully")
                self.getMeetingResponse = data
                completion(.success(()))
            case .failure(let error):
                print("DEBUG: Fetching Meeting Failed")
                completion(.failure(error))
            }
        }
    }
}
