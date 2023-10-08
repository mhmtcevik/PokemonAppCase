//
//  TabBarController.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 5.10.2023.
//

import UIKit

protocol TabBarControllerOutput {
    var viewModel: TabBarViewModel? { get }
}

class TabBarController: UITabBarController, Navigatable {
    
    var navigator: Navigator!
    var viewModel: TabBarViewModel?
    
    init(navigator: Navigator!, viewModel: TabBarViewModel? = nil) {
        self.navigator = navigator
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        
        viewModel?.setViewControllerDelegate(for: self)
        bindTabBarItems()
    }
    
    func bindTabBarItems() {
        guard let viewModel = viewModel else { return }
        
        self.viewControllers = viewModel.tabBarItems.map {
            $0.getViewController(viewModel: viewModel.viewModel(for: $0.self), navigator: navigator)
        }
    }
    
    func setupViews() {
        configureTabBar()
    }
    
    func configureTabBar() {
        self.tabBar.backgroundColor = .white
        self.tabBar.isTranslucent = false
    }
    

}
