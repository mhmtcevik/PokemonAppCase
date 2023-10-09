//
//  DetailViewModel.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 5.10.2023.
//

import Foundation
import UIKit

protocol DetailViewModelInterface {
    var output: DetailViewController! { get }
    var item: Card? { get }
    var favorite: Favorite? { get }
    
    func fetchItem(id: String, completionhandler: @escaping (_ card: FavoriteItem?) -> Void)
    func fetchImage(urlString: String?)
    func setViewControllerDelegate(for viewController: DetailViewController)
    func viewDidLoad()
}

class DetailViewModel: ViewModel, DetailViewModelInterface {
    
    var favorite: Favorite?
    var item: Card?
    
    var output: DetailViewController!
    
    init(item: Card?, favorite: Favorite?) {
        self.item = item
        self.favorite = favorite
        
        super.init()
    }
    
    func setViewControllerDelegate(for viewController: DetailViewController) {
        output = viewController
    }
    
    func viewDidLoad() {
        output.setInformation(item: item, favorite: favorite)
        fetchImage(urlString: item?.imageUrl)
    }
    
     func fetchItem(id: String, completionhandler: @escaping (_ card: FavoriteItem?) -> Void) {
         fetchService.getItemById(path: AppConstants.API.cardPath, itemId: id) { result in
             guard let card = try? result.get() else { return }
             completionhandler(card)
         }
     }
    
    func fetchImage(urlString: String?) {
        if favorite == nil {
            output.loadingStatus(with: .loading)
            
            imageService.fetchImage(from: urlString, completionHandler: { [weak self] result, image in
                self?.output.setImage(image: image)
                self?.output.loadingStatus(with: .completed)
            })
        } else {
            self.output.setImage(image: UIImage(data: favorite?.imageData ?? Data()))
        }
    }
    
}
