//
//  StorageNetworking.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 5.10.2023.
//

import Foundation
import Alamofire

enum Networking {
    case getSearchItems(path: String, parameters: [String : Any])
    case getItemById(path: String, itemId: String)
}

extension Networking: TargetType {
    var baseURL: String {
        switch self {
        case .getSearchItems(_, _):
            return AppConstants.API.baseURL
        case .getItemById(_, _):
            return AppConstants.API.baseURL
        }
    }
    
    var path: String {
        switch self {
        case .getSearchItems(let path, _):
            return path
        case .getItemById(let path, let id):
            return path + "/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getSearchItems(_, _):
            return .get
        case .getItemById(_, _):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getSearchItems(_, let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .getItemById(_, _):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getSearchItems(_, _):
            return [:]
        case .getItemById(_, _):
            return [:]
        }
    }
    
}
