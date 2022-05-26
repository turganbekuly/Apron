//
//  AddSavedRecipesViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 26/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import UIKit

protocol AddSavedRecipesDisplayLogic: AnyObject {
    
}

final class AddSavedRecipesViewController: ViewController {
    
    struct Section {
        enum Section {
            
        }
        enum Row {
            
        }
        
        let section: Section
        let rows: [Row]
    }
    
    // MARK: - Properties
    let interactor: AddSavedRecipesBusinessLogic
    var sections: [Section] = []
    var state: State {
        didSet {
            updateState()
        }
    }
    
    // MARK: - Views
    lazy var mainView: AddSavedRecipesView = {
        let view = AddSavedRecipesView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    init(interactor: AddSavedRecipesBusinessLogic, state: State) {
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
            make.edges.equalToSuperview()
        }
    }
    
    private func configureColors() {
        
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}
