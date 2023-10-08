//
//  UIView+Extensions.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 7.10.2023.
//

import Foundation
import UIKit

extension UIView {
    
    func addShadow(
        color: UIColor,
        alpha: Float,
        x: CGFloat = 0,
        y: CGFloat = 0,
        blur: CGFloat = 4
    ) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur / 2.0
    }
    
}
