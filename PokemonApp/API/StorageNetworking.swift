//
//  StorageNetworking.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 5.10.2023.
//

import Foundation

enum StorageNetworking {
    case getStorage(path: String)
}

extension StorageNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .getStorage(_):
            return AppConstants.API.baseURL
        }
    }
    
    var path: String {
        switch self {
        case .getStorage(let path):
            return path
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getStorage(_):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getStorage(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getStorage(_):
            return [:]
        }
    }
    
}
