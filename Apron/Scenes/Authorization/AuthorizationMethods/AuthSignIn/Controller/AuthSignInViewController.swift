//
//  AuthSignInViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import UIKit

protocol AuthSignInDisplayLogic: AnyObject {
    
}

final class AuthSignInViewController: ViewController {
    // MARK: - Properties

    let interactor: AuthSignInBusinessLogic

    var state: State {
        didSet {
            updateState()
        }
    }
    
    // MARK: - Views
    lazy var mainView: AuthSignInView = {
        let view = AuthSignInView(delegate: self)
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.font = TypographyFonts.semibold20
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(
            Assets.navBackButton.image
                .withTintColor(.black),
            for: .normal
        )
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var leftButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [backButton, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    // MARK: - Init
    init(interactor: AuthSignInBusinessLogic, state: State) {
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButtonStackView)
        navigationController?.navigationBar.backgroundColor = Assets.secondary.color
    }
    
    private func configureViews() {
        [mainView].forEach { view.addSubview($0) }
        
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func configureColors() {
        view.backgroundColor = Assets.secondary.color
    }

    // MARK: - User actions

    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}
