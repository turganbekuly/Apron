//
//  CommunityPageViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import SnapKit
import Models
import AlertMessages
import Storages

protocol CommunityPageDisplayLogic: AnyObject {
    func displayCommunity(viewModel: CommunityPageDataFlow.GetCommunity.ViewModel)
    func displayJoinCommunity(viewModel: CommunityPageDataFlow.JoinCommunity.ViewModel)
    func displayRecipesByCommunity(viewModel: CommunityPageDataFlow.GetRecipesByCommunity.ViewModel)
    func displaySaveRecipe(viewModel: CommunityPageDataFlow.SaveRecipe.ViewModel)
}

public final class CommunityPageViewController: ViewController, Messagable {
    // MARK: - Properties
    let interactor: CommunityPageBusinessLogic
    var sections: [Section] = []

    var state: State {
        didSet {
            updateState()
        }
    }

    var communityPageViewedSourceType: CommunityPageSourceType = .unknown

    var initialState: CommunityPageInitialState? {
        didSet {
            switch initialState {
            case let .fromMain(id):
                self.id = id
                self.communityPageViewedSourceType = .homepage
                getCommunities(by: id)
            case let .fromAddedRecipes(id):
                self.id = id
                self.communityPageViewedSourceType = .unknown
                joinCommunity(with: id)
            case let .fromDeeplink(id):
                self.id = id
                self.communityPageViewedSourceType = .deeplink
                getCommunities(by: id)
            case let .fromSearch(id):
                self.id = id
                self.communityPageViewedSourceType = .search
                getCommunities(by: id)
            default:
                break
            }
        }
    }

    var selectedSegment: CommunitySegmentView.CommunitySegment? {
        didSet {
            //
        }
    }

    var community: CommunityResponse? {
        didSet {
            guard let community = community else {
                return
            }

            self.imageView.imageUrl = community.image
            if recipes.isEmpty {
                sections = [
                    .init(section: .topView, rows: [.emptyView])
                ]
            } else {
                sections = [
                    .init(
                        section: .topView,
                        rows: recipes.compactMap { .recipiesView($0) }
                    )
                ]
            }
            communityPageViewedEvent(community: community)
            createRecipeButton.isHidden = community.privateAdding == true ? true : false
            mainView.reloadTableViewWithoutAnimation()
        }
    }

    var recipes: [RecipeResponse] = []

    var currentPage = 1
    var id = 0

    private var tableViewTopConstraint: Constraint?
    private var cacheOffset: CGPoint?
    
    // MARK: - Views
    lazy var imageView: ImageHeaderView = {
        let imageHeader = ImageHeaderView()
        return imageHeader
    }()

    private lazy var navigationBarView = UIView()

    private lazy var backButton = NavigationIconFillButton()
    private lazy var moreButton = NavigationIconFillButton()

    public lazy var mainView: CommunityPageView = {
        let view = CommunityPageView()
        view.dataSource = self
        view.delegate = self
        return view
    }()

    private lazy var createRecipeButton: BlackOpButton = {
        let button = BlackOpButton(backgroundType: .yelloBackground)
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.setImage(ApronAssets.creationPlusButton.image, for: .normal)
        button.clipsToBounds = true
        button.isHidden = true
        return button
    }()

    private lazy var refreshControl = UIRefreshControl()
    
