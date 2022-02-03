//
//  SearchViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 14/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import UIKit

public protocol SearchDisplayLogic: AnyObject {
    
}

public final class SearchViewController: ViewController {
    
    public struct Section {
        enum Section {
            
        }
        enum Row {
            
        }
        
        let section: Section
        let rows: [Row]
    }
    
    // MARK: - Properties
    public let interactor: SearchBusinessLogic
    public var sections: [Section] = []
    public var state: State {
        didSet {
            updateState()
        }
    }
    
    // MARK: - Views
    public lazy var mainView: SearchView = {
        let view = SearchView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    public init(interactor: SearchBusinessLogic, state: State) {
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
