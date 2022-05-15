//
//  GeneralSearchResultViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import UIKit

protocol GeneralSearchResultDisplayLogic: AnyObject {
    
}

final class GeneralSearchResultViewController: ViewController {
    
    struct Section {
        enum Section {
            case results
        }
        enum Row {
            case result(GeneralSearchInitialState)
        }
        
        let section: Section
        let rows: [Row]
    }
    
    // MARK: - Properties
    let interactor: GeneralSearchResultBusinessLogic
    lazy var sections: [Section] = []
    var state: State {
        didSet {
            updateState()
        }
    }

    var searchTerm: String? {
        didSet {
            pagerViewController.query = searchTerm ?? ""
        }
    }

    public var pages: [GeneralSearchInitialState] = [] {
        didSet {
           sections = [.init(section: .results, rows: pages.compactMap { .result($0) })]
        }
    }

    var initialState: GeneralSearchInitialState? {
        didSet {
            switch initialState {
            case .main:
                pages = [.everything, .recipe, .community]
                pagerInitialState = .everything
            case .recipe, .saved:
                pages = [.recipe]
                pagerInitialState = .recipe
            default:
                break
            }
        }
    }

    public var selectedIndexPath = IndexPath(row: .zero, section: .zero)

    public var pagerInitialState: GeneralSearchInitialState = .everything {
        didSet {
            selectedIndexPath = IndexPath(row: pages.firstIndex(of: pagerInitialState) ?? .zero, section: .zero)
            configurePager()
        }
    }

    lazy var pagerViewController: GeneralSearchResultPagerViewController = {
        guard let viewController = GeneralSearchResultPagerBuilder(
            state: .initial(pages, pagerInitialState)
        ).build() as? GeneralSearchResultPagerViewController else {
            return GeneralSearchResultPagerViewController(state: .initial([], .everything))
        }
        viewController.pagerDelegate = self
        return viewController
    }()
    
    // MARK: - Views
    lazy var mainView: GeneralSearchResultView = {
        let view = GeneralSearchResultView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    init(interactor: GeneralSearchResultBusinessLogic, state: State) {
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
        navigationItem.title = ""
    }
    
    private func configureViews() {
        [mainView].forEach { view.addSubview($0) }
        
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(59)
        }
    }
    
    private func configureColors() {
        view.backgroundColor = Assets.secondary.color
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}
