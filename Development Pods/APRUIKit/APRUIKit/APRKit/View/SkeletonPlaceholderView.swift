//
//  SkeletonPlaceholderView.swift
//  APRUIKit
//
//  Created by Akarys Turganbekuly on 04.10.2022.
//

import UIKit
import SkeletonView

public final class SkeletonPlaceholderView: View {
    public enum SkeletonAnimation {
        case base
        case advanced
    }

    // MARK: - Skeleton configuration

    public var baseSkeletonColor: UIColor {
        return ApronAssets.whiteSmoke.color
    }

    public var secondarySkeletonColor: UIColor? {
        return ApronAssets.snow.color
    }

    // MARK: - Public properties

    var numberOfColumns: Int
    var numberOfRows: Int
    var itemWidth: CGFloat
    var itemHeight: CGFloat
    var cellCornerRadius: CGFloat

    // MARK: - Private properties

    private var verticalInset = 16
    private var horizontalInset = 8

    // MARK: - Public methods

    public func startSkeleton(type: SkeletonAnimation = .base) {
        switch type {
        case .base:
            self.showAnimatedSkeleton(
                usingColor: baseSkeletonColor,
                animation: nil,
                transition: .none
            )
        case .advanced:
            self.showAnimatedGradientSkeleton()
        }
    }

    func stopSkeleton() {
        hideSkeleton()
    }

    // MARK: - UI elements

    private lazy var contentView = View()
    private lazy var generalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = CGFloat(verticalInset)
        stackView.distribution = .fillEqually
        return stackView
    }()

    // MARK: - Init

    public init(
        numberOfColumns: Int,
        numberOfRows: Int,
        itemWidth: CGFloat,
        itemHeight: CGFloat,
        cellCornerRadius: CGFloat = 0,
        verticalInset: Int = 16
    ) {
        self.numberOfColumns = numberOfColumns
        self.numberOfRows = numberOfRows
        self.itemWidth = itemWidth
        self.itemHeight = itemHeight
        self.cellCornerRadius = cellCornerRadius
        self.verticalInset = verticalInset
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI configuration

    public override func setupViews() {
        super.setupViews()
        addSubview(contentView)
        contentView.addSubview(generalStackView)

        isSkeletonable = true
        contentView.isSkeletonable = true
        generalStackView.isSkeletonable = true

        for _ in 0 ..< numberOfRows {
            let horizontalStackView = UIStackView()
            horizontalStackView.axis = .horizontal
            horizontalStackView.isSkeletonable = true
            horizontalStackView.spacing = CGFloat(horizontalInset)
            horizontalStackView.distribution = .fillEqually
            generalStackView.addArrangedSubview(horizontalStackView)

            for _ in 0 ..< numberOfColumns {
                let cell = View()
                cell.isSkeletonable = true
                cell.skeletonCornerRadius = Float(cellCornerRadius)
                cell.layer.cornerRadius = cellCornerRadius
                cell.backgroundColor = ApronAssets.lightGray.color
                cell.frame = .init(x: 0, y: 0, width: itemWidth, height: itemHeight)
                horizontalStackView.addArrangedSubview(cell)
            }
        }
    }

    public override func setupConstraints() {
        super.setupConstraints()

        snp.makeConstraints {
            $0.height.equalTo(
                (numberOfRows * Int(itemHeight)) + (verticalInset * (1 + numberOfRows))
            )
        }

        contentView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalToSuperview()
        }

        generalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

