//
//  TabBarViewModel.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 5.10.2023.
//

import Foundation
import UIKit

protocol TabBarViewModelBehavior {
    var output: TabBarController! { get }
    var tabBarItems: [TabBarItem] { get }
    
    func setViewControllerDelegate(for viewController: TabBarController)
    func setTabBarItems()
}

class TabBarViewModel: TabBarViewModelBehavior {
    //MARK: Variables
    var output: TabBarController!
    var tabBarItems: [TabBarItem] = []
    
    init() {
        setTabBarItems()
    }
    
    //MARK: Functions
    func setViewControllerDelegate(for viewController: TabBarController) {
        output = viewController
    }
    
    func setTabBarItems() {
        tabBarItems = TabBarItem.allCases.map { $0 }
    }
    
    func viewModel(for tabBarItem: TabBarItem) -> ViewModel {
        switch tabBarItem {
        case .search: return SearchViewModel()
        case .favorite: return FavoriteViewModel()
        }
    }
    
}
