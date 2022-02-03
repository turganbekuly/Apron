//
//  TasteOnboardingViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import Protocols
import UIKit
import Models
import Storages

public protocol TasteOnboardingDisplayLogic: AnyObject {
    
}

public final class TasteOnboardingViewController: ViewController, ISkipButtonActionHander {
    
    public struct Section {
        enum Section {
            case options(String)
        }
        enum Row {
            case option(String)
        }
        
        let section: Section
        let rows: [Row]
    }
    
    // MARK: - Properties
    public let interactor: TasteOnboardingBusinessLogic
    public var sections: [Section] = [] {
        didSet {
            mainView.reloadData()
        }
    }
    public var state: State {
        didSet {
            updateState()
        }
    }
    public var tasteOnboardingTypes: TasteOnboardingScreenType? {
        didSet {
            if let text = tasteOnboardingTypes?.text, let title = tasteOnboardingTypes?.title {
                sections = [
                    .init(section: .options(title), rows: text.compactMap { .option($0) })
                ]
            }
            if tasteOnboardingTypes == .vegan {
                mainView.allowsMultipleSelection = false
            } else {
                mainView.allowsMultipleSelection = true
            }
        }
    }
    private let tasteOnboardingStorage = TasteOnboardingStorage()
    var tasteOnboardingModel: TasteOnboardingModel? {
        didSet {
            tasteOnboardingStorage.model = tasteOnboardingModel
        }
    }
    
    // MARK: - Views
    public lazy var mainView: TasteOnboardingView = {
        let view = TasteOnboardingView()
        view.dataSource = self
        view.delegate = self
        return view
    }()

    public lazy var nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Assets.colorsYello.color
        button.setImage(Assets.arrowForward.image, for: .normal)
        button.layer.cornerRadius = 28
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    public init(interactor: TasteOnboardingBusinessLogic, state: State) {
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
        
        configureColors()
    }
    
    // MARK: - Methods
    private func configureNavigation() {
        var counterPage: String = ""
        switch tasteOnboardingTypes {
        case .vegan: counterPage = "1"
        case .ingredients: counterPage = "2"
        case .cuisine: counterPage = "3"
        default: break
        }
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: SkipButtonNavigationView(delegate: self))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: ScreenCounterNavigationView(currectPage: counterPage))
    }
    
    private func configureViews() {
        [mainView, nextButton].forEach { view.addSubview($0) }
        
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(56)
            $0.width.equalTo(56)
        }
        mainView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(nextButton.snp.top).offset(-8)
        }
    }
    
    private func configureColors() {
        view.backgroundColor = Assets.secondary.color
    }

    // MARK: - User actions

    private func nextScreenAction() {
        switch tasteOnboardingTypes {
        case .vegan:
            let vc = TasteOnboardingBuilder(state: .initial(.ingredients, tasteOnboardingModel ?? TasteOnboardingModel())).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: false)
            }
        case .ingredients:
            let vc = TasteOnboardingBuilder(state: .initial(.cuisine, tasteOnboardingModel ?? TasteOnboardingModel())).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: false)
            }
        default: break
        }
    }

    @objc func skipButtonTapped() {
        nextScreenAction()
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
}
