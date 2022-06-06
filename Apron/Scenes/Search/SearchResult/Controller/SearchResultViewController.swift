//
//  SearchResultViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 14.01.2022.
//

import Models
import DesignSystem
import SnapKit
import UIKit

public protocol SearchResultViewControllerDelegate: AnyObject {
    func controller(_ controller: UIViewController, didSelectRearchResultAtIndexPath indexPath: IndexPath)
}

public final class SearchResultViewController: ViewController {

    public struct Section {
        enum Section {
//            case everything
//            case recipe
            case notFound
        }

        enum Row {
//            case everything
//            case community
//            case recipe
            case notFound
        }

        let section: Section
        let rows: [Row]
    }

    // MARK: - Properties

    public var sections: [Section] = [] {
        didSet {
            mainView.reloadData()
        }
    }

    public var state: State {
        didSet {
            updateState()
        }
    }

    public weak var delegate: SearchResultViewControllerDelegate?

    // MARK: - Views

    public lazy var mainView: SearchResultView = {
        let view = SearchResultView()
        view.dataSource = self
        view.delegate = self
        return view
    }()

    // MARK: - Init

    public init(state: State) {
        self.state = state

        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) {
        nil
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

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Methods

    private func configureViews() {
        [mainView].forEach {
            view.addSubview($0)
        }

        configureColors()
        makeConstraints()
    }

    private func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    private func configureColors() {
        view.backgroundColor = ApronAssets.secondary.color
    }

    deinit {
        NSLog("deinit \(self)")
    }

}

