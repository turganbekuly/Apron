//
//  NotificationBannerManager.swift
//  snoonu-ios
//
//  Created by Konstantin Yunevich on 10.12.2021.
//

import UIKit
import SnapKit

@available(iOS 13.0, *)
public final class NotificationBannerManager {
    // MARK: - Shared

    public static let shared = NotificationBannerManager()

    // MARK: - UI Elements

    private lazy var bannerView = NotificationBannerView()

    // MARK: - Private properties

    private let appWindow: UIWindow? = {
        return UIApplication.shared.connectedScenes
            .first { $0.activationState == .foregroundActive || $0.activationState == .foregroundInactive }
            .map { $0 as? UIWindowScene }
            .map { $0?.windows.first } ?? UIApplication.shared.delegate?.window ?? UIApplication.shared.keyWindow
    }()

    private var statusBarHeight: CGFloat {
        let statusBarHeight = appWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        return statusBarHeight
    }

    private var isAutoDismiss = true
    private var isBannerPresented = false
    private var timer: Timer?

    // MARK: - Init

    private init() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(bannerSwiped(_:)))
        swipeGesture.direction = .up
        bannerView.addGestureRecognizer(swipeGesture)
    }

    // MARK: - Public methods

    public func show(style: NotificationBannerStyle, text: String) {
        guard let appWindow = appWindow, !appWindow.subviews.contains(bannerView) else { return }
        appWindow.addSubview(bannerView)
        bannerView.style = style
        bannerView.text = text

        let fittingSize = CGSize(width: appWindow.frame.width, height: 0)
        let size = bannerView.systemLayoutSizeFitting(
            fittingSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )

        bannerView.frame = CGRect(
            x: 0,
            y: -size.height,
            width: appWindow.frame.width,
            height: size.height
        )

        bannerView.isHidden = false

        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()

        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 1,
            options: [.curveLinear, .allowUserInteraction],
            animations: {
                self.bannerView.frame.origin.y = self.statusBarHeight + 22
            },
            completion: { _ in
                self.isBannerPresented = true
                self.startTimer()
            }
        )
    }

    // MARK: - Private methods

    private func startTimer() {
        let timer = Timer(timeInterval: 2.0, repeats: false, block: { [weak self] _ in
            guard let self = self else { return }
            self.stopTimer()
            self.hideBanner()
        })

        RunLoop.current.add(timer, forMode: .common)
        self.timer = timer
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    @objc
    private func bannerSwiped(_ gesture: UISwipeGestureRecognizer) {
        stopTimer()
        hideBanner()
    }

    private func hideBanner() {
        UIView.animate(
            withDuration: 0.2,
            delay: 0.0,
            options: [.curveLinear],
            animations: {
                self.bannerView.frame.origin.y = -self.bannerView.frame.height
            },
            completion: { _ in
                self.bannerView.isHidden = true
                self.isBannerPresented = false
                self.bannerView.removeFromSuperview()
            }
        )
    }
}
