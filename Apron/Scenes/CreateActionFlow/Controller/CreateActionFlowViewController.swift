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
            case mainPageCreation
            case communityPageCreation
            case communityPageRecipe
            case communityPageReport
            case communityPageMore
            case recipePageAdd
            case savedPageCreate
        }
        enum Row {
            case privateCommunity(CreateActionType)
            case publicCommunity(CreateActionType)
            case aboutCommunities(CreateActionType)
            case savedRecipe(CreateActionType)
            case newRecipe(CreateActionType)
            case recipeAddTo(CreateActionType)
            case recipeShare(CreateActionType)
            case recipeSave(CreateActionType)
            case recipeReportType(CreateActionType)
            case reportRecipe(CreateActionType)
            case reportUser(CreateActionType)
            case shareCommunity(CreateActionType)
            case reportCommunity(CreateActionType)
            case shoppingList(CreateActionType)
            case mealPlan(CreateActionType)
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

    weak var delegate: CreateActionFlowProtocol?

    var initialState: CreateActionInitialState? {
        didSet {
            switch initialState {
            case .mainPageCommunityCreation:
                sections = [
                    .init(
                        section: .mainPageCreation, rows: [
                            .publicCommunity(.publicCommunity),
                            .privateCommunity(.privateCommunity),
                            .aboutCommunities(.aboutCommunities)
                        ]
                    )
                ]
            case .communityPageRecipeCreation:
                sections = [
                    .init(
                        section: .communityPageCreation,
                        rows: [
                            .savedRecipe(.savedRecipe),
                            .newRecipe(.newRecipe)
                        ]
                    )
                ]
            case .recipePageAddTo:
                sections = [
                    .init(section: .recipePageAdd, rows: [.shoppingList(.shoppingList)])
                ]
            case .communityPageMore:
                sections = [
                    .init(
                        section: .communityPageMore,
                        rows: [.shareCommunity(.shareCommunity), .reportCommunity(.reportCommunity)]
                    )
                ]

            default:
                break
            }
            mainView.reloadData()

        }
    }

    // MARK: - PanModal Properties

    var panScrollable: UIScrollView? {
        return nil
    }

    var longFormHeight: PanModalHeight {
        return .contentHeight(170)
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
