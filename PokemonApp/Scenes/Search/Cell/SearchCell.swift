//
//  SearchCell.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 7.10.2023.
//

import Foundation
import UIKit

class SearchCell: UICollectionViewCell {
    
    enum CellIdentifier: String {
        case identifier = "SearchCell"
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
        label.numberOfLines = 2
        
        return label
    }()
    
    let button = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        return button
    }()
    
    //MARK: Variables
    var buttonTappedHandler: (() -> Void)?
    
    //MARK: Functions    
    func configureActions() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction))
        button.addGestureRecognizer(longPressGesture)
    }
    
    @objc
    func longPressAction() {
        buttonTappedHandler?()
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
    
    func configureData(for card: Card) {
        nameLabel.text = card.name
    }
    
    func showHeartAnimation() {
        let heartImageView = UIImageView(image: UIImage(systemName: "heart.fill"))
        heartImageView.image?.withRenderingMode(.alwaysTemplate)
        heartImageView.tintColor = .red
        heartImageView.contentMode = .scaleAspectFit
        
        addSubview(heartImageView)
        bringSubviewToFront(heartImageView)
        
        heartImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.width.equalTo(100)
        }

        UIView.animate(withDuration: 0.5, animations: {
            heartImageView.alpha = 0.0
            heartImageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { (finished) in
            heartImageView.removeFromSuperview()
        }
    }
    
}