    // MARK: - Init
    init(interactor: CommunityPageBusinessLogic, state: State) {
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

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationBarView.frame = CGRect(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.width,
            height: view.safeAreaInsets.top
        )
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        configureColors()
    }

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle()
    }
    
    // MARK: - Private Methods

    private func configureNavigation() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.leftBarButtonItem =  UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moreButton)
    }
    
    private func configureViews() {
        mainView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshControlActivated), for: .valueChanged)
        backButton.icon = ApronAssets.navBackButton.image.withTintColor(.black)
        moreButton.icon = ApronAssets.navMoreButton.image.withTintColor(.black)
        backButton.onTouch = { [weak self] in
            switch self?.initialState {
            case .fromAddedRecipes:
                self?.navigationController?.popToRootViewController(animated: false)
            default:
                self?.navigationController?.popViewController(animated: true)
            }
        }

        [imageView, mainView, navigationBarView, createRecipeButton].forEach { view.addSubview($0) }

        mainView.addInfiniteScroll { [weak self] _ in
            guard let self = self else { return }
            self.getRecipesByCommunity(id: self.id, currentPage: self.currentPage)
        }

        moreButton.onTouch = { [weak self] in
            guard let self = self else { return }
            self.navigateToCreateActionFlow(with: .communityPageMore)
        }
        
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        mainView.snp.makeConstraints {
            tableViewTopConstraint = $0.top
                .equalToSuperview().offset(imageView.imageHeight - 36)
                .constraint
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }

        createRecipeButton.snp.makeConstraints {
            $0.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.size.equalTo(50)
        }
    }

    private func statusBarStyle() -> UIStatusBarStyle {
        guard let topConstraintConstant = tableViewTopConstraint?.layoutConstraints.first?.constant else {
            return .default
        }

        if topConstraintConstant < view.safeAreaInsets.top {
            return .default
        }

        return .lightContent
    }
    
    private func configureColors() {
        view.backgroundColor = ApronAssets.secondary.color
        navigationBarView.backgroundColor = .clear
        refreshControl.tintColor = .white
        refreshControl.backgroundColor = .clear
    }

    // MARK: - Analytics events

    func communityPageViewedEvent(community: CommunityResponse) {
        ApronAnalytics.shared.sendAmplitudeEvent(
            .communityPageViewed(
                CommunityPageViewedModel(
                    communityID: community.id,
                    communityName: community.name ?? "",
                    sourceType: communityPageViewedSourceType
                )
            )
        )
    }

    func joinedCommunityEvent() {
        ApronAnalytics.shared.sendAmplitudeEvent(
            .joinedCommunity(
                JoinedCommunityModel(
                    communityID: community?.id ?? 0,
                    communityName: community?.name ?? "",
                    sourceType: .community
                )
            )
        )
    }

    // MARK: - Public methods

    func navigateToCreateActionFlow(with state: CreateActionInitialState) {
        let vc = CreateActionFlowBuilder.init(state: .initial(state, self)).build()
        DispatchQueue.main.async {
            self.navigationController?.presentPanModal(vc)
        }
    }
    
    deinit {
        NSLog("deinit \(self)")
    }

    // MARK: - User actions

    @objc
    private func refreshControlActivated() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.refreshControl.endRefreshing()
        }
    }

    @objc
    private func createButtonTapped() {
        guard AuthStorage.shared.isUserAuthorized else {
            return
        }

        guard community?.joined == true else {
            show(type: .error("Пожалуйста, вступите в сообщество чтобы добавлять рецепты"))
            return
        }
        navigateToCreateActionFlow(with: .communityPageRecipeCreation)
    }
}

extension CommunityPageViewController {
    func handleScrollForImage(contentOffset: CGFloat) {
        guard let topConstraint = tableViewTopConstraint?.layoutConstraints.first else {
            return
        }

        let oldOffsetY = (cacheOffset?.y ?? contentOffset)
        var scrollDiff = contentOffset - oldOffsetY

        if abs(scrollDiff) > 100 {
            scrollDiff = scrollDiff > 0 ? 1 : -1
        }

        let isScrollingUp = scrollDiff > 0 && contentOffset + mainView.contentInset.top > 0
        let isScrollingDown = scrollDiff < 0 && contentOffset + mainView.contentInset.top < 0
        var constant = topConstraint.constant

        if isScrollingDown {
            constant = min(imageView.imageHeight - 36, topConstraint.constant + abs(scrollDiff))
        } else if isScrollingUp {
            constant = max(0, topConstraint.constant - abs(scrollDiff))
        }

        if constant != topConstraint.constant {
            topConstraint.constant = constant
            mainView.contentOffset.y = oldOffsetY
        }

        self.cacheOffset = mainView.contentOffset

        setNeedsStatusBarAppearanceUpdate()

        // navigation bar overlay
        if topConstraint.constant <= view.safeAreaInsets.top {
            imageView.isHidden = true
            navigationBarView.backgroundColor = ApronAssets.secondary.color
            navigationItem.title = community?.name ?? ""
        } else {
            imageView.isHidden = false
            navigationItem.title = nil
            navigationBarView.backgroundColor = .clear
        }



        let offsetY = mainView.contentOffset.y + mainView.contentInset.top
        guard offsetY <= 0 else {
            imageView.imageView.layer.transform = CATransform3DIdentity
            return
        }

        let scaleFactor = 1 + (-1 * offsetY / (imageView.imageHeight / 2))
            imageView.imageView.layer.transform = CATransform3DScale(
            CATransform3DIdentity,
            scaleFactor,
            scaleFactor,
            1
        )
    }
}
