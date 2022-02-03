//
//  AuthorizationMethodsViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import UIKit
import Protocols

public protocol AuthorizationMethodsDisplayLogic: AnyObject {
    
}

public final class AuthorizationMethodsViewController: ViewController {
    // MARK: - Properties
    public let interactor: AuthorizationMethodsBusinessLogic
    public var state: State {
        didSet {
            updateState()
        }
    }
    public var authorizaitonType: AuthorizationType? {
        didSet {
            mainView.authorizationType = authorizaitonType
        }
    }
    
    // MARK: - Views
    public lazy var mainView: AuthorizationMethodsView = {
        let view = AuthorizationMethodsView(delegate: self)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    // MARK: - Init
    public init(interactor: AuthorizationMethodsBusinessLogic, state: State) {
        self.interactor = interactor
        self.state = state
        
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Life Cycle
    override public func loadView() {
        super.loadView()
        
        configureViews()
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        state = { state }()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigation()
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    // MARK: - Methods
    private func configureNavigation() {
        navigationItem.title = ""
    }
    
    private func configureViews() {
        view.backgroundColor = .black.withAlphaComponent(0.5)
        let tapGR = UISwipeGestureRecognizer(target: self, action: #selector(backroundTapped))
        tapGR.direction = [.down, .up]
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGR)
        [mainView].forEach { view.addSubview($0) }
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.7)
            $0.height.equalToSuperview().multipliedBy(0.45)
        }
    }
    
    @objc
    private func backroundTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}
