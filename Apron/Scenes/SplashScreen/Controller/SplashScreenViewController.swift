//
//  SplashScreenViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
import UIKit

protocol SplashScreenDisplayLogic: AnyObject {
    func displayUpdateToken(with viewModel: SplashScreenDataFlow.UpdateToken.ViewModel)
}

final class SplashScreenViewController: ViewController {
    // MARK: - Properties
    let interactor: SplashScreenBusinessLogic
    var state: State {
        didSet {
            updateState()
        }
    }

    // MARK: - Views
    lazy var mainView: SplashScreenView = {
        let view = SplashScreenView(delegate: self)
        return view
    }()

    // MARK: - Init
    init(interactor: SplashScreenBusinessLogic, state: State) {
        self.interactor = interactor
        self.state = state

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        state = { state }()
        configureViews()
        mainView.configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureNavigation()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
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
        view.backgroundColor = APRAssets.whiteSmoke.color
    }

    deinit {
        NSLog("deinit \(self)")
    }

}
