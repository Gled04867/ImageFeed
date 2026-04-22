import UIKit
import Kingfisher

final class ProfileViewController: UIViewController {
    
    private lazy var imageView = UIImageView()
    private lazy var nameLabel = UILabel()
    private lazy var loginLabel = UILabel()
    private lazy var statusLabel = UILabel()
    private lazy var button = UIButton(type: .system)
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    private let tokenStorage = OAuth2TokenStorage.shared
    private var profileImageServiceObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "YP Black")
        setupImage()
        setupNameLabel()
        setupLoginLabel()
        setupStatusLabel()
        setupButton()
        
        if let profile = profileService.profile {
            updateProfileDetails(profile: profile)
        }
        
        profileImageServiceObserver = NotificationCenter.default
            .addObserver(
                forName: ProfileImageService.didChangeNotification,
                object: nil,
                queue: .main
            ) {[weak self] _ in
                guard let self else { return }
                self.updateAvatar( )
            }
        updateAvatar()
    }
    
    private func updateAvatar() {
        guard
            let profileImageURL = profileImageService.avatarURL,
            let imageUrl = URL(string: profileImageURL)
        else { return }
        
        print("imageUrl: \(imageUrl)")
        let placeholderImage = UIImage(systemName: "person.circle.fill")?
            .withTintColor(.lightGray, renderingMode: .alwaysOriginal)
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 70, weight: .regular, scale: .large))
        let processor = RoundCornerImageProcessor(cornerRadius: 35)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: imageUrl,
            placeholder: placeholderImage,
            options: [.processor(processor),
                      .scaleFactor(UIScreen.main.scale),
                      .cacheOriginalImage,
                      .forceRefresh]) { result in
                      
                          switch result {
                          case .success(let value):
                              //Картинка
                              print(value.image)
                              // Откуда картинка загружена:
                              // - .none — из сети.
                              // - .memory — из кэша оперативной памяти.
                              // - .disk — из дискового кэша.
                              print(value.cacheType)
                              // Информация об источнике
                              print(value.source)
                              
                          case .failure(let error):
                              print(error)
                          }
                      }
    }
    
    private func updateProfileDetails(profile: Profile) {
        nameLabel.text = profile.name.isEmpty
        ? "Имя не указано"
        : profile.name
        loginLabel.text = profile.loginName.isEmpty
        ? "@неизвестный исполнитель"
        : profile.loginName
        statusLabel.text = (profile.bio?.isEmpty ?? true)
        ? "Профиль не заполнен"
        : profile.bio
    }
    
    
    
    private func setupImage() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
    }
    
    private func setupNameLabel() {
        nameLabel.text = "Екатерина Новикова"
        nameLabel.textColor = .ypWhite
        nameLabel.font = .systemFont(ofSize: 23, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupLoginLabel() {
        loginLabel.text = "@ekaterina_nov"
        loginLabel.textColor = .ypGray
        loginLabel.font = .systemFont(ofSize: 13, weight: .regular)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginLabel)
        
        loginLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        loginLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        loginLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
    }
    
    private func setupStatusLabel() {
        statusLabel.text = "Hello, world!"
        statusLabel.textColor = .ypWhite
        statusLabel.font = .systemFont(ofSize: 13, weight: .regular)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statusLabel)
        
        statusLabel.leadingAnchor.constraint(equalTo: loginLabel.leadingAnchor).isActive = true
        statusLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 8).isActive = true
        statusLabel.trailingAnchor.constraint(equalTo: loginLabel.trailingAnchor).isActive = true
    }
    
    private func setupButton() {
        button.setImage(UIImage(systemName: "ipad.and.arrow.forward"), for: .normal)
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        button.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
    }
}
