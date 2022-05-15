//
//  ResultListViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import UIKit

protocol ResultListDisplayLogic: AnyObject {
    
}

final class ResultListViewController: ViewController {
    
    struct Section {
        enum Section {
            case everything
            case community
            case recipe
        }
        enum Row {
            case community
            case recipe
            case loading
        }
        
        let section: Section
        let rows: [Row]
    }
    
    // MARK: - Properties
    let interactor: ResultListBusinessLogic
    var sections: [Section] = []
    var state: State {
        didSet {
            updateState()
        }
    }

    var query: String? {
        didSet {
            switch initialState {
            case .everything:
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.sections = [
                        .init(section: .everything, rows: Array(repeating: .loading, count: 10))
                    ]
                    self.mainView.reloadData()
                }
            case .recipe:
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.sections = [
                        .init(section: .everything, rows: Array(repeating: .loading, count: 10))
                    ]
                    self.mainView.reloadData()
                }
            case .community:
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.sections = [
                        .init(section: .everything, rows: Array(repeating: .loading, count: 10))
                    ]
                    self.mainView.reloadData()
                }
            default:
                break
            }
        }
    }

    var initialState: GeneralSearchInitialState?
    
    // MARK: - Views
    lazy var mainView: ResultListView = {
        let view = ResultListView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    init(interactor: ResultListBusinessLogic, state: State) {
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
        view.backgroundColor = Assets.secondary.color
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}
