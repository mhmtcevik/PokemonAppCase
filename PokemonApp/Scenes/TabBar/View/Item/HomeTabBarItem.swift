//
//  HomeTabBarItem.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 6.10.2023.
//

import Foundation
import UIKit

enum TabBarItem: Int, CaseIterable {
    case search, favorite
}

extension TabBarItem {
    
    private func getNavigationController(with viewModel: ViewModel, navigator: Navigator) -> UIViewController {
        switch self {
        case .search:
            let vc = SearchViewController()
            return NavigationController(rootViewController: vc)
            
        case .favorite:
            let vc = FavoriteViewController()
            return NavigationController(rootViewController: vc)
        }
    }
    
    func getViewController(viewModel: ViewModel, navigator: Navigator) -> UIViewController {
        let vc = getNavigationController(with: viewModel, navigator: navigator)
        let item = UITabBarItem(title: self.itemTitle, image: self.itemImage, tag: self.rawValue)
        vc.tabBarItem = item
        return vc
    }
    
    var itemImage: UIImage {
        switch self {
        case .search: return UIImage(systemName: "magnifyingglass") ?? UIImage()
        case .favorite: return UIImage(systemName: "heart") ?? UIImage()
        }
    }
    
    var itemTitle: String {
        switch self {
        case .search: return "Search"
        case .favorite: return "Favorite"
        }
    }
    
}
