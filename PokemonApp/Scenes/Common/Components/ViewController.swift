//
//  ViewController.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 6.10.2023.
//

import UIKit

protocol ViewControllable {
    var viewModel: ViewModel? { get set }
}

class ViewController: UIViewController, Navigatable, ViewControllable {
    
    var navigator: Navigator!
    var viewModel: ViewModel?

    init(navigator: Navigator!, viewModel: ViewModel?) {
        self.navigator = navigator
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    
}
