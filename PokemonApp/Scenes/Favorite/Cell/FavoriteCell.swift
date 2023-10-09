//
//  FavoriteCell.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 7.10.2023.
//

import Foundation
import UIKit

class FavoriteCell: UICollectionViewCell {
    
    enum CellIdentifier: String {
        case identifier = "FavoriteCell"
    }
    
    //MARK: UI Components
    let imageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let nameLabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.sfProTextMedium, size: 18)
        label.textColor = .nameFont
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    let button = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        return button
    }()
    
    //MARK: Variables
    var buttonLongTappedHandler: (() -> Void)?
    var buttonShortTappedHandler: (() -> Void)?
    
    //MARK: Functions
    func configureActions() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction))
        button.addGestureRecognizer(longPressGesture)
        
        button.addTarget(self, action: #selector(shortPressAction), for: .touchUpInside)
    }
    
    @objc
    func longPressAction(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            buttonLongTappedHandler?()
        }
    }
    
    @objc
    func shortPressAction() { 
        buttonShortTappedHandler?()
    }
       
    
    func configureViews() {
        self.layer.cornerRadius = 15
        self.backgroundColor = .cellBakcground
        self.addShadow(color: .shadow, alpha: 0.05, x: 0, y: 0, blur: 24)
        
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(button)
    }
    
    func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(170)
            make.width.equalTo(150)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        button.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configureData(for card: Favorite) {
        nameLabel.text = card.name
        
        if let data = card.imageData {
            imageView.image = UIImage(data: data)
        }
    }
    
}
