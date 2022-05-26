//
//  AuthorizationViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import Protocols
import UIKit
import SnapKit

protocol AuthorizationDisplayLogic: AnyObject {
    func login(viewModel: AuthorizationDataFlow.Login.ViewModel)
}

final class AuthorizationViewController: ViewController {
    // MARK: - Properties
    let interactor: AuthorizationBusinessLogic

    var state: State {
        didSet {
            updateState()
        }
    }
    
    // MARK: - Views

    private lazy var skipButton: BlackOpButton = {
        let button = BlackOpButton(arrowState: .none, frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        button.setTitle("Пропустить", for: .normal)
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()


    lazy var mainView: AuthorizationView = {
        let view = AuthorizationView(delegate: self)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    // MARK: - Init
    init(interactor: AuthorizationBusinessLogic, state: State) {
        self.interactor = interactor
        self.state = state
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Life Cycle
    override  func loadView() {
        super.loadView()
        
        configureViews()
    }

    override  func viewDidLoad() {
        super.viewDidLoad()
        
        state = { state }()
    }
    
    override  func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureNavigation()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        configureColors()
    }
    
    // MARK: - Methods
    private func configureNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: skipButton)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clear
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
        
    }

    // MARK: - User actions

    @objc
    private func skipButtonTapped() {
        let alert = UIAlertController(
            title: "Вы действительно хотите пропустить?",
            message: "Вы пропустите персонализированный контент и сохранение наших вкусных рецептов.",
            preferredStyle: .alert
        )
        let yesAction = UIAlertAction(title: "Да", style: .default) { [weak self] _ in
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }

                if self.presentingViewController != nil {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    let viewController = TabBarBuilder(state: .initial(.normal)).build()
                    DispatchQueue.main.async {
                        self.navigationController?.pushViewController(viewController, animated: true)
                    }
                }
            }
        }
        let noAction = UIAlertAction(title: "Нет", style: .cancel)
        [noAction, yesAction].forEach {
            alert.addAction($0)
        }
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}
