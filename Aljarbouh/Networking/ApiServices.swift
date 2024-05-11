//
//  ApiServices.swift
//  Aljarbouh
//
//  Created by Hendawi on 12/04/2024.
//

import UIKit
import Alamofire
import SwiftyJSON
import SystemConfiguration

final class ApiServices: NSObject {
    static let shared = ApiServices()
    
    let baseUrl = ApiConfig.baseUrl
    
    //MARK: - Generic Get Request
    func genericGetRequest<T: Decodable>(url: String, parameters: [String: Any]? = [:], completion: @escaping(Result<T, Error>) -> Void) {
        guard let token = UserDefaultsManager.shared.retrieve(forKey: UserDefaultKeys.AuthToken) as? String else {
            completion(.failure(NSError(domain: "unauthorized", code: 0)))
            return
        }
        
        if !Helper.sharedHelper.isConnectedToNetwork() {
            completion(.failure(NSError(domain: "internet", code: 0)))
            return
        }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)",
                                    "Accept":"application/json"]
        
//                print(T.self)
//                print("URL: \(url)")
//                print("Parameters: \(parameters?.printJson())")
//                print("headers: \(headers)")
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate()
            .response { response in
//                                print(JSON(response.data))
                switch response.result {
                case .success:
                    guard let data = response.data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let object = try decoder.decode(T.self, from: data)
                        completion(.success(object))
                    } catch {
                        print("DEBUG: Error decoding JSON: \(error)")
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print("DEBUG: An error occurred: \(error)")
                    completion(.failure(error))
                }
            }
    }
    
    //MARK: - Generic Delete Request
    func genericDeleteRequest(endpoint: String, id: Int, completion: @escaping(Result<Bool, Error>, String) -> Void){
        guard let token = UserDefaultsManager.shared.retrieve(forKey: UserDefaultKeys.AuthToken) as? String else {
            completion(.failure(NSError(domain: "unauthorized", code: 0)), "")
            return
        }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)",
                                    "Accept":"application/json"]
        
        if !Helper.sharedHelper.isConnectedToNetwork() {
            completion(.failure(NSError(domain: "internet", code: 0)), "")
        }
        
        AF.request(baseUrl + "\(endpoint)/\(id)", method: .delete, headers: headers)
            .validate()
            .response { response in
                print(JSON(response.data ?? ""))
                switch response.result {
                case .success:
                    if let statusCode = response.response?.statusCode {
                        switch statusCode {
                        case 200..<300:
                            let msg = JSON(response.data as Any)["msg"].rawValue as! String
                            print(msg)
                            completion(.success(true), msg)
                        default:
                            let msg = JSON(response.data as Any)["error"].rawValue as! String
                            print(msg)
                            completion(.failure(NSError(domain: "unexpected_status_code", code: statusCode)), msg)
                        }
                    } else {
                        // No status code in the response
                        let msg = JSON(response.data as Any)["error"].rawValue as! String
                        print(msg)
                        completion(.failure(NSError(domain: "no_status_code", code: 0)), msg)
                    }
                case .failure:
                    let msg = JSON(response.data as Any)["error"].rawValue as! String
                    print(msg)
                    completion(.failure(NSError(domain: msg, code: 0)), msg)
                }
            }
    }
    
    //MARK: - Login
    func login(email: String, password: String, completion: @escaping(Result<GetLoginResponse, Error>) -> Void){
        
        let params: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        params.printJson()
        
        let headers: HTTPHeaders = ["Accept":"application/json"]
        
        if !Helper.sharedHelper.isConnectedToNetwork() {
            completion(.failure(NSError(domain: "internet", code: 0)))
        }
        
        AF.request(baseUrl + "login", method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
            .validate()
            .response { response in
//                print(JSON(response.data))
                switch response.result {
                case .success:
                    guard let data = response.data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let object = try decoder.decode(GetLoginResponse.self, from: data)
                        completion(.success(object))
                    } catch {
                        print("DEBUG: Error decoding JSON: \(error)")
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print("DEBUG: An error occurred: \(error)")
                    completion(.failure(error))
                }
            }
    }
    
    
    //MARK: - Register
    func register(name: String, email: String, phone: String, password: String, completion: @escaping(Result<GetLoginResponse, Error>) -> Void){
        
        let params: [String: Any] = [
            "name": name,
            "email": email,
            "phone": phone,
            "password": password,
            "password_confirmation": password
        ]
        
        params.printJson()
        
        let headers: HTTPHeaders = ["Accept":"application/json"]
        
        if !Helper.sharedHelper.isConnectedToNetwork() {
            completion(.failure(NSError(domain: "internet", code: 0)))
        }
        
        AF.request(baseUrl + "register", method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
            .validate()
            .response { response in
                print(JSON(response.data as Any))
                switch response.result {
                case .success:
                    guard let data = response.data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let object = try decoder.decode(GetLoginResponse.self, from: data)
                        completion(.success(object))
                    } catch {
                        print("DEBUG: Error decoding JSON: \(error)")
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print("DEBUG: An error occurred: \(error)")
                    completion(.failure(error))
                }
            }
    }
    
    
    //MARK: - Update Profile
    func updateProfile(id: Int, fatherName: String, grandFatherName: String, grand2FatherName: String, bornLocation: String, image: UIImage, dateOfBirth: String, profession: String, completion: @escaping(Result<GetProfileResponse, Error>) -> Void){
        
        guard let token = UserDefaultsManager.shared.retrieve(forKey: UserDefaultKeys.AuthToken) as? String else {
            completion(.failure(NSError(domain: "unauthorized", code: 0)))
            return
        }
        
        if !Helper.sharedHelper.isConnectedToNetwork() {
            completion(.failure(NSError(domain: "internet", code: 0)))
            return
        }
        
        let params: [String: Any] = [
            "_method": "PUT",
            "father_name": fatherName,
            "grand_father_name": grandFatherName,
            "grand2_father_name": grand2FatherName,
            "born_location": bornLocation,
            "date_of_born": dateOfBirth,
            "profission": profession
        ]
        
        params.printJson()
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)",
                                    "Accept":"application/json"]
        
        if !Helper.sharedHelper.isConnectedToNetwork() {
            completion(.failure(NSError(domain: "internet", code: 0)))
        }
        
        AF.upload(
            multipartFormData: { multipartFormData in
                // Add text parameters
                for (key, value) in params {
                    if let stringValue = value as? String {
                        multipartFormData.append(stringValue.data(using: .utf8)!, withName: key)
                    }
                }
                if let imageData = image.jpegData(compressionQuality: 0) {
                    multipartFormData.append(imageData, withName: "image", fileName: "profile_image.jpg", mimeType: "image/jpeg")
                }
            },
            to: baseUrl + "profiles/\(id)", headers: headers
        )
        .response { response in
            print(JSON(response.data as Any))
            print(response.response?.statusCode as Any)
            switch response.result {
            case .success:
                print("success")
                if let data = response.data{
                    do {
                        let decoder = JSONDecoder()
                        let object = try decoder.decode(GetProfileResponse.self, from: data)
                        completion(.success(object))
                    } catch {
                        print("DEBUG: Error decoding JSON: \(error)")
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(AFError.responseValidationFailed(reason: .dataFileNil)))
                }
            case .failure(let error):
                print("fail")
                completion(.failure(error))
            }
        }
    }
}
