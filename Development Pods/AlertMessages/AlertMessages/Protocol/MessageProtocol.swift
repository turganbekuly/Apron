//
//  MessageProtocol.swift
//  AKNetwork
//
//  Created by Akarys Turganbekuly on 13.01.2022.
//

import UIKit

public protocol MessageProtocol {
    var icon: UIImage? { get }
    var title: NSAttributedString? { get }
    var subtitle: NSAttributedString? { get }
    var firstButtonTitle: NSAttributedString? { get }
    var secondButtonTitle: NSAttributedString? { get }
    var backgroundColor: UIColor { get }
    var titleColor: UIColor { get }
    var subtitleColor: UIColor? { get }
    var iconColor: UIColor? { get }
}
