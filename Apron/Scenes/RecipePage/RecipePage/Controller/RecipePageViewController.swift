//
//  RecipePageViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import UIKit

protocol RecipePageDisplayLogic: AnyObject {
    
}

final class RecipePageViewController: ViewController {
    // MARK: - Properties

    let interactor: RecipePageBusinessLogic
    var pages: [RecipeInitialState] = [.ingredients, .instruction, .calories]
    var delta: CGFloat = 0

    lazy var sections: [Section] = [
        .init(section: .pages, rows: pages.compactMap { .page($0)} )
    ]
    
    var state: State {
        didSet {
            updateState()
        }
    }

    public var initialState: RecipeInitialState = .ingredients {
        didSet {
            selectedIndexPath = IndexPath(row: pages.firstIndex(of: initialState) ?? .zero, section: .zero)
            configurePager()
        }
    }

    public var selectedIndexPath = IndexPath(row: .zero, section: .zero)
    public lazy var pagerViewController: RecipeInfoPagerViewController = {
        guard
            let viewController = RecipeInfoPagerBuilder(state: .initial(pages, initialState)).build()
            as? RecipeInfoPagerViewController
        else {
            return RecipeInfoPagerViewController(state: .initial([], .ingredients))
        }

        viewController.pagerDelegate = self
        return viewController
    }()
    
    // MARK: - Views

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.delegate = self
        return scrollView
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    lazy var infoHeaderView: RecipeInformationView = {
        let view = RecipeInformationView()
        return view
    }()

    lazy var mainView: RecipePageView = {
        let view = RecipePageView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    init(interactor: RecipePageBusinessLogic, state: State) {
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: Assets.navBackButton.image,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.backgroundColor = Assets.secondary.color
    }
    
    private func configureViews() {
        [infoHeaderView, mainView].forEach {
            stackView.addArrangedSubview($0)
        }
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: UIScreen.main.bounds.height)
        [scrollView].forEach { view.addSubview($0) }
        [stackView].forEach { scrollView.addSubview($0) }
        
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(360)
            $0.width.equalTo(view.bounds.width)
        }

//        infoHeaderView.snp.makeConstraints {
//            $0.top.leading.trailing.equalToSuperview()
//            $0.height.equalTo(320)
//            $0.width.equalTo(view.bounds.width)
//        }
//
//        mainView.snp.makeConstraints {
//            $0.top.equalTo(infoHeaderView.snp.bottom)
//            $0.leading.equalToSuperview()
//            $0.trailing.equalToSuperview()
//            $0.height.equalTo(34)
//        }
    }
    
    private func configureColors() {
        view.backgroundColor = Assets.secondary.color
    }
    
    deinit {
        NSLog("deinit \(self)")
    }

    // MARK: - User actions

    @objc
    private func backButtonTapped() { }
}
