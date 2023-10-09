//
//  Navigator.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 6.10.2023.
//

import Foundation
import UIKit

protocol Navigatable {
    var navigator: Navigator! { get }
}

class Navigator {
    
    enum Scene {
        case detail(viewModel: DetailViewModel)
    }
    
    enum Transition {
        case navigation
        case present
    }
    
    private func get(segue: Scene) -> UIViewController? {
        switch segue {
            
        case .detail(let viewModel):
            let vc = DetailViewController(navigator: self, viewModel: viewModel)
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            
            return vc
        }
    }
    
    func pop(sender: UIViewController?, toRoot: Bool = false) {
        if toRoot {
            sender?.navigationController?.popToRootViewController(animated: true)
        } else {
            sender?.navigationController?.popViewController(animated: true)
        }
    }
    
    func dismiss(sender: UIViewController?) {
        sender?.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func show(segue: Scene, sender: UIViewController?, transition: Transition) {
        if let target = get(segue: segue) {
            show(target: target, sender: sender, transition: transition)
        }
    }
    
    private func show(target: UIViewController, sender: UIViewController?, transition: Transition) {
        switch transition {
        case .navigation:
            if let nav = sender?.navigationController {
                nav.pushViewController(target, animated: false)
                return
            }
        case .present:
            DispatchQueue.main.async {
                sender?.present(target, animated: true, completion: nil)
            }
        }
    }
    
}
