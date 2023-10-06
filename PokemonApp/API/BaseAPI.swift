//
//  BaseAPI.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 5.10.2023.
//

import Foundation
import Alamofire

class BaseAPI<T: TargetType> {
    
    private func buildParams(task: Task) -> ([String : Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(let parameters, let encoding):
            return (parameters, encoding)
        }
    }
    
    func fetchData<M: Decodable>(target: T, responseClass: M.Type, completionhandler: @escaping (Result<M, NSError>) -> Void) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let parameters = buildParams(task: target.task)
        
        AF.request(
            target.baseURL + target.path,
            method: method,
            parameters: parameters.0,
            encoding: parameters.1,
            headers: headers).responseJSON { response in
                
                guard let statusCode = response.response?.statusCode else {
                    completionhandler(.failure(NSError()))
                    return
                }
                
                if statusCode == 200 {
                    guard let jsonResponse = try? response.result.get() else {
                        completionhandler(.failure(NSError()))
                        return
                    }
                    
                    guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {
                        completionhandler(.failure(NSError()))
                        return
                    }
                    
                    guard let jsonObject = try? JSONDecoder().decode(M.self, from: jsonData) else {
                        completionhandler(.failure(NSError()))
                        return
                    }
                    
                    completionhandler(.success(jsonObject))
                } else {
                    completionhandler(.failure(NSError()))
                }
                
            }
    }
    
}
