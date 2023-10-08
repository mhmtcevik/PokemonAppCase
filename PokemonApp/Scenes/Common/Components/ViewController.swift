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
        super.init(nibName: nil, bundle: nil)
        
        self.navigator = navigator
        self.viewModel = viewModel
        
        self.bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    func bindViewModel() { }
    
    func calculateCellSize(for collectionView: UICollectionView) -> CGSize {
        let cellSpacing: CGFloat = collectionView.bounds.width  * AppConstants.CollectionView.cellSpaceRate
        let minCellWidth: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? AppConstants.CollectionView.width : AppConstants.CollectionView.width
        
        let activeWidth = collectionView.bounds.width - AppConstants.CollectionView.totalContentInset
        let numberOfCellsPerRow = Int(floor((activeWidth + cellSpacing) / (minCellWidth + cellSpacing)))
        
        let cellWidth = floor((activeWidth - CGFloat((numberOfCellsPerRow - 1)) * cellSpacing) / CGFloat(numberOfCellsPerRow))
        let cellHeight = floor(cellWidth * AppConstants.CollectionView.cellHeightRate)
        
        let cellSize = CGSize(width: cellWidth, height: cellHeight)
        
        return cellSize
    }
    
}
