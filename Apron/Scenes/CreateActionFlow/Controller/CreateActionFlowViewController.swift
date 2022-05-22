//
//  CreateActionFlowViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import UIKit
import PanModal

protocol CreateActionFlowDisplayLogic: AnyObject {
    
}

final class CreateActionFlowViewController: ViewController, PanModalPresentable {
    
    struct Section {
        enum Section {
            case buttons
        }
        enum Row {
            case privateCommunity
            case publicCommunity
            case aboutCommunities
            case savedRecipe
            case newRecipe
        }
        
        let section: Section
        let rows: [Row]
    }
    
    // MARK: - Properties

    var sections: [Section] = []
    var state: State {
        didSet {
            updateState()
        }
    }

    var initialState: CreateActionInitialState? {
        didSet {
            switch initialState {
            case .community:
                sections = [.init(section: .buttons, rows: [.publicCommunity, .privateCommunity, .aboutCommunities])]
            case .recipe:
                sections = [.init(section: .buttons, rows: [.savedRecipe, .newRecipe])]
            default:
                break
            }
//            panModalSetNeedsLayoutUpdate()
//            panModalTransition(to: .longForm)
            mainView.reloadData()
        }
    }

    // MARK: - PanModal Properties

    var panScrollable: UIScrollView? {
        return nil
    }

    var longFormHeight: PanModalHeight {
        switch initialState {
        case .community:
            return .contentHeight(200)
        case .recipe:
            return .contentHeight(150)
        default:
            break
        }
        return .contentHeight(200)
    }

    var cornerRadius: CGFloat {
        return 25
    }

    var transitionDuration: Double {
        return 0.4
    }
    
    // MARK: - Views
    lazy var mainView: CreateActionFlowView = {
        let view = CreateActionFlowView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    init(state: State) {
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
        view.backgroundColor = Assets.secondary.color
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}
