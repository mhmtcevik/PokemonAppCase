//
//  DetailViewController.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 5.10.2023.
//

import UIKit

class DetailViewController: ViewController {
    //MARK: UI Components
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Pokemon") //TODO: sil
        return imageView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    let namelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.sfProTextMedium, size: 18)
        label.textColor = .nameFont
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let hpLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.sfProTextMedium, size: 14)
        label.textColor = .nameFont
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        configureConstraints()
    }
    
    //MARK: Functions  
    func  setupViews() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        configureViews()
    }
    
    func configureViews() {
        view.addSubview(profileImageView)
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(namelabel)
        stackView.addArrangedSubview(hpLabel)
    }
    
    func configureConstraints() {
         profileImageView.snp.makeConstraints { make in
             make.leading.equalToSuperview().offset(24)
             make.trailing.equalToSuperview().offset(-24)
             make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
             make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-100)
             
         }
         
        stackView.snp.makeConstraints { make in
        
        }
    }

}
