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


public final class AuthorizationViewController: ViewController {
    // MARK: - Properties
    public var state: State {
        didSet {
            updateState()
        }
    }
    
    // MARK: - Views
    public lazy var mainView: AuthorizationView = {
        let view = AuthorizationView(delegate: self)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    // MARK: - Init
    public init(state: State) {
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
        
        configureColors()
    }
    
    // MARK: - Methods
    private func configureNavigation() {
        navigationController?.setNavigationBarHidden(true, animated: false)
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
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}
