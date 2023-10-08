//
//  ImageService.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 7.10.2023.
//

import Foundation
import AlamofireImage
import Alamofire
import UIKit

protocol IImageService {
    func fetchImage(from urlString: String?, completionHandler: @escaping (_ result: Bool, _ image: UIImage?)->Void)
}

class ImageService: IImageService {
    
    func fetchImage(from urlString: String?, completionHandler: @escaping (_ result: Bool, _ image: UIImage?)->Void) {
        guard let urlString = urlString else { 
            completionHandler(false, nil)
            return
        }
        
        AF.request(urlString).responseImage { response in
            debugPrint(response)
            debugPrint(response.result)
            
            if case .success(let image) = response.result {
                print("image downloaded: \(image)")
                completionHandler(true, image)
                return
            }
            
            completionHandler(false, nil)
        }
    }
}
