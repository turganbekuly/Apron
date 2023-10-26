//
//  EditProfileViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 23/10/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import Storages
import Models
import AlertMessages
import NVActivityIndicatorView

protocol EditProfileDisplayLogic: AnyObject {
    func displayUpdateProfile(with viewModel: EditProfileDataFlow.EditProfile.ViewModel)
    func displayUploadImage(with viewModel: EditProfileDataFlow.UploadImage.ViewModel)
}

final class EditProfileViewController: ViewController {
    // MARK: - Properties
    let interactor: EditProfileBusinessLogic
    var state: State {
        didSet {
            updateState()
        }
    }
    
    weak var delegate: EditProfileResultProtocol?
    var userStorage: UserStorageProtocol = UserStorage()
    
    lazy var editingUser: User = userStorage.user ?? User()
    var selectedImage: UIImage? {
        didSet {
            guard let image = selectedImage else { return }
            userImageView.image = image
        }
    }
    
    // MARK: - Init
    init(interactor: EditProfileBusinessLogic, state: State) {
        self.interactor = interactor
        self.state = state
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        configureViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        state = { state }()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigation()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        configureColors()
    }
    
    // MARK: - Views factory
    
    private lazy var userImageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedAvatar)))
        return view
    }()
    
    private lazy var userImageView: UIImageView = {
        let view = UIImageView(image: APRAssets.user.image.withRenderingMode(.alwaysTemplate))
        view.tintColor = APRAssets.gray.color
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        view.clipsToBounds = true
        view.layer.cornerRadius = 50
        return view
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(APRAssets.primaryTextMain.color, for: .normal)
        button.setImage(APRAssets.editIcon.image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTappedAvatar), for: .touchUpInside)
        return button
    }()
    
    lazy var nicknameTextField: LoginTextField = {
        let textField = LoginTextField(
            placeholder: L10n.Authorization.Username.tfPlaceholder,
            title: L10n.Authorization.Username.tfTitle
        )
        return textField
    }()

    private lazy var emailTextField: LoginTextField = {
        let textField = LoginTextField(
            placeholder: L10n.Authorization.Email.tfPlaceholder,
            title: L10n.Authorization.Email.tfTitle
        )
        textField.textField.isEnabled = false
        textField.alpha = 0.5
        return textField
    }()
    
    private lazy var backButton = NavigationBackButton()
    private lazy var saveButton: NavigationButton = {
        let button = NavigationButton()
        button.backgroundType = .blackBackground
        button.setTitle(L10n.Common.Save.title, for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Methods
    private func configureNavigation() {
        backButton.configure(with: L10n.Profile.Edit.Navigation.title)
        backButton.onBackButtonTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: false)
        }
        
        navigationController?.navigationBar.backgroundColor = APRAssets.secondary.color
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        saveButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(30)
        }
    }
    
    private func configureViews() {
        nicknameTextField.textField.text = userStorage.user?.username
        emailTextField.textField.text = userStorage.user?.email
        let url = URL(string: userStorage.user?.image ?? "")
        userImageView.kf.setImage(
            with: url,
            placeholder: APRAssets.user.image.withRenderingMode(.alwaysTemplate)
        )
        
        view.addSubviews(
            userImageContainerView,
            nicknameTextField,
            emailTextField
        )
        
        userImageContainerView.addSubviews(
            userImageView,
            editButton
        )
        
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
        userImageContainerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(120)
        }
        
        userImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(100)
        }
        
        editButton.snp.makeConstraints {
            $0.size.equalTo(30)
            $0.trailing.equalTo(userImageView.snp.trailing).offset(2)
            $0.bottom.equalTo(userImageView.snp.bottom).offset(2)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(userImageContainerView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(65)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(65)
        }
    }
    
    private func configureColors() {
        view.backgroundColor = APRAssets.secondary.color
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
    // MARK: - User acitons

    @objc
    private func didTappedAvatar() {
        openMediaModal()
    }
    
    @objc
    private func saveButtonTapped() {
        showLoader()
        if let image = selectedImage {
            uploadImage(with: image)
            return
        }
        
        if let username = nicknameTextField.textField.text {
            editingUser.username = username
        }
        
        editingUser.email = userStorage.user?.email
        updateProfile(with: editingUser)
    }
}
