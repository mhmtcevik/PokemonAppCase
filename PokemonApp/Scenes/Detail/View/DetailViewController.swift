//
//  DetailViewController.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 5.10.2023.
//

import UIKit

enum LoadingStatus {
    case loading
    case completed
}

protocol DetailViewControllerOutput {
    var card: Card! { get }
    
    func setImage(image: UIImage?)
    func setInformation(item: Card?)
    func loadingStatus(with status: LoadingStatus)
}

class DetailViewController: ViewController, DetailViewControllerOutput {
    //MARK: UI Components
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
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
        label.font = UIFont(name: UIFont.sfProTextMedium, size: 22)
        label.textColor = .nameFont
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let hpLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.sfProTextMedium, size: 18)
        label.textColor = .nameFont
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "Detail"
        label.font = UIFont(name: UIFont.sfProTextMedium, size: 28)
        label.textColor = .black
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(
            systemName: "chevron.backward")?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(.black), for: .normal)
        return button
    }()
    
    private lazy var indicatorView = UIActivityIndicatorView(style: .large)
    
    //MARK: -Variables
    var card: Card!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        configureConstraints()
        setupActions()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        guard let viewModel = self.viewModel as? DetailViewModel else { return }
        viewModel.setViewControllerDelegate(for: self)
        
        viewModel.viewDidLoad()
    }
    
    //MARK: Functions  
    func  setupViews() {
        self.view.backgroundColor = .white
        
        configureViews()
    }
    
    func setupActions() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func backButtonTapped() {
        dismiss(animated: true)
    }
    
    func configureViews() {
        view.addSubview(profileImageView)
        
        view.addSubview(backButton)
        view.addSubview(topLabel)
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(namelabel)
        stackView.addArrangedSubview(hpLabel)
        
        view.addSubview(indicatorView)
    }
    
    func configureConstraints() {
         profileImageView.snp.makeConstraints { make in
             make.leading.equalToSuperview().offset(24)
             make.trailing.equalToSuperview().offset(-24)
             make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
             make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-120)
         }
         
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            make.height.width.equalTo(40)
        }
        
        topLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backButton)
        }
        
        indicatorView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func setImage(image: UIImage?) {
        guard let image = image else {
            profileImageView.image = UIImage(named: "DefaultBackgroundImage")
            return
        }
        profileImageView.image = image
    }
    
    func setInformation(item: Card?) {
        namelabel.text = item?.name
        hpLabel.text = "\(String(describing: item?.hp ?? "")) HP"
    }
    
    func loadingStatus(with status: LoadingStatus) {
        status == .loading ? indicatorView.startAnimating() : indicatorView.stopAnimating()
    }

}
