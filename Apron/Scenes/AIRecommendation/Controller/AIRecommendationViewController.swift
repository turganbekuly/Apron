//
//  AIRecommendationViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27/05/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import APRUIKit
import UIKit

protocol AIRecommendationDisplayLogic: AnyObject {
    
}

final class AIRecommendationViewController: ViewController {
    // MARK: - Properties
    let interactor: AIRecommendationBusinessLogic
    var viewState: AIRecommendationStagesState = .familyCount {
        didSet {
            // update view
        }
    }
    
    var state: State {
        didSet {
            updateState()
        }
    }
    
    // MARK: - Views
    
    // MARK: - Init
    init(interactor: AIRecommendationBusinessLogic, state: State) {
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
        [].forEach { view.addSubview($0) }
        
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
    }
    
    private func configureColors() {
        
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}
