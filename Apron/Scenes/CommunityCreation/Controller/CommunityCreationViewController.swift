//
//  CommunityCreationViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import Models
import AlertMessages

protocol CommunityCreationDisplayLogic: AnyObject {
    func displayCreatedCommunity(with viewModel: CommunityCreationDataFlow.CreateCommunity.ViewModel)
}

final class CommunityCreationViewController: ViewController, Messagable {
    
    // MARK: - Properties
    let interactor: CommunityCreationBusinessLogic
    var sections: [Section] = []

    var initialState: CommunityCreationInitialState? {
        didSet {
            switch initialState {
            case let .create(communityCreation),
                let .edit(communityCreation):
                self.communityCreation = communityCreation
                sections = [
                    .init(
                        section: .info,
                        rows: [
                            .name, .imagePlaceholder, .description,
                            .category, .privacy, .permission
                        ]
                    )
                ]
                mainView.reloadData()
            default:
                break
            }
        }
    }

    var state: State {
        didSet {
            updateState()
        }
    }

    var communityCreation: CommunityCreation?

    var selectedImage: UIImage? {
        didSet {
            mainView.reloadTableViewWithoutAnimation()
            replaceImageCell(type: .image)
        }
    }
    
    // MARK: - Views

    private lazy var saveButton: NavigationButton = {
        let button = NavigationButton()
        button.setTitle("Создать", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var backButton = NavigationBackButton()

    lazy var mainView: CommunityCreationView = {
        let view = CommunityCreationView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    init(interactor: CommunityCreationBusinessLogic, state: State) {
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
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        configureColors()
    }
    
    // MARK: - Methods
    private func configureNavigation() {
        backButton.configure(with: "Новое сообщество")
        backButton.onBackButtonTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationController?.navigationBar.backgroundColor = ApronAssets.secondary.color
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        saveButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(30)
        }
    }
    
    private func configureViews() {
        [mainView].forEach { view.addSubview($0) }
        
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureColors() {
        view.backgroundColor = ApronAssets.secondary.color
    }
    
    deinit {
        NSLog("deinit \(self)")
    }

    // MARK: - User actions

    @objc
    private func saveButtonTapped() {
        if let _ = communityCreation?.communityName,
//           let _ = communityCreation?.imageURL,
           let _ = communityCreation?.description,
           let _ = communityCreation?.category,
           let _ = communityCreation?.privateAdding
        {
            self.createCommunity(with: communityCreation)
        } else {
            show(
                type: .dialog(
                "Обязательные поля!",
                "Пожалуйста, заполните все поля, чтобы остальным учасникам было все понятно. Спасибо!",
                "Понятно",
                "Заполнить"
            ),
                firstAction: nil,
                secondAction: nil
            )
        }
    }
}
