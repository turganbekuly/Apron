//
//  CategorySelectionViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import UIKit
import Models
import PanModal
import AlertMessages

protocol CategorySelectionDisplayLogic: AnyObject {
    func displayCategories(viewModel: CategorySelectionDataFlow.GetCategories.ViewModel)
}

final class CategorySelectionViewController: ViewController, PanModalPresentable, Messagable {
    
    struct Section {
        enum Section {
            case options(String)
        }
        enum Row {
            case option(CommunityCategory)
        }
        
        let section: Section
        let rows: [Row]
    }
    
    // MARK: - Properties
    let interactor: CategorySelectionBusinessLogic
    var sections: [Section] = [] {
        didSet {
            mainView.reloadData()
        }
    }
    var state: State {
        didSet {
            updateState()
        }
    }

    var hasLoaded = false

    var delegate: CategorySelectionProtocol?

    var selectedCategory: CommunityCategory?

    var categories: [CommunityCategory]? {
        didSet {
            guard let categories = categories else {
                return
            }
            hasLoaded = true
            panModalSetNeedsLayoutUpdate()
            panModalTransition(to: .longForm)

            sections = [
                .init(
                    section: .options("Категории"),
                    rows: categories.compactMap { .option($0) }
                )
            ]
        }
    }

    // MARK: - PanModal Properties

    var panScrollable: UIScrollView? {
        return nil
    }

    var longFormHeight: PanModalHeight {
        if hasLoaded {
            return .contentHeight(CGFloat(((categories?.count ?? 1) * 45) + 130))
        }

        return .contentHeight(500)
    }

    var cornerRadius: CGFloat {
        return 25
    }

    var transitionDuration: Double {
        return 0.4
    }
    
    // MARK: - Views
    lazy var mainView: CategorySelectionView = {
        let view = CategorySelectionView()
        view.dataSource = self
        view.delegate = self
        return view
    }()

    private lazy var doneButton: BlackOpButton = {
        let button = BlackOpButton()
        button.setTitle("Сохранить", for: .normal)
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 17
        button.layer.masksToBounds = true
        return button
    }()
    
    // MARK: - Init
    init(interactor: CategorySelectionBusinessLogic, state: State) {
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
        [mainView, doneButton].forEach { view.addSubview($0) }
        
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
        doneButton.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(38)
        }

        mainView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(doneButton.snp.top)
        }
    }
    
    private func configureColors() {
        view.backgroundColor = Assets.secondary.color
    }

    // MARK: - User actions

    @objc
    private func doneButtonTapped() {
        guard let selectedCategory = selectedCategory else {
            return
        }

        dismiss(animated: true) {
            self.delegate?.selectedCategory(category: selectedCategory)
        }
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}
