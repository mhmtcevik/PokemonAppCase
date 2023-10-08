//
//  ViewModel.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 6.10.2023.
//

import Foundation

protocol ViewModelBehavior {
    var imageService: ImageService { get }
    var realmService: RealmService { get }
    var fetchService: FetchService { get }
}

class ViewModel: ViewModelBehavior {
    
    var imageService: ImageService
    var realmService: RealmService
    var fetchService: FetchService
    
    
    init() {
        imageService = ImageService()
        realmService = RealmService()
        fetchService = FetchService()
    }
}
