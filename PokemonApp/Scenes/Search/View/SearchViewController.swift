//
//  SearchViewController.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 5.10.2023.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        StorageAPI().getData(path: "/cards?hp=gte99") { result in
            print(try? result.get())
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
