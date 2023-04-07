//
//  AdBannerCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 01.03.2023.
//

import UIKit
import APRUIKit
import RemoteConfig

protocol AdBannerCellProtocol: AnyObject {
    func adBannerTapped(with model: AdBannerObject)
}

final class AdBannerCell: UITableViewCell {
    // MARK: - Properties

    weak var delegate: AdBannerCellProtocol?

    var itemsCount = 0
    var timer: Timer?
    var timeInterval = 3
    var isAutomatic = true

    enum Constants {
        static let baseBannerHeight: CGFloat = 134
    }

    lazy var multiplier: CGFloat = {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 1.0
        } else {
            return (UIScreen.main.bounds.width / 375)
        }
    }()

    var bannersSection: [AdBannerSection] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold18
        label.textColor = APRAssets.primaryTextMain.color
        label.textAlignment = .left
        return label
    }()

    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: Constants.baseBannerHeight * multiplier
        )
        return flowLayout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        if Locale.current.isRightToLeft {
            collectionView.semanticContentAttribute = .forceRightToLeft
        } else {
            collectionView.semanticContentAttribute = .forceLeftToRight
        }
        return collectionView
    }()

    lazy var pageControl: JXPageControlScale = {
        let view = JXPageControlScale()
        view.activeColor = APRAssets.primaryTextMain.color
        view.inactiveColor = APRAssets.lightGray.color
        view.activeSize = .init(width: 11, height: 5)
        view.inactiveSize = .init(width: 5, height: 5)
        view.columnSpacing = 1.5
        view.hidesForSinglePage = true
        view.clipsToBounds = false
        view.layer.masksToBounds = false

        if Locale.current.isRightToLeft {
            view.transform = .init(scaleX: -1, y: 1)
        } else {
            view.transform = .init(scaleX: 1, y: 1)
        }
        return view
    }()

    // MARK: - Setup Views

    private func setupViews() {
        collectionView.register(AdBannerCollectionCell.self, forCellWithReuseIdentifier: String(describing: AdBannerCollectionCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        contentView.addSubviews(titleLabel, collectionView, pageControl)
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Constants.baseBannerHeight * multiplier)
        }

        pageControl.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(13)
            $0.centerX.equalToSuperview()
        }
    }

    private func configureCell() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    // MARK: - Public methods

    func configure(viewModel: [AdBannerObject]) {
        titleLabel.text = L10n.Main.AdBanner.title
        bannersSection = [.init(section: .banners, rows: viewModel.compactMap { .banner($0) })]
        pageControl.numberOfPages = viewModel.count
        itemsCount = viewModel.count
//        if remoteConfig.isScrollableBannersAutoscrollEnabled {
            isAutomatic = true
            startTimer()
//        }

        if itemsCount != 0 {
            collectionView.scrollToItem(
                at: IndexPath(item: 0, section: 0),
                at: .centeredHorizontally,
                animated: false
            )
            pageControl.currentPage = 0
        }
    }
}

extension AdBannerCell {
    func startTimer() {
        if !isAutomatic { return }
        if itemsCount <= 1 { return }
        cancelTimer()
        timer = Timer(
            timeInterval: Double(timeInterval),
            target: self,
            selector: #selector(timeRepeat),
            userInfo: nil,
            repeats: true
        )
        RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
    }

    func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }

    @objc private func timeRepeat() {
        let currentIndex = getCurrentIndex()
        var targetIndex = currentIndex + 1
        if currentIndex == itemsCount - 1 {
            targetIndex = 0
        }
        collectionView.scrollToItem(
            at: IndexPath(item: targetIndex, section: 0),
            at: .centeredHorizontally,
            animated: true
        )
    }

    func getCurrentIndex() -> Int {
        let itemWidth = flowLayout.itemSize.width
        let offsetX = collectionView.contentOffset.x
        let index = round(offsetX / itemWidth)
        return Int(index)
    }
}
