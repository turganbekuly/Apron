//
//  ShimmerView.swift
//  DesignSystem
//
//  Created by Akarys Turganbekuly on 08.01.2022.
//

import UIKit
import SkeletonView

public final class ShimmerView: View {
    // MARK: - Public properties

    public var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }

    // MARK: - Private properties

    private var baseSkeletonColor: UIColor {
        return ApronAssets.lightGray.color
    }

    private var secondarySkeletonColor: UIColor? {
        return ApronAssets.lightGray.color.withAlphaComponent(0.3)
    }

    private var shimmer = UIView()
    private var viewMask: UIView?
    private var isStartedSkeleton = false

    // MARK: - Lifecycle

    public override func layoutSubviews() {
        super.layoutSubviews()
        layoutSkeletonIfNeeded()
    }

    public func setup(mask view: UIView, insets: UIEdgeInsets = .zero) {
        removeFromSuperview()
        view.addSubviews(self)
        snp.matchSuperview(insets: insets)
        view.bringSubviewToFront(self)
    }

    public override func setupViews() {
        super.setupViews()
        addSubviews(shimmer)
        shimmer.snp.matchSuperview()

        isSkeletonable = true
        shimmer.isSkeletonable = true
        clipsToBounds = true
        shimmer.backgroundColor = .white
        backgroundColor = .white

        isHidden = true
        alpha = 0.0
    }

    public func startAnimatingSkeleton() {
        isHidden = false
        alpha = 1.0

        guard !isStartedSkeleton else { return }

        layoutSkeletonIfNeeded()
        setNeedsDisplay()
        layoutIfNeeded()

        let gradient = SkeletonGradient(baseColor: baseSkeletonColor, secondaryColor: secondarySkeletonColor)
        let gradientDirection: GradientDirection = Locale.current.isRightToLeft ? .rightLeft : .leftRight
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: gradientDirection)
        showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation, transition: .none)
        isStartedSkeleton = true
    }

    public func stopAnimatingSkeleton(animated: Bool) {
        if animated {
            UIView.animate(
                withDuration: 0.25,
                animations: {
                    self.alpha = 0.0
                },
                completion: { _ in
                    self.isHidden = true
                    self.isStartedSkeleton = false
                    self.hideSkeleton(reloadDataAfter: true, transition: .none)
                }
            )
        } else {
            alpha = 0.0
            isHidden = true
            hideSkeleton(reloadDataAfter: true, transition: .none)
            isStartedSkeleton = false
        }
    }
}

